Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUKVBCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUKVBCy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 20:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUKVBCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 20:02:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:48871 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261880AbUKVBCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 20:02:52 -0500
Date: Sun, 21 Nov 2004 17:02:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-os@analogic.com, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
In-Reply-To: <Pine.LNX.4.53.0411212343340.17752@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.58.0411211644200.20993@ppc970.osdl.org>
References: <20041120143755.E13550@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com>
 <Pine.LNX.4.58.0411211433540.20993@ppc970.osdl.org>
 <Pine.LNX.4.53.0411212343340.17752@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Nov 2004, Jan Engelhardt wrote:
> 
> And it's specific to GCC. This kinda ruins some tries to get ICC working on the
> kernel tree :)

Ahh, but Intel compiler developers are cunning, and can make (and afaik, 
_did_ make) icc compatible with the good gcc extensions.

And as we all know, the definition of "good gcc extension" really is "the
kernel uses it". (Some of the good ones turned up in C99 and are thus no
longer extensions - obviously gcc wasn't the only compiler that
implemented them).

Good gcc extensions:
 - the inline asm syntax (which could be better, but hey, the gcc syntax
   is certainly not the worst around either)
 - statement expressions (but dammit, it should have used "return" to 
   return the value)
 - short conditionals
 - symbol attributes (sections, "used", asm naming, etc)
 - local labels and computed goto
 - case ranges
 - typeof and alignof.
 - void * arithmetic

BAD gcc extensions:
 - nested functions (gaah)
 - extended lvalues (casts, conditionals and comma-operators as lvalues. 
   They are just too confusing)
 - transparent unions (dammit, you could have done it with overloading
   instead).

		Linus
