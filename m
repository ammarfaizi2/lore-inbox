Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTKMOUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 09:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbTKMOUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 09:20:15 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:47049 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264296AbTKMOUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 09:20:09 -0500
Message-ID: <3FB392EF.6000609@watson.ibm.com>
Date: Thu, 13 Nov 2003 09:19:27 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davem@redhat.com, frankeh@watson.ibm.com
CC: linux-kernel@vger.kernel.org, karim@opersys.com, jmorris@redhat.com,
       zanussi@us.ibm.com
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com>	<200310122323.48885.rasman@uk.ibm.com>	<20031013102520.0671a69d.davem@redhat.com>	<200310141132.28339.rasman@uk.ibm.com> <20031014094424.6cff5697.davem@redhat.com>
In-Reply-To: <20031014094424.6cff5697.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Tue, 14 Oct 2003 11:32:28 +0000
> Richard J Moore <rasman@uk.ibm.com> wrote:
> 
> 
>>Interesting, that assumes sequential processing, if not semi-synchronous 
>>processing of events on the receiver side, which is far from guaranteed when 
>>considering low-level tracing especially for flight-recorder applications.  
> 
> 
> With netlink you may receive the data asynchronously however you
> wish after you've requested a dump.
> 
> I would like to ask that you go study how netlink works and is used
> by things like routing daemons before we discuss this further as
> it looks to me like half the conversation is going to be showing
> you how netlink works.  And hey there's even an RFC on netlink :)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Dave, is there a short write-up (2-3 pages) about netlink.
I like to get a quick understanding about it and how it measures
up to relayfs or vice versa. From some of the discussions here I get
the feeling that they simply might address orthogonal issues.

I recently started using relayfs for various projects after hearing
about it at OLS'03. I often need to get information out of the kernel
(either debugging in interrupt/scheduling context thus preempting use
of printk) or other information for data recording (call it trace or 
whatever).
I don't want to use existing "media" (e.g. syslog) as it either clobbers 
up that media or I have to search for the information I have put in or 
the format (typically char) is not appropriate for my use. I simply want 
a dedicated channel to get to the data in the format that I select.

I found relayfs extremely easy to use. Channel setup is a breeze.
User level consumption is through file operations. IMHO it just simply
can not get any simpler that this....
It works in interrupt/scheduling context. Has extremely low overhead
and is stable. I really would like to see relayfs be picked up.
Its a loadable filesystem that at least to this user has provided
some real value, so why would inclusion be so difficult/objectable.

You providing a short document might help me get an appreciation for
your argument.

-- Hubertus

