Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVCRPXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVCRPXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVCRPXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:23:43 -0500
Received: from jade.aracnet.com ([216.99.193.136]:2700 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261637AbVCRPXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:23:38 -0500
Date: Fri, 18 Mar 2005 07:20:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppc64 build broke between 2.6.11-bk6 and 2.6.11-bk7
Message-ID: <454630000.1111159246@[10.10.2.4]>
In-Reply-To: <16954.41169.665960.627306@alkaid.it.uu.se>
References: <445800000.1111127533@[10.10.2.4]><20050317224409.41f0f5c5.akpm@osdl.org><16954.40800.839009.64848@alkaid.it.uu.se> <16954.41169.665960.627306@alkaid.it.uu.se>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Mikael Pettersson <mikpe@csd.uu.se> wrote (on Friday, March 18, 2005 10:35:13 +0100):

> Mikael Pettersson writes:
>  > Andrew Morton writes:
>  >  > "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>  >  > >
>  >  > > drivers/built-in.o(.text+0x182bc): In function `.matroxfb_probe':
>  >  > > : undefined reference to `.mac_vmode_to_var'
>  >  > > make: *** [.tmp_vmlinux1] Error 1
>  >  > > 
>  >  > > Anyone know what that is?
>  >  > > 
>  >  > 
>  >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/broken-out/fbdev-kconfig-fix-for-macmodes-and-ppc.patch
>  >  > 
>  >  > should fix it.
>  > 
>  > It seems the culprit is "matroxfb-compile-error.patch" which unconditionally adds
>  > macmodes.o to the Makefile line for CONFIG_FB_MATROX. This obviously breaks on !ppc.
> 
> !pmac of course; I assume Martin configured for some kind of POWER box and not a G5.
> 
>  > The patch Andrew mentions above converts the Kconfig entry for FB_MATROX to do a
>  > "select FB_MACMODES if PPC_PMAC", so dropping matroxfb-compile-error.patch should suffice.
> 
> 

Yeah, it's a 4x LPAR on PPC690 Power 4 server.

M.

