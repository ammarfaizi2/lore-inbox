Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTKHS43 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 13:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTKHS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 13:56:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:21423 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261965AbTKHS43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 13:56:29 -0500
Date: Sat, 8 Nov 2003 10:56:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Blanchard <anton@samba.org>
cc: Denis <vda@port.imtp.ilyichevsk.odessa.ua>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-test6: nanosleep+SIGCONT weirdness
In-Reply-To: <20031108184305.GF3440@krispykreme>
Message-ID: <Pine.LNX.4.44.0311081053350.7319-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Nov 2003, Anton Blanchard wrote:
> 
> > I observe some strange behaviour in 2.6-test6 with this small program:
> 
> Something looks wrong with the syscall restart stuff in 2.6, I noticed it
> when doing:

No, the restart code is fine. But the posix timer code looks fundamentally 
broken. Try the patch I just sent, I bet it fixes it.

I can try to fix the posix-timer.c code too, but it looks like even modern
glibc doesn't even export the clock_nanosleep() function. So it might not 
be worth fixing at this point..

		Linus

