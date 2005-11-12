Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVKLW3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVKLW3T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVKLW3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:29:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:6361 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964839AbVKLW3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:29:18 -0500
Subject: Re: Linuv 2.6.15-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200511122237.17157.mbuesch@freenet.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <200511122145.38409.mbuesch@freenet.de>
	 <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
	 <200511122237.17157.mbuesch@freenet.de>
Content-Type: text/plain
Date: Sun, 13 Nov 2005 09:25:35 +1100
Message-Id: <1131834336.7406.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-12 at 22:37 +0100, Michael Buesch wrote:
> On Saturday 12 November 2005 22:00, you wrote:
> > 
> > On Sat, 12 Nov 2005, Michael Buesch wrote:
> > > 
> > > Latest GIT tree does not boot on my G4 PowerBook.
> > 
> > What happens if you do
> > 
> > 	make ARCH=powerpc
> > 
> > and build everything that way (including the "config" phase)?
> 
> I did
> make mrproper
> copy the .config over again
> make ARCH=powerpc menuconfig
> exit and save from menuconfig
> make ARCH=powerpc

You need to disable PREP support when building with ARCH=powerpc for 32
bits, it doesn't build (yet). We should remove it from Kconfig...

Also, there is an issue with the make clean stuff, make sure when
switching archs to also remove arch/powerpc/include/asm symlink before
trying to build.

Ben.


