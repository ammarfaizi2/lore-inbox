Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263963AbUE1Tn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUE1Tn5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUE1TnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:43:08 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:6155 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263834AbUE1Tll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:41:41 -0400
Date: Fri, 28 May 2004 21:41:36 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Chris Osicki <osk@osk.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040528194136.GA5175@pclin040.win.tue.nl>
References: <20040525201616.GE6512@gucio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525201616.GE6512@gucio>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 10:16:16PM +0200, Chris Osicki wrote:

> I recently moved to kernel 2.6.6 from 2.4.26 and noticed that four keys
> on my keyboard stopped working.
> The kernel reports:
> 
> 	keyboard: unrecognized scancode (XX) - ignored
> 
> Where XX is 71, 72, 74, 75.

Hmm. This message seems to be from arch/arm26/lib/kbd.c
Is this message from 2.6.6? Is this an ARM?

> My setup is quite unusual as I'm using Sun type 5 keyboard on my
> PC with a self-made adapter. However, this setup has worked for at 
> least six years with different kernel versions.
> The four keys which don't work anymore are from the function-key-set
> on the left hand side of the keyboard, if you know what a Sun
> keyboard looks like.
> 
> I tried to solve my problem using setkeycodes and tried:
> 
> setkeycodes 71 101
> 
> as 101 was unused keycode (according to getkeycodes)
> 
> getkeycodes reported after that:
> 
> # getkeycodes | grep 0x70
>  0x70:   93 101   0  89   0   0  85  91

Your report is a bit messy. You change things for scancode 0x71 and then
expect the keycode for 0x70 to be changed?

> But showkeys -s shows 0x5b when the key in question is pressed
> (and no release event!!??)

Given a careful and precise report, no doubt it will be clear
what your situation is. Mention architecture, scancodes under 2.4,
scancodes under 2.6.

Andries


[The situation with arch/arm26/lib/kbd.c is funny.
That is the old keyboard code that was removed from
the general kernel code. No doubt it should be updated.]
