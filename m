Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314052AbSDLOi7>; Fri, 12 Apr 2002 10:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314081AbSDLOi6>; Fri, 12 Apr 2002 10:38:58 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:46317 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314052AbSDLOi5>; Fri, 12 Apr 2002 10:38:57 -0400
Date: Fri, 12 Apr 2002 07:38:57 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>,
        Zoltan Menyhart <Zoltan.Menyhart@bull.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Event logging vs enhancing printk
Message-ID: <2238694662.1018597136@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.33.0204120836060.22605-100000@coffee.psychology.mcmaster.ca>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can you make sure that printks are not intermixed ?
> 
> show why this is a serious problem.

I already have - see earlier in this thread. Interspersed output
on SMP machines gives unreadable garbage.
 
>> I was glad to find this error log feature that meets our requirements.
>> It provides us services which reduce our development cost and provides
>> us functionality at "usual industrial level" (see e.g. POSIX).
> 
> frankly, evlog is a solution in search of a problem.  I see no reason
> printk can't do TSC timestamping, more robust and/or efficient buffering,
> auto-classification in klogd, realtime filtering/notification in
> userspace, even delaying of formatting, and logging of binary data.

Of course you could. You could just take the existing mechanism
that's been written for event logging and call it printk, for one.

But the point is to *avoid* dramatic changes to the existing subsystem
to avoid the massive pain of migration (80,000 existing calls), and
an unknown number of sysadmins with scripts to parse stuff out that
you'd drive completely mad (as we did with PTX). In the first post I 
did to this thread is a the reasoning layed out for why not to change
printk.

M.

