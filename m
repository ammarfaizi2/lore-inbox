Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWFODdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWFODdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 23:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWFODdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 23:33:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9354 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751311AbWFODdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 23:33:41 -0400
Message-ID: <4490D515.8070308@engr.sgi.com>
Date: Wed, 14 Jun 2006 20:33:41 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Balbir Singh <balbir@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Sturtivant <csturtiv@sgi.com>
Subject: Re: ON/OFF control of taskstats accounting data at do_exit
References: <449093D6.6000806@engr.sgi.com> <4490CDC2.3090009@watson.ibm.com>
In-Reply-To: <4490CDC2.3090009@watson.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Jay Lan wrote:
>
>> Hi Balbir and Shailabh,
>>
>> I propose we add the capability to turn ON/OFF the multicase of
>> taskstats accounting data at do_exit().
>>  
>>
>
>> This would allow 'chkconfig taskstats' like of control similar
>> to 'chkconfig acct' for BSD accounting. Sometimes sysadmins would
>> wish to turn off sending accounting data to the multicast socket.
>> We have seen many situations that our CSA customers need to turn
>> off CSA for a period of time.
>>
>
>
> What happens to other clients listening to the data ? This sort of
> configuration option would
> again be along the lines of a systemwide change prompted by needs of
> one subsystem but affecting
> all others - something Andrew had recommended against doing while we
> were discussing the per-tgid
> turnoff.
>
> The existing way to solve this is for the listeners to close the
> socket and reopen again later when they
> are interested.  If there are no listeners at all, data won't be sent
> by the kernel anyway. Won't that work
> for you ?

I was talking about turning off system-wise taskstats data preparation and
delivery when every task exits. Sometimes customers like to do some
benchmarking and need to turn off nonessential features.

Are you saying if there is no listener, data will not be assembled and sent
by the kernel? I thought kernel would always send no matter whether there
is listener? I apologize for the noise if i made a mistake.

Regards,
 - jay

>
> --Shailabh
>

