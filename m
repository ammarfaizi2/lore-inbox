Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWILUZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWILUZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWILUZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:25:09 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:27206 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1030415AbWILUZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:25:08 -0400
Message-ID: <450717A5.90509@cfl.rr.com>
Date: Tue, 12 Sep 2006 16:25:09 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: guest01 <guest01@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: OT: calling kernel syscall manually
References: <4506A295.6010206@gmail.com> <1158068045.9189.93.camel@hades.cambridge.redhat.com>
In-Reply-To: <1158068045.9189.93.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2006 20:25:20.0458 (UTC) FILETIME=[91715AA0:01C6D6A9]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14686.003
X-TM-AS-Result: No--11.442300-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What do you mean you have removed the ability to make system calls 
directly?  That makes no sense.  Glibc has to be able to make system 
calls so you can write your own code that does the same thing if you want.

For the OP: you might want to study the glibc sources to see how it 
implements syscall, and mimic that.  IIRC it involves making an int 80 
call on i386.

David Woodhouse wrote:
> The third one has always been broken on i386 for PIC code and was
> pointless anyway, since glibc provides this functionality. The kernel
> method has been removed from userspace visibility all architectures, and
> we plan to remove it entirely in 2.6.19 since it's not at all useful. 
> 
> However, there was a patch which was sneaked to Linus in private which
> reverted that cleanup on i386 and x86_64 and made them visible again --
> but they'll be going away again on those two architectures shortly;
> hopefully before 2.6.18.
> 
> Don't bother with it -- just use glibc's syscall().
> 

