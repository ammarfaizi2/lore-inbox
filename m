Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVCRJfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVCRJfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVCRJfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:35:39 -0500
Received: from aun.it.uu.se ([130.238.12.36]:7055 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261549AbVCRJfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:35:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16954.41169.665960.627306@alkaid.it.uu.se>
Date: Fri, 18 Mar 2005 10:35:13 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: ppc64 build broke between 2.6.11-bk6 and 2.6.11-bk7
In-Reply-To: <16954.40800.839009.64848@alkaid.it.uu.se>
References: <445800000.1111127533@[10.10.2.4]>
	<20050317224409.41f0f5c5.akpm@osdl.org>
	<16954.40800.839009.64848@alkaid.it.uu.se>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson writes:
 > Andrew Morton writes:
 >  > "Martin J. Bligh" <mbligh@aracnet.com> wrote:
 >  > >
 >  > > drivers/built-in.o(.text+0x182bc): In function `.matroxfb_probe':
 >  > > : undefined reference to `.mac_vmode_to_var'
 >  > > make: *** [.tmp_vmlinux1] Error 1
 >  > > 
 >  > > Anyone know what that is?
 >  > > 
 >  > 
 >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/broken-out/fbdev-kconfig-fix-for-macmodes-and-ppc.patch
 >  > 
 >  > should fix it.
 > 
 > It seems the culprit is "matroxfb-compile-error.patch" which unconditionally adds
 > macmodes.o to the Makefile line for CONFIG_FB_MATROX. This obviously breaks on !ppc.

!pmac of course; I assume Martin configured for some kind of POWER box and not a G5.

 > The patch Andrew mentions above converts the Kconfig entry for FB_MATROX to do a
 > "select FB_MACMODES if PPC_PMAC", so dropping matroxfb-compile-error.patch should suffice.
