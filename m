Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759460AbWLDEMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759460AbWLDEMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 23:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759480AbWLDEMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 23:12:47 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:21421 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1759460AbWLDEMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 23:12:46 -0500
Message-ID: <4573A04A.2030909@oracle.com>
Date: Sun, 03 Dec 2006 20:12:58 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: Bela Lubkin <blubkin@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Corey Minyard <minyard@acm.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Joseph Barnett <jbarnett@motorola.com>
Subject: Re: [Openipmi-developer] [PATCH 9/12] IPMI: add pigeonpoint poweroff
References: <20061202043746.GE30531@localdomain><20061203132618.d7d58f59.akpm@osdl.org> <45738959.1000209@acm.org> <20061203185442.33faf1c0.randy.dunlap@oracle.com> <FE74AC4E0A23124DA52B99F17F44159701DBC05B@PA-EXCH03.vmware.com> <45739DB4.6000806@oracle.com>
In-Reply-To: <45739DB4.6000806@oracle.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> Bela Lubkin wrote:
>> Andrew Morton wrote:
>>
>>>> Sometime, please go through the IPMI code looking for all these
>>>> statically-allocated things which are initialised to 0 or NULL and 
>>>> remove
>>>> all those intialisations?  They're unneeded, they increase the vmlinux
>>>> image size and there are quite a number of them.  Thanks.
>>
>> Randy Dunlop replied:
>>
>>> I was just about to send that patch.  Here it is,
>>> on top of the series-of-12.
>> ...
>>> -static int bt_debug = BT_DEBUG_OFF;
>>> +static int bt_debug;
>>
>> Is it wise to significantly degrade code readability to work around a 
>> minor
>> compiler / linker bug?
> 
> Is that the only one that is a problem?
> 
> I don't think it's a problem.  We *know* that static data areas
> are init to 0.  Everything depends on that.  If that didn't work
> it would all break.
> 
> I could say that it's a nice coincidence that BT_DEBUG_OFF == 0,
> but I think that it's more than coincidence.

It's Corey's decision.  However, while code readability is also very
important to me, I disagree with "significantly" above.

-- 
~Randy
