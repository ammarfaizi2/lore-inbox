Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287313AbRL3CjU>; Sat, 29 Dec 2001 21:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287319AbRL3CjK>; Sat, 29 Dec 2001 21:39:10 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:28844
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287313AbRL3CjE>; Sat, 29 Dec 2001 21:39:04 -0500
Date: Sat, 29 Dec 2001 19:38:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: Announce: Kernel Build for 2.5, Release 1.12 is available
Message-ID: <20011230023847.GH21928@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <19466.1009506702@ocs3.intra.ocs.com.au> <10706.1009614471@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10706.1009614471@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 07:27:51PM +1100, Keith Owens wrote:
> Content-Type: text/plain; charset=us-ascii
> 
> On Fri, 28 Dec 2001 13:31:42 +1100, 
> Keith Owens <kaos@ocs.com.au> wrote:
> >This announcement is for the base kbuild 2.5 code, i386 against 2.4.16.
> >Patches for other architectures and kernels will be out later today, it
> >takes time to generate and test patches for 6 architectures against 3
> >different kernel trees.
> 
> All architecture and tree specific patches for kbuild 2.5 are now
> available, if you don't see your arch then nobody has sent me a patch
> yet.
> 
> kbuild-2.5-2.4.16-3		Base code and i386.  Use this patch for
> 				2.5.0 as well.
> kbuild-2.5-2.4.17-1		From 2.4.16 to 2.4.17.
> kbuild-2.5-2.4.18-pre1-1	From 2.4.17 to 2.4.18-pre1.

Okay, here's the patch for PPC for 2.4.18-pre1.  I didn't try, but I
suspect that 2.4.17 will work w/o any additional patches.  This patch
relies on 2.4.16-3, 2.4.16-ppc-1, the patch I sent out prior for 2.4.16,
2.4.17-1 and 2.4.18-pre1-1.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/kernel/Makefile.in 1.1 vs edited =====
--- 1.1/arch/ppc/kernel/Makefile.in	Sat Dec 29 00:47:34 2001
+++ edited/arch/ppc/kernel/Makefile.in	Sat Dec 29 17:52:00 2001
@@ -19,10 +19,9 @@
 select(CONFIG_WALNUT walnut_setup.o)
 select(CONFIG_WALNUT CONFIG_PCI galaxy_pci.o)
 select(CONFIG_6xx l2cr.o)
-select(CONFIG_ALL_PPC pmac_pic.o pmac_setup.o pmac_time.o prom.o feature.o
-	pmac_pci.o chrp_setup.o chrp_time.o chrp_pci.o open_pic.o
-	indirect_pci.o i8259.o prep_pci.o prep_time.o prep_nvram.o
-	prep_setup.o)
+select(CONFIG_ALL_PPC pmac_pic.o pmac_setup.o pmac_time.o prom.o pmac_feature.o
+	pmac_pci.o chrp_setup.o chrp_time.o chrp_pci.o open_pic.o i8259.o
+	indirect_pci.o prep_pci.o prep_time.o prep_nvram.o prep_setup.o)
 select(CONFIG_ALL_PPC CONFIG_SMP pmac_smp.o chrp_smp.o)
 select(CONFIG_BOOTX_TEXT btext.o)
 select(CONFIG_NVRAM pmac_nvram.o)
