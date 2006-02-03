Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWBCKfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWBCKfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWBCKfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:35:53 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:37062 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932155AbWBCKfw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:35:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GFRtmOTqttM2ZxHWmFgB1tn+NfKHpzx9Fi1W8HOlXP7iMHx13PO2MvFsPDHHIanGAVkxe0PyDG8fvFCQ7llLzQL0tvtLcYgpvwaBHeId+wBdF/tF+c8rdtH+Si5+FsEER7NKylIVk7i/nfyJeGTR9XY2/yRa1Yf8divh9N2MN8M=
Message-ID: <e3e24c6a0602030235l740609b6k872ebef2a2a8f9c9@mail.gmail.com>
Date: Fri, 3 Feb 2006 16:05:50 +0530
From: Vishal Soni <vishal.linux@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: calling bios interrupt
In-Reply-To: <43E1B93A.5000603@slovanet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43E1B93A.5000603@slovanet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Jozef Kutej <jozef.kutej@slovanet.net> wrote:
> Hello.
>
> Can someone help me solve my problem with on board watch dog timer that
> need to call bios interrupt? Here's how to update watch dog timer.
>
> mov ax,6f02h
> mov bl, 30      ;number of seconds
> int 15h
>
> How can i do this in kernel so that i can write wdt driver?
>
> Thank you.
CMIIW, is it not that for using BIOS interrupt one has to do the same
by entering in real mode or else real mode interrupt handler, would be
replaced with an appropriate exception handler by Linux.
check this : http://www.mega-tokyo.com/forum/index.php?board=1;action=display;threadid=8997;start=0#msg77808

like when i try to use int 10h in one of my kernel modules and try to
insert it with insmod i get Floating Point Exception.

And one has to use vm86() system call and save the register context as
given in below url to achieve the results.
http://x86.ddj.com/articles/pmbasics/tspec_a1_doc.htm
>
> Jozef Kutej.
> -
