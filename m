Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbUKGCq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbUKGCq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 21:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbUKGCq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 21:46:26 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43206 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261520AbUKGCqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 21:46:23 -0500
Subject: Re: [no problem] PC110 broke 2.6.9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, vojtech@ucw.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411061529200.2223@ppc970.osdl.org>
References: <20041106232228.GA9446@apps.cwi.nl>
	 <Pine.LNX.4.58.0411061529200.2223@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099791769.5564.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 07 Nov 2004 01:42:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-11-06 at 23:37, Linus Torvalds wrote:
> Ahh.. Interesting. One improvement might be to make sure that this driver 
> links in very late in the game, so that if any other drivers have 
> allocated the IO, at least it won't override that. Also, it might make 
> sense to say that the dang thing can share interrupts.

It can't share interrupts.

> But yes, we should probably make sure to make it harder to enable the
> driver by mistake, and try to do minimal probing of it. I have no idea how
> to probe for the thing, though.

I never found anything. 

> Alan, Vojtech, do you have any register information on this thing? Some 
> docs to try to realize when it's not there? Or some other way to detect 
> the IBM PC110 hardware (BIOS strings, something?)

I have some register info, the driver is done by disassembly of the
PC-DOS
driver IBM shipped with the PC110. It's a pre pci, pre dmi machine so
there aren't any obvious sane ways to probe. Its not something you'd
want to build
in as opposed to modular on any other system but the PC110

