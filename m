Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSJ0VXb>; Sun, 27 Oct 2002 16:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSJ0VXb>; Sun, 27 Oct 2002 16:23:31 -0500
Received: from chunk.voxel.net ([207.99.115.133]:32698 "EHLO chunk.voxel.net")
	by vger.kernel.org with ESMTP id <S262620AbSJ0VX3>;
	Sun, 27 Oct 2002 16:23:29 -0500
Date: Sun, 27 Oct 2002 16:29:50 -0500
From: Andres Salomon <dilinger@mp3revolution.net>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.44-ac4
Message-ID: <20021027212950.GA15937@chunk.voxel.net>
References: <200210262357.g9QNvMP00380@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <200210262357.g9QNvMP00380@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux chunk 2.4.18-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following is necessary for sparc64 compilation.

On Sat, Oct 26, 2002 at 07:57:22PM -0400, Alan Cox wrote:
> 
> ** I strongly recommend saying N to IDE TCQ options otherwise this
>    should hopefully build and run happily.
> 
> Most stuff is now back running at least as well as in 2.5.42-ac (u14f being
> the exception). This fixes a load more small things and resynchronizes the
> mmuless Linux stuff. That is now pretty close (IMHO) to mergable.
> 
> Linux 2.5.44-ac4
> o	Add 2.4.20-ac style /proc for ht info		(Robert Love)
> o	Fix bd_blocksize setting case			(Hugh Dickins)
> o	PCI bus setup now __devinit for hotplug		(Ivan Kokshaysky)
> o	make xconfig should work again			(Alex Riesen)
> o	Merge uclinux resync. This is now way cleaner	(Christoph Hellwig)
> o	Update znet driver				(Marc Zyngier)
> o	More i2o_scsi tidying				(Christoph Hellwig)
> o	Fix a leak in the device mapper			(Joe Thornber)
> o	Fix missed section name change			(Peter Chubb)
> o	Fix a bug in the APM update, add comments	(me)
> o	Merge block layer changes			(Jens Axboe)
> 	| Should fix eject panic
> o	Fix warnings in baycom_epp			(me)
> o	Fix warnings in fmvj18x, and timer_sync bug	(me)
> o	Fix sim710 warnings				(me)
> o	Fix pas16/t128 warnings				(me)
> o	Allow both mmio and pio g_NCR5380 builds at once(me)
> o	Remove unused code from axnet_cs		(me)
> o	Fix warning in pc300 driver			(me)
> o	Clean up qlogicfas drivers somewhat		(me)
> o	Fix megaraid build for pci bios changes		(me)
> o	Fix cpu count weird reporting 			(Dave Jones)
> o	Clean up capabilities printing			(Dave Jones)
> o	Silence mtrr debugging printk			(Dave Jones)
> o	Split machine check per processor		(Dave Jones)
> o	Update mpt fusion for new slave_attach handling	(Peter Chubb)
> o       Initial speedstep testing for VIA chipset boards(Bob Renwick)
> 
> Linux 2.5.44-ac3
[...]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
It's not denial.  I'm just selective about the reality I accept.
	-- Bill Watterson

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bug.h.diff"

--- a/include/asm-sparc64/bug.h	2002-10-27 13:02:47.000000000 -0500
+++ b/include/asm-sparc64/bug.h	2002-10-27 13:03:27.000000000 -0500
@@ -13,5 +13,6 @@
 #define BUG()		__builtin_trap()
 #endif
 
+#define PAGE_BUG(page) BUG()
 
 #endif

--tKW2IUtsqtDRztdT--
