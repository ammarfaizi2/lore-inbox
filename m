Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUESO3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUESO3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 10:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbUESO3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 10:29:19 -0400
Received: from [213.13.117.218] ([213.13.117.218]:6620 "EHLO
	mail.paradigma.co.pt") by vger.kernel.org with ESMTP
	id S264206AbUESO0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 10:26:33 -0400
Date: Wed, 19 May 2004 15:17:06 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com
Subject: [2.4][PATCH] cleanup double semicolons
Message-ID: <20040519141706.GA17449@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Hi,


Being in bed recovering from surgery is surely enough to drive anyone  
nuts so I decided to go after double semi-colons, to kill off a couple  
hours and try to maintain mental sanity ;-)

Since the big patch is rather, well, big -- touching 78 files -- I split  
it into smaller chunks, one per each directory it applies to, to make it  
easier to review/merge. It is against 2.4.27-pre2 but applies cleanly to  
-pre3, just checked and rediffed the chunks that failed.

I'm sending off a separate mail to cleanup the few remaining cases in  
2.6, too.

Please review.


		Nuno

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-arch-arm"

diff -pruN linux-2.4.26-vanilla/arch/arm/kernel/signal.c linux-2.4.26/arch/arm/kernel/signal.c
--- linux-2.4.26-vanilla/arch/arm/kernel/signal.c	2004-05-18 18:30:48.949253568 +0100
+++ linux-2.4.26/arch/arm/kernel/signal.c	2004-05-18 18:09:05.296438920 +0100
@@ -53,7 +53,7 @@ asmlinkage int do_signal(sigset_t *oldse
 
 int copy_siginfo_to_user(siginfo_t *to, siginfo_t *from)
 {
-	int err = -EFAULT;;
+	int err = -EFAULT;
 
 	if (!access_ok (VERIFY_WRITE, to, sizeof(siginfo_t)))
 		goto out;
diff -pruN linux-2.4.26-vanilla/arch/arm/kernel/sys_arm.c linux-2.4.26/arch/arm/kernel/sys_arm.c
--- linux-2.4.26-vanilla/arch/arm/kernel/sys_arm.c	2001-07-04 22:56:44.000000000 +0100
+++ linux-2.4.26/arch/arm/kernel/sys_arm.c	2004-05-18 18:08:51.802490312 +0100
@@ -99,7 +99,7 @@ asmlinkage int old_mmap(struct mmap_arg_
 	struct mmap_arg_struct a;
 
 	if (copy_from_user(&a, arg, sizeof(a)))
-		goto out;;
+		goto out;
 
 	error = -EINVAL;
 	if (a.offset & ~PAGE_MASK)

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-arch-ia64"

diff -pruN linux-2.4.26-vanilla/arch/ia64/mm/init.c linux-2.4.26/arch/ia64/mm/init.c
--- linux-2.4.26-vanilla/arch/ia64/mm/init.c	2004-05-18 18:31:07.402448256 +0100
+++ linux-2.4.26/arch/ia64/mm/init.c	2004-05-18 18:10:11.358395976 +0100
@@ -498,7 +498,7 @@ arch_memmap_init (memmap_init_callback_t
 		efi_memmap_walk(virtual_memmap_init, &args);
 	}
 
-	return page_to_phys(end-1) + PAGE_SIZE;;
+	return page_to_phys(end-1) + PAGE_SIZE;
 }
 
 int
diff -pruN linux-2.4.26-vanilla/arch/ia64/sn/fakeprom/fw-emu.c linux-2.4.26/arch/ia64/sn/fakeprom/fw-emu.c
--- linux-2.4.26-vanilla/arch/ia64/sn/fakeprom/fw-emu.c	2004-05-18 18:31:04.249927512 +0100
+++ linux-2.4.26/arch/ia64/sn/fakeprom/fw-emu.c	2004-05-18 18:11:21.872676176 +0100
@@ -397,7 +397,7 @@ efi_set_virtual_address_map(void)
         fix_virt_function_pointer((void**)&runtime->set_variable);
         fix_virt_function_pointer((void**)&runtime->get_next_high_mono_count);
         fix_virt_function_pointer((void**)&runtime->reset_system);
-        return EFI_SUCCESS;;
+        return EFI_SUCCESS;
 }
 
 void
diff -pruN linux-2.4.26-vanilla/arch/ia64/sn/io/machvec/pci_bus_cvlink.c linux-2.4.26/arch/ia64/sn/io/machvec/pci_bus_cvlink.c
--- linux-2.4.26-vanilla/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	2004-05-18 18:31:04.261925688 +0100
+++ linux-2.4.26/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	2004-05-18 18:11:11.544246336 +0100
@@ -63,7 +63,7 @@ set_isPIC(struct sn_device_sysdata *devi
 	pciio_info_t pciio_info = pciio_info_get(device_sysdata->vhdl);
 	pcibr_soft_t pcibr_soft = (pcibr_soft_t) pciio_info_mfast_get(pciio_info);
 
-	device_sysdata->isPIC = IS_PIC_SOFT(pcibr_soft);;
+	device_sysdata->isPIC = IS_PIC_SOFT(pcibr_soft);
 }
 
 /*
diff -pruN linux-2.4.26-vanilla/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c linux-2.4.26/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c
--- linux-2.4.26-vanilla/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	2004-05-18 18:31:04.281922648 +0100
+++ linux-2.4.26/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	2004-05-18 18:10:28.654766528 +0100
@@ -1713,7 +1713,7 @@ pcibr_attach2(vertex_hdl_t xconn_vhdl, b
 
     /* Block off the range used by PROM. */
     res->start = prom_base_addr;
-    res->end = prom_base_addr + (prom_base_size - 1);;
+    res->end = prom_base_addr + (prom_base_size - 1);
     status = request_resource(&pcibr_soft->bs_mem_win_root_resource, res);
     if (status)
         panic("PCIBR:Unable to request_resource()\n");
diff -pruN linux-2.4.26-vanilla/arch/ia64/sn/io/sn2/pciio.c linux-2.4.26/arch/ia64/sn/io/sn2/pciio.c
--- linux-2.4.26-vanilla/arch/ia64/sn/io/sn2/pciio.c	2004-05-18 18:31:04.290921280 +0100
+++ linux-2.4.26/arch/ia64/sn/io/sn2/pciio.c	2004-05-18 18:10:52.691112448 +0100
@@ -989,7 +989,7 @@ pciio_device_win_alloc(struct resource *
 		win_alloc->wa_pages = size;
 	}
 
-	return new_res->start;;
+	return new_res->start;
 }
 
 /*

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-arch-m68k"

diff -pruN linux-2.4.26-vanilla/arch/m68k/mvme16x/16xints.c linux-2.4.26/arch/m68k/mvme16x/16xints.c
--- linux-2.4.26-vanilla/arch/m68k/mvme16x/16xints.c	1998-12-17 17:06:30.000000000 +0000
+++ linux-2.4.26/arch/m68k/mvme16x/16xints.c	2004-05-18 18:11:42.306569752 +0100
@@ -97,7 +97,7 @@ void mvme16x_free_irq(unsigned int irq, 
 		printk("%s: Removing probably wrong IRQ %d from %s\n",
 		       __FUNCTION__, irq, irq_tab[irq-64].devname);
 
-	irq_tab[irq-64].handler = mvme16x_defhand;;
+	irq_tab[irq-64].handler = mvme16x_defhand;
 	irq_tab[irq-64].flags   = IRQ_FLG_STD;
 	irq_tab[irq-64].dev_id  = NULL;
 	irq_tab[irq-64].devname = NULL;

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-arch-ppc"

diff -pruN linux-2.4.26-vanilla/arch/ppc/mm/pgtable.c linux-2.4.26/arch/ppc/mm/pgtable.c
--- linux-2.4.26-vanilla/arch/ppc/mm/pgtable.c	2004-05-18 18:31:08.892221776 +0100
+++ linux-2.4.26/arch/ppc/mm/pgtable.c	2004-05-18 18:09:25.411380984 +0100
@@ -72,7 +72,7 @@ void setbat(int index, unsigned long vir
 void *
 ioremap(phys_addr_t addr, unsigned long size)
 {
-	phys_addr_t addr64 = fixup_bigphys_addr(addr, size);;
+	phys_addr_t addr64 = fixup_bigphys_addr(addr, size);
 
 	return ioremap64(addr64, size);
 }

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-arch-ppc64"

diff -pruN linux-2.4.26-vanilla/arch/ppc64/kernel/idle.c linux-2.4.26/arch/ppc64/kernel/idle.c
--- linux-2.4.26-vanilla/arch/ppc64/kernel/idle.c	2004-05-18 18:31:09.091191528 +0100
+++ linux-2.4.26/arch/ppc64/kernel/idle.c	2004-05-18 18:12:02.681472296 +0100
@@ -157,7 +157,7 @@ int idle_default(void)
 int idle_dedicated(void)
 {
 	long oldval;
-	struct paca_struct *lpaca = get_paca(), *ppaca;;
+	struct paca_struct *lpaca = get_paca(), *ppaca;
 	unsigned long start_snooze;
 
 	ppaca = &paca[(lpaca->xPacaIndex) ^ 1];

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-arch-sh"

diff -pruN linux-2.4.26-vanilla/arch/sh/mm/fault.c linux-2.4.26/arch/sh/mm/fault.c
--- linux-2.4.26-vanilla/arch/sh/mm/fault.c	2004-05-18 18:30:54.613392488 +0100
+++ linux-2.4.26/arch/sh/mm/fault.c	2004-05-18 18:08:43.330778208 +0100
@@ -71,7 +71,7 @@ good_area:
 		if (!vma || vma->vm_start != start)
 			goto bad_area;
 		if (!(vma->vm_flags & VM_WRITE))
-			goto bad_area;;
+			goto bad_area;
 	}
 	return 1;
 

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-arch-sparc64"

diff -pruN linux-2.4.26-vanilla/arch/sparc64/solaris/timod.c linux-2.4.26/arch/sparc64/solaris/timod.c
--- linux-2.4.26-vanilla/arch/sparc64/solaris/timod.c	2002-07-17 17:23:20.000000000 +0100
+++ linux-2.4.26/arch/sparc64/solaris/timod.c	2004-05-18 18:12:15.097584760 +0100
@@ -300,7 +300,7 @@ static int timod_optmgmt(unsigned int fd
 		SOLD("calling GETSOCKOPT");
 		set_fs(KERNEL_DS);
 		error = sys_socketcall(SYS_GETSOCKOPT, args);
-		set_fs(old_fs);;
+		set_fs(old_fs);
 		if (error) {
 			failed = TBADOPT;
 			break;

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-arch-x86_64"

diff -pruN linux-2.4.26-vanilla/arch/x86_64/kernel/acpitable.h linux-2.4.26/arch/x86_64/kernel/acpitable.h
--- linux-2.4.26-vanilla/arch/x86_64/kernel/acpitable.h	2003-06-28 22:31:32.000000000 +0100
+++ linux-2.4.26/arch/x86_64/kernel/acpitable.h	2004-05-18 18:12:36.000407048 +0100
@@ -31,7 +31,7 @@ struct acpi_table_header {		/* ACPI comm
 	u32 oem_revision;		/* OEM revision number */
 	char asl_compiler_id[4];	/* ASL compiler vendor ID */
 	u32 asl_compiler_revision;	/* ASL compiler revision number */
-} __attribute__ ((packed));;
+} __attribute__ ((packed));
 
 enum {
 	ACPI_APIC = 0,
@@ -53,7 +53,7 @@ struct acpi_table_madt {
 		u32 pcat_compat:1;
 		u32 reserved:31;
 	} flags __attribute__ ((packed));
-} __attribute__ ((packed));;
+} __attribute__ ((packed));
 
 enum {
 	ACPI_MADT_LAPIC = 0,

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-acpi"

diff -pruN linux-2.4.26-vanilla/drivers/acpi/system.c linux-2.4.26/drivers/acpi/system.c
--- linux-2.4.26-vanilla/drivers/acpi/system.c	2004-05-18 18:31:12.953604352 +0100
+++ linux-2.4.26/drivers/acpi/system.c	2004-05-18 18:18:51.145376344 +0100
@@ -799,7 +799,7 @@ acpi_system_read_alarm (
 	if (acpi_gbl_FADT->mon_alrm)
 		mo = CMOS_READ(acpi_gbl_FADT->mon_alrm);
 	else
-		mo = CMOS_READ(RTC_MONTH);;
+		mo = CMOS_READ(RTC_MONTH);
 	if (acpi_gbl_FADT->century)
 		yr = CMOS_READ(acpi_gbl_FADT->century) * 100 + CMOS_READ(RTC_YEAR);
 	else

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-block"

diff -pruN linux-2.4.26-vanilla/drivers/block/cpqarray.c linux-2.4.26/drivers/block/cpqarray.c
--- linux-2.4.26-vanilla/drivers/block/cpqarray.c	2004-05-18 18:31:09.415142280 +0100
+++ linux-2.4.26/drivers/block/cpqarray.c	2004-05-18 18:27:05.884164616 +0100
@@ -2358,7 +2358,7 @@ static void getgeometry(int ctlr)
                 return;
         }
 
-	info_p->log_drives = id_ctlr_buf->nr_drvs;;
+	info_p->log_drives = id_ctlr_buf->nr_drvs;
 	for(i=0;i<4;i++)
 		info_p->firm_rev[i] = id_ctlr_buf->firm_rev[i];
 	info_p->ctlr_sig = id_ctlr_buf->cfg_sig;

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-cdrom"

diff -pruN linux-2.4.26-vanilla/drivers/cdrom/sbpcd.c linux-2.4.26/drivers/cdrom/sbpcd.c
--- linux-2.4.26-vanilla/drivers/cdrom/sbpcd.c	2001-10-25 21:58:35.000000000 +0100
+++ linux-2.4.26/drivers/cdrom/sbpcd.c	2004-05-18 18:27:18.658222664 +0100
@@ -5183,7 +5183,7 @@ static int sbp_data(struct request *req)
 			for ( ; try!=0;try--)
 			{
 				j=inb(CDi_status);
-				if (!(j&s_not_data_ready)) break;;
+				if (!(j&s_not_data_ready)) break;
 				if (!(j&s_not_result_ready)) break;
 				if (fam0LV_drive) if (j&s_attention) break;
 			}

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-char"

diff -pruN linux-2.4.26-vanilla/drivers/char/console.c linux-2.4.26/drivers/char/console.c
--- linux-2.4.26-vanilla/drivers/char/console.c	2004-05-18 18:31:04.909827192 +0100
+++ linux-2.4.26/drivers/char/console.c	2004-05-18 18:21:01.486561472 +0100
@@ -2260,7 +2260,7 @@ int tioclinux(struct tty_struct *tty, un
 			break;
 		case 10:
 			set_vesa_blanking(arg);
-			break;;
+			break;
 		case 11:	/* set kmsg redirect */
 			if (!capable(CAP_SYS_ADMIN)) {
 				ret = -EPERM;
diff -pruN linux-2.4.26-vanilla/drivers/char/drm/drm_fops.h linux-2.4.26/drivers/char/drm/drm_fops.h
--- linux-2.4.26-vanilla/drivers/char/drm/drm_fops.h	2004-05-18 18:31:04.919825672 +0100
+++ linux-2.4.26/drivers/char/drm/drm_fops.h	2004-05-18 18:19:12.279163520 +0100
@@ -168,7 +168,7 @@ ssize_t DRM(read)(struct file *filp, cha
 	}
 
 	wake_up_interruptible(&dev->buf_writers);
-	return DRM_MIN(avail, count);;
+	return DRM_MIN(avail, count);
 }
 
 int DRM(write_string)(drm_device_t *dev, const char *s)
diff -pruN linux-2.4.26-vanilla/drivers/char/drm/drm_memory.h linux-2.4.26/drivers/char/drm/drm_memory.h
--- linux-2.4.26-vanilla/drivers/char/drm/drm_memory.h	2004-05-18 18:31:09.436139088 +0100
+++ linux-2.4.26/drivers/char/drm/drm_memory.h	2004-05-18 18:19:03.365518600 +0100
@@ -393,7 +393,7 @@ int DRM(free_agp)(agp_memory *handle, in
 	if (!handle) {
 		DRM_MEM_ERROR(DRM_MEM_TOTALAGP,
 			      "Attempt to free NULL AGP handle\n");
-		return retval;;
+		return retval;
 	}
 
 	if (DRM(agp_free_memory)(handle)) {
diff -pruN linux-2.4.26-vanilla/drivers/char/drm-4.0/fops.c linux-2.4.26/drivers/char/drm-4.0/fops.c
--- linux-2.4.26-vanilla/drivers/char/drm-4.0/fops.c	2002-03-09 23:40:52.000000000 +0000
+++ linux-2.4.26/drivers/char/drm-4.0/fops.c	2004-05-18 18:20:34.224705904 +0100
@@ -187,7 +187,7 @@ ssize_t drm_read(struct file *filp, char
 	}
 	
 	wake_up_interruptible(&dev->buf_writers);
-	return DRM_MIN(avail, count);;
+	return DRM_MIN(avail, count);
 }
 
 int drm_write_string(drm_device_t *dev, const char *s)
diff -pruN linux-2.4.26-vanilla/drivers/char/drm-4.0/memory.c linux-2.4.26/drivers/char/drm-4.0/memory.c
--- linux-2.4.26-vanilla/drivers/char/drm-4.0/memory.c	2004-05-18 18:31:09.459135592 +0100
+++ linux-2.4.26/drivers/char/drm-4.0/memory.c	2004-05-18 18:20:45.114050472 +0100
@@ -375,7 +375,7 @@ int drm_free_agp(agp_memory *handle, int
 	if (!handle) {
 		DRM_MEM_ERROR(DRM_MEM_TOTALAGP,
 			      "Attempt to free NULL AGP handle\n");
-		return retval;;
+		return retval;
 	}
 	
 	if (drm_agp_free_memory(handle)) {
diff -pruN linux-2.4.26-vanilla/drivers/char/dz.c linux-2.4.26/drivers/char/dz.c
--- linux-2.4.26-vanilla/drivers/char/dz.c	2004-05-18 18:31:09.470133920 +0100
+++ linux-2.4.26/drivers/char/dz.c	2004-05-18 18:19:21.768720888 +0100
@@ -421,7 +421,7 @@ static void do_softint(void *private_dat
 static void do_serial_hangup(void *private_data)
 {
 	struct dz_serial *info = (struct dz_serial *) private_data;
-	struct tty_struct *tty = info->tty;;
+	struct tty_struct *tty = info->tty;
 
 	if (!tty)
 		return;
diff -pruN linux-2.4.26-vanilla/drivers/char/ftape/compressor/lzrw3.c linux-2.4.26/drivers/char/ftape/compressor/lzrw3.c
--- linux-2.4.26-vanilla/drivers/char/ftape/compressor/lzrw3.c	1997-11-25 22:45:27.000000000 +0000
+++ linux-2.4.26/drivers/char/ftape/compressor/lzrw3.c	2004-05-18 18:20:15.530547848 +0100
@@ -701,7 +701,7 @@ ULONG *p_dst_len;
           /* been postponed for lack of bytes.                                */
           if (literals>0)
             {
-             register UBYTE *r=p_ziv-literals;;
+             register UBYTE *r=p_ziv-literals;
              hash[HASH(r)]=r;
              if (literals==2)
                 {r++; hash[HASH(r)]=r;}
diff -pruN linux-2.4.26-vanilla/drivers/char/joystick/gf2k.c linux-2.4.26/drivers/char/joystick/gf2k.c
--- linux-2.4.26-vanilla/drivers/char/joystick/gf2k.c	2001-09-12 23:34:06.000000000 +0100
+++ linux-2.4.26/drivers/char/joystick/gf2k.c	2004-05-18 18:21:11.524035544 +0100
@@ -107,7 +107,7 @@ static int gf2k_read_packet(struct gamep
 	__cli();
 
 	gameport_trigger(gameport);
-	v = gameport_read(gameport);;
+	v = gameport_read(gameport);
 
 	while (t > 0 && i < length) {
 		t--; u = v;
diff -pruN linux-2.4.26-vanilla/drivers/char/mwave/smapi.c linux-2.4.26/drivers/char/mwave/smapi.c
--- linux-2.4.26-vanilla/drivers/char/mwave/smapi.c	2003-06-28 22:31:32.000000000 +0100
+++ linux-2.4.26/drivers/char/mwave/smapi.c	2004-05-18 18:20:24.748146560 +0100
@@ -448,7 +448,7 @@ int smapi_set_DSP_cfg(void)
 	if (bRC) goto exit_smapi_request_error;
 
 	if (mwave_3780i_io) {
-		usDI = dspio_index;;
+		usDI = dspio_index;
 	}
 	if (mwave_3780i_irq) {
 		usSI = (usSI & 0xff00) | mwave_3780i_irq;
diff -pruN linux-2.4.26-vanilla/drivers/char/qtronix.c linux-2.4.26/drivers/char/qtronix.c
--- linux-2.4.26-vanilla/drivers/char/qtronix.c	2003-06-28 22:33:59.000000000 +0100
+++ linux-2.4.26/drivers/char/qtronix.c	2004-05-18 18:19:35.181681808 +0100
@@ -206,7 +206,7 @@ static void kbd_int_handler(int irq, voi
 	unsigned char int_status;
 
 	cir = (struct cir_port *)dev_id;
-	int_status = get_int_status(cir);;
+	int_status = get_int_status(cir);
 	if (int_status & 0x4) {
 		clear_fifo(cir);
 		return;

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-fs"

diff -pruN linux-2.4.26-vanilla/fs/intermezzo/journal_xfs.c linux-2.4.26/fs/intermezzo/journal_xfs.c
--- linux-2.4.26-vanilla/fs/intermezzo/journal_xfs.c	2003-06-28 22:31:34.000000000 +0100
+++ linux-2.4.26/fs/intermezzo/journal_xfs.c	2004-05-18 18:05:00.713621160 +0100
@@ -58,7 +58,7 @@ static unsigned long presto_xfs_freespac
         VFS_STATVFS(vfsp, &stat, NULL, rc);
         avail = statp.f_bfree;
 
-        return sbp->sb_fdblocks;; 
+        return sbp->sb_fdblocks;
 #endif
         return 0x0fffffff;
 }
diff -pruN linux-2.4.26-vanilla/fs/partitions/ldm.c linux-2.4.26/fs/partitions/ldm.c
--- linux-2.4.26-vanilla/fs/partitions/ldm.c	2003-06-28 22:34:01.000000000 +0100
+++ linux-2.4.26/fs/partitions/ldm.c	2004-05-18 18:05:18.537911456 +0100
@@ -634,7 +634,7 @@ static BOOL ldm_create_partition (struct
 {
 	int disk_minor;
 
-	BUG_ON (!hd);;
+	BUG_ON (!hd);
 	BUG_ON (!hd->part);
 
 	/* Get the minor number of the parent device

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-hotplug"

diff -pruN linux-2.4.26-vanilla/drivers/hotplug/cpqphp_core.c linux-2.4.26/drivers/hotplug/cpqphp_core.c
--- linux-2.4.26-vanilla/drivers/hotplug/cpqphp_core.c	2004-05-18 18:31:05.028809104 +0100
+++ linux-2.4.26/drivers/hotplug/cpqphp_core.c	2004-05-18 18:29:25.433949824 +0100
@@ -1316,7 +1316,7 @@ static int one_time_init(void)
 	cpqhp_rom_start = ioremap(ROM_PHY_ADDR, ROM_PHY_LEN);
 	if (!cpqhp_rom_start) {
 		err ("Could not ioremap memory region for ROM\n");
-		retval = -EIO;;
+		retval = -EIO;
 		goto error;
 	}
 	
@@ -1327,14 +1327,14 @@ static int one_time_init(void)
 	smbios_table = detect_SMBIOS_pointer(cpqhp_rom_start, cpqhp_rom_start + ROM_PHY_LEN);
 	if (!smbios_table) {
 		err ("Could not find the SMBIOS pointer in memory\n");
-		retval = -EIO;;
+		retval = -EIO;
 		goto error;
 	}
 
 	smbios_start = ioremap(readl(smbios_table + ST_ADDRESS), readw(smbios_table + ST_LENGTH));
 	if (!smbios_start) {
 		err ("Could not ioremap memory region taken from SMBIOS values\n");
-		retval = -EIO;;
+		retval = -EIO;
 		goto error;
 	}
 

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-ide"

diff -pruN linux-2.4.26-vanilla/drivers/ide/pci/trm290.c linux-2.4.26/drivers/ide/pci/trm290.c
--- linux-2.4.26-vanilla/drivers/ide/pci/trm290.c	2003-06-28 22:33:59.000000000 +0100
+++ linux-2.4.26/drivers/ide/pci/trm290.c	2004-05-18 18:13:04.304104232 +0100
@@ -280,7 +280,7 @@ static int trm290_ide_dma_begin (ide_dri
 static int trm290_ide_dma_end (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	u16 status = 0;;
+	u16 status = 0;
 
 	drive->waiting_for_dma = 0;
 	/* purge DMA mappings */
diff -pruN linux-2.4.26-vanilla/drivers/ide/raid/hptraid.c linux-2.4.26/drivers/ide/raid/hptraid.c
--- linux-2.4.26-vanilla/drivers/ide/raid/hptraid.c	2004-05-18 18:31:09.521126168 +0100
+++ linux-2.4.26/drivers/ide/raid/hptraid.c	2004-05-18 18:13:12.144912248 +0100
@@ -304,7 +304,7 @@ static int hptraid0_compute_request (str
 		return -1;
 	}
 			
-	rsect_left = bh->b_rsector;;
+	rsect_left = bh->b_rsector;
 	
 	for (i=0;i<8;i++) {
 		if (thisraid->cutoff_disks[i]==0)
diff -pruN linux-2.4.26-vanilla/drivers/isdn/hisax/hisax_fcpcipnp.c linux-2.4.26/drivers/isdn/hisax/hisax_fcpcipnp.c
--- linux-2.4.26-vanilla/drivers/isdn/hisax/hisax_fcpcipnp.c	2004-05-18 18:30:55.409271496 +0100
+++ linux-2.4.26/drivers/isdn/hisax/hisax_fcpcipnp.c	2004-05-18 18:21:42.039396504 +0100
@@ -738,7 +738,7 @@ static int __devinit fcpcipnp_setup(stru
 	adapter->isac.priv = adapter;
 	switch (adapter->type) {
 	case AVM_FRITZ_PCIV2:
-		adapter->isac.read_isac       = &fcpci2_read_isac;;
+		adapter->isac.read_isac       = &fcpci2_read_isac;
 		adapter->isac.write_isac      = &fcpci2_write_isac;
 		adapter->isac.read_isac_fifo  = &fcpci2_read_isac_fifo;
 		adapter->isac.write_isac_fifo = &fcpci2_write_isac_fifo;
@@ -747,7 +747,7 @@ static int __devinit fcpcipnp_setup(stru
 		adapter->write_ctrl           = &fcpci2_write_ctrl;
 		break;
 	case AVM_FRITZ_PCI:
-		adapter->isac.read_isac       = &fcpci_read_isac;;
+		adapter->isac.read_isac       = &fcpci_read_isac;
 		adapter->isac.write_isac      = &fcpci_write_isac;
 		adapter->isac.read_isac_fifo  = &fcpci_read_isac_fifo;
 		adapter->isac.write_isac_fifo = &fcpci_write_isac_fifo;
@@ -756,7 +756,7 @@ static int __devinit fcpcipnp_setup(stru
 		adapter->write_ctrl           = &fcpci_write_ctrl;
 		break;
 	case AVM_FRITZ_PNP:
-		adapter->isac.read_isac       = &fcpci_read_isac;;
+		adapter->isac.read_isac       = &fcpci_read_isac;
 		adapter->isac.write_isac      = &fcpci_write_isac;
 		adapter->isac.read_isac_fifo  = &fcpci_read_isac_fifo;
 		adapter->isac.write_isac_fifo = &fcpci_write_isac_fifo;

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-md"

diff -pruN linux-2.4.26-vanilla/drivers/md/raid1.c linux-2.4.26/drivers/md/raid1.c
--- linux-2.4.26-vanilla/drivers/md/raid1.c	2004-05-18 18:31:13.116579576 +0100
+++ linux-2.4.26/drivers/md/raid1.c	2004-05-18 18:12:46.437820320 +0100
@@ -860,7 +860,7 @@ static void close_sync(raid1_conf_t *con
 	wait_event_lock_irq(conf->wait_ready, !conf->cnt_pending, conf->segment_lock);
 	conf->start_active = conf->start_ready = conf->start_pending = conf->start_future = 0;
 	conf->phase = 0;
-	conf->cnt_future = conf->cnt_done;;
+	conf->cnt_future = conf->cnt_done;
 	conf->cnt_done = 0;
 	spin_unlock_irq(&conf->segment_lock);
 	wake_up(&conf->wait_done);

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-mtd"

diff -pruN linux-2.4.26-vanilla/drivers/mtd/nand/nand.c linux-2.4.26/drivers/mtd/nand/nand.c
--- linux-2.4.26-vanilla/drivers/mtd/nand/nand.c	2003-06-28 22:34:00.000000000 +0100
+++ linux-2.4.26/drivers/mtd/nand/nand.c	2004-05-18 18:16:56.468809832 +0100
@@ -1197,7 +1197,7 @@ erase_exit:
 	nand_deselect ();
 	spin_unlock_bh (&this->chip_lock);
 
-	ret = instr->state == MTD_ERASE_DONE ? 0 : -EIO;;
+	ret = instr->state == MTD_ERASE_DONE ? 0 : -EIO;
 	/* Do call back function */
 	if (!ret && instr->callback)
 		instr->callback (instr);

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-net"

diff -pruN linux-2.4.26-vanilla/drivers/net/acenic.h linux-2.4.26/drivers/net/acenic.h
--- linux-2.4.26-vanilla/drivers/net/acenic.h	2003-06-28 22:31:33.000000000 +0100
+++ linux-2.4.26/drivers/net/acenic.h	2004-05-18 18:14:39.230673200 +0100
@@ -696,7 +696,7 @@ struct ace_private
 	char			name[48];
 #ifdef INDEX_DEBUG
 	spinlock_t		debug_lock
-				__attribute__ ((aligned (SMP_CACHE_BYTES)));;
+				__attribute__ ((aligned (SMP_CACHE_BYTES)));
 	u32			last_tx, last_std_rx, last_mini_rx;
 #endif
 	struct net_device_stats stats;
diff -pruN linux-2.4.26-vanilla/drivers/net/aironet4500_proc.c linux-2.4.26/drivers/net/aironet4500_proc.c
--- linux-2.4.26-vanilla/drivers/net/aironet4500_proc.c	2001-09-30 20:26:06.000000000 +0100
+++ linux-2.4.26/drivers/net/aironet4500_proc.c	2004-05-18 18:13:53.888566248 +0100
@@ -168,7 +168,7 @@ int awc_proc_format_array(int write,char
      			for (k=0; k < bytes; k++){
      				data[i*bytes +k] = *(buff + i*bytes +k);
      				if (i*bytes +k > *len || !data[i*bytes +k])
-     					null_past = 1;;
+     					null_past = 1;
      			}
      	
      		}
diff -pruN linux-2.4.26-vanilla/drivers/net/arlan.c linux-2.4.26/drivers/net/arlan.c
--- linux-2.4.26-vanilla/drivers/net/arlan.c	2002-07-17 17:23:36.000000000 +0100
+++ linux-2.4.26/drivers/net/arlan.c	2004-05-18 18:16:34.152202472 +0100
@@ -1481,7 +1481,7 @@ static void arlan_tx_done_interrupt(stru
 			priv->retransmissions = 0;
 			if (priv->Conf->tx_delay_ms)
 			{
-				priv->tx_done_delayed = jiffies + (priv->Conf->tx_delay_ms * HZ) / 1000 + 1;;
+				priv->tx_done_delayed = jiffies + (priv->Conf->tx_delay_ms * HZ) / 1000 + 1;
 			}
 			else
 			{
diff -pruN linux-2.4.26-vanilla/drivers/net/sk98lin/skgepnmi.c linux-2.4.26/drivers/net/sk98lin/skgepnmi.c
--- linux-2.4.26-vanilla/drivers/net/sk98lin/skgepnmi.c	2004-05-18 18:31:13.235561488 +0100
+++ linux-2.4.26/drivers/net/sk98lin/skgepnmi.c	2004-05-18 18:14:07.391513488 +0100
@@ -7681,7 +7681,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			 to the low-power state.
 			 A miniport driver must always return NDIS_STATUS_SUCCESS
 			 to a query of OID_PNP_QUERY_POWER. */
-			*pLen = sizeof(SK_DEVICE_POWER_STATE);;
+			*pLen = sizeof(SK_DEVICE_POWER_STATE);
             RetCode = SK_PNMI_ERR_OK;
 			break;
 
diff -pruN linux-2.4.26-vanilla/drivers/net/typhoon.c linux-2.4.26/drivers/net/typhoon.c
--- linux-2.4.26-vanilla/drivers/net/typhoon.c	2004-05-18 18:31:13.306550696 +0100
+++ linux-2.4.26/drivers/net/typhoon.c	2004-05-18 18:14:19.813625040 +0100
@@ -1318,7 +1318,7 @@ typhoon_init_interface(struct typhoon *t
 	tp->rxHiRing.ringBase = (u8 *) tp->shared->rxHi;
 	tp->rxBuffRing.ringBase = (u8 *) tp->shared->rxBuff;
 	tp->cmdRing.ringBase = (u8 *) tp->shared->cmd;
-	tp->respRing.ringBase = (u8 *) tp->shared->resp;;
+	tp->respRing.ringBase = (u8 *) tp->shared->resp;
 
 	tp->txLoRing.writeRegister = TYPHOON_REG_TX_LO_READY;
 	tp->txHiRing.writeRegister = TYPHOON_REG_TX_HI_READY;
diff -pruN linux-2.4.26-vanilla/drivers/net/wan/8253x/8253xchr.c linux-2.4.26/drivers/net/wan/8253x/8253xchr.c
--- linux-2.4.26-vanilla/drivers/net/wan/8253x/8253xchr.c	2002-07-17 17:23:43.000000000 +0100
+++ linux-2.4.26/drivers/net/wan/8253x/8253xchr.c	2004-05-18 18:13:21.026562032 +0100
@@ -520,7 +520,7 @@ static int sab8253x_block_til_readyC(str
 			 *  port->regs->rw.mode &= ~(SAB82532_MODE_RTS);
 			 */
 		}
-		restore_flags(flags);;
+		restore_flags(flags);
 		current->state = TASK_INTERRUPTIBLE;
 		if (!(port->flags & FLAG8253X_INITIALIZED)) 
 		{
diff -pruN linux-2.4.26-vanilla/drivers/net/wireless/atmel.c linux-2.4.26/drivers/net/wireless/atmel.c
--- linux-2.4.26-vanilla/drivers/net/wireless/atmel.c	2004-05-18 18:31:13.323548112 +0100
+++ linux-2.4.26/drivers/net/wireless/atmel.c	2004-05-18 18:16:14.343213896 +0100
@@ -519,7 +519,7 @@ struct atmel_private {
 	int channel;
 	int reg_domain;
 	int tx_rate;
-	int auto_tx_rate;;
+	int auto_tx_rate;
 	int rts_threshold;
 	int frag_threshold;
 	int long_retry, short_retry;
diff -pruN linux-2.4.26-vanilla/drivers/net/wireless/hermes.h linux-2.4.26/drivers/net/wireless/hermes.h
--- linux-2.4.26-vanilla/drivers/net/wireless/hermes.h	2004-05-18 18:30:55.679230456 +0100
+++ linux-2.4.26/drivers/net/wireless/hermes.h	2004-05-18 18:16:03.980789224 +0100
@@ -362,7 +362,7 @@ static inline int hermes_inquire(hermes_
 /* Note that for the next two, the count is in 16-bit words, not bytes */
 static inline void hermes_read_words(struct hermes *hw, int off, void *buf, unsigned count)
 {
-	off = off << hw->reg_spacing;;
+	off = off << hw->reg_spacing;
 
 	if (hw->io_space) {
 		insw(hw->iobase + off, buf, count);
@@ -382,7 +382,7 @@ static inline void hermes_read_words(str
 
 static inline void hermes_write_words(struct hermes *hw, int off, const void *buf, unsigned count)
 {
-	off = off << hw->reg_spacing;;
+	off = off << hw->reg_spacing;
 
 	if (hw->io_space) {
 		outsw(hw->iobase + off, buf, count);
@@ -404,7 +404,7 @@ static inline void hermes_clear_words(st
 {
 	unsigned i;
 
-	off = off << hw->reg_spacing;;
+	off = off << hw->reg_spacing;
 
 	if (hw->io_space) {
 		for (i = 0; i < count; i++)

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-s390"

diff -pruN linux-2.4.26-vanilla/drivers/s390/block/dasd.c linux-2.4.26/drivers/s390/block/dasd.c
--- linux-2.4.26-vanilla/drivers/s390/block/dasd.c	2004-05-18 18:31:09.792084976 +0100
+++ linux-2.4.26/drivers/s390/block/dasd.c	2004-05-18 18:21:59.502741672 +0100
@@ -3360,7 +3360,7 @@ dasd_fillgeo(int kdev,struct hd_geometry
 
 	device->discipline->fill_geometry (device, geo);
 	geo->start = device->major_info->gendisk.part[MINOR(kdev)].start_sect 
-		     >> device->sizes.s2b_shift;;
+		     >> device->sizes.s2b_shift;
         return 0;
 } 
 

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-scsi"

diff -pruN linux-2.4.26-vanilla/drivers/scsi/aic7xxx/aic7770.c linux-2.4.26/drivers/scsi/aic7xxx/aic7770.c
--- linux-2.4.26-vanilla/drivers/scsi/aic7xxx/aic7770.c	2004-05-18 18:30:55.946189872 +0100
+++ linux-2.4.26/drivers/scsi/aic7xxx/aic7770.c	2004-05-18 18:26:44.435425320 +0100
@@ -64,7 +64,7 @@ static int aic7770_suspend(struct ahc_so
 static int aic7770_resume(struct ahc_softc *ahc);
 static int aha2840_load_seeprom(struct ahc_softc *ahc);
 static ahc_device_setup_t ahc_aic7770_VL_setup;
-static ahc_device_setup_t ahc_aic7770_EISA_setup;;
+static ahc_device_setup_t ahc_aic7770_EISA_setup;
 static ahc_device_setup_t ahc_aic7770_setup;
 
 struct aic7770_identity aic7770_ident_table[] =
diff -pruN linux-2.4.26-vanilla/drivers/scsi/cpqfcTSinit.c linux-2.4.26/drivers/scsi/cpqfcTSinit.c
--- linux-2.4.26-vanilla/drivers/scsi/cpqfcTSinit.c	2003-06-28 22:34:00.000000000 +0100
+++ linux-2.4.26/drivers/scsi/cpqfcTSinit.c	2004-05-18 18:25:07.904100312 +0100
@@ -158,7 +158,7 @@ static void Cpqfc_initHBAdata(CPQFCHBA *
 	cpqfcHBAdata->fcChip.InitializeTachyon = CpqTsInitializeTachLite;
 	cpqfcHBAdata->fcChip.LaserControl = CpqTsLaserControl;
 	cpqfcHBAdata->fcChip.ProcessIMQEntry = CpqTsProcessIMQEntry;
-	cpqfcHBAdata->fcChip.InitializeFrameManager = CpqTsInitializeFrameManager;;
+	cpqfcHBAdata->fcChip.InitializeFrameManager = CpqTsInitializeFrameManager;
 	cpqfcHBAdata->fcChip.ReadWriteWWN = CpqTsReadWriteWWN;
 	cpqfcHBAdata->fcChip.ReadWriteNVRAM = CpqTsReadWriteNVRAM;
 
diff -pruN linux-2.4.26-vanilla/drivers/scsi/dec_esp.c linux-2.4.26/drivers/scsi/dec_esp.c
--- linux-2.4.26-vanilla/drivers/scsi/dec_esp.c	2004-05-18 18:30:56.060172544 +0100
+++ linux-2.4.26/drivers/scsi/dec_esp.c	2004-05-18 18:24:58.776487920 +0100
@@ -339,7 +339,7 @@ static void dma_drain(struct NCR_ESP *es
 
 static int dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd * sp)
 {
-	return sp->SCp.this_residual;;
+	return sp->SCp.this_residual;
 }
 
 static void dma_dump_state(struct NCR_ESP *esp)
diff -pruN linux-2.4.26-vanilla/drivers/scsi/dpt_i2o.c linux-2.4.26/drivers/scsi/dpt_i2o.c
--- linux-2.4.26-vanilla/drivers/scsi/dpt_i2o.c	2003-06-28 22:34:00.000000000 +0100
+++ linux-2.4.26/drivers/scsi/dpt_i2o.c	2004-05-18 18:25:26.355295304 +0100
@@ -2197,7 +2197,7 @@ static s32 adpt_scsi_register(adpt_hba* 
 	(adpt_hba*)(host->hostdata[0]) = pHba;
 	pHba->host = host;
 
-	host->irq = pHba->pDev->irq;;
+	host->irq = pHba->pDev->irq;
 	/* no IO ports, so don't have to set host->io_port and 
 	 * host->n_io_port
 	 */
diff -pruN linux-2.4.26-vanilla/drivers/scsi/gdth.c linux-2.4.26/drivers/scsi/gdth.c
--- linux-2.4.26-vanilla/drivers/scsi/gdth.c	2004-05-18 18:30:56.064171936 +0100
+++ linux-2.4.26/drivers/scsi/gdth.c	2004-05-18 18:25:51.105532696 +0100
@@ -1298,7 +1298,7 @@ GDTH_INITFUNC(static int, gdth_init_pci(
         
         /* disable board interrupts, deinit services */
         gdth_writeb(0xff, &dp6_ptr->io.irqdel);
-        gdth_writeb(0x00, &dp6_ptr->io.irqen);;
+        gdth_writeb(0x00, &dp6_ptr->io.irqen);
         gdth_writeb(0x00, &dp6_ptr->u.ic.S_Status);
         gdth_writeb(0x00, &dp6_ptr->u.ic.Cmd_Index);
 
diff -pruN linux-2.4.26-vanilla/drivers/scsi/i91uscsi.c linux-2.4.26/drivers/scsi/i91uscsi.c
--- linux-2.4.26-vanilla/drivers/scsi/i91uscsi.c	2001-08-12 18:51:41.000000000 +0100
+++ linux-2.4.26/drivers/scsi/i91uscsi.c	2004-05-18 18:26:00.270139464 +0100
@@ -2269,7 +2269,7 @@ int int_tul_bad_seq(HCS * pCurHcb)
 		tul_append_done_scb(pCurHcb, pCurScb);
 	}
 	for (i = 0; i < pCurHcb->HCS_MaxTar; i++) {
-		pCurHcb->HCS_Tcs[i].TCS_Flags &= ~(TCF_SYNC_DONE | TCF_WDTR_DONE);;
+		pCurHcb->HCS_Tcs[i].TCS_Flags &= ~(TCF_SYNC_DONE | TCF_WDTR_DONE);
 	}
 	return (-1);
 }
diff -pruN linux-2.4.26-vanilla/drivers/scsi/in2000.c linux-2.4.26/drivers/scsi/in2000.c
--- linux-2.4.26-vanilla/drivers/scsi/in2000.c	2003-06-28 22:34:00.000000000 +0100
+++ linux-2.4.26/drivers/scsi/in2000.c	2004-05-18 18:22:58.674746160 +0100
@@ -2347,7 +2347,7 @@ static int stop = 0;
       return 0;         /* return 0 to signal end-of-file */
       }
    if (off > 0x40000)   /* ALWAYS stop after 256k bytes have been read */
-      stop = 1;;
+      stop = 1;
    if (hd->proc & PR_STOP)    /* stop every other time */
       stop = 1;
    return strlen(bp);
diff -pruN linux-2.4.26-vanilla/drivers/scsi/megaraid.c linux-2.4.26/drivers/scsi/megaraid.c
--- linux-2.4.26-vanilla/drivers/scsi/megaraid.c	2004-05-18 18:31:09.852075856 +0100
+++ linux-2.4.26/drivers/scsi/megaraid.c	2004-05-18 18:25:41.471997216 +0100
@@ -3782,7 +3782,7 @@ static void mega_swap_hosts (struct Scsi
 {
 	struct Scsi_Host *prevtoshtwo;
 	struct Scsi_Host *prevtoshone;
-	struct Scsi_Host *save = NULL;;
+	struct Scsi_Host *save = NULL;
 
 	/* Are these two nodes adjacent */
 	if (shtwo->next == shone) {
@@ -3864,7 +3864,7 @@ static void mega_swap_hosts (struct Scsi
 	} else {
 		prevtoshtwo = scsi_hostlist;
 		prevtoshone = scsi_hostlist;
-		save = NULL;;
+		save = NULL;
 
 		while (prevtoshtwo->next != shtwo)
 			prevtoshtwo = prevtoshtwo->next;
diff -pruN linux-2.4.26-vanilla/drivers/scsi/pci2000.c linux-2.4.26/drivers/scsi/pci2000.c
--- linux-2.4.26-vanilla/drivers/scsi/pci2000.c	2001-11-09 22:05:06.000000000 +0000
+++ linux-2.4.26/drivers/scsi/pci2000.c	2004-05-18 18:24:48.672024032 +0100
@@ -322,7 +322,7 @@ static void Irq_Handler (int irq, void *
 
 	outb_p (0xFF, padapter->tag);												// clear the op interrupt
 	outb_p (CMD_DONE, padapter->cmd);											// complete the op
-	goto irq_return;;															// done, but, with what?
+	goto irq_return;			// done, but, with what?
 
 unmapProceed:;
 	if ( !bus )
@@ -355,7 +355,7 @@ irqProceed:;
 		if ( WaitReady (padapter) )
 			{
 			OpDone (SCpnt, DID_TIME_OUT << 16);
-			goto irq_return;;
+			goto irq_return;
 			}
 
 		outb_p (tag0, padapter->mb0);										// get real error code
@@ -363,7 +363,7 @@ irqProceed:;
 		if ( WaitReady (padapter) )											// wait for controller to suck up the op
 			{
 			OpDone (SCpnt, DID_TIME_OUT << 16);
-			goto irq_return;;
+			goto irq_return;
 			}
 
 		error = inl (padapter->mb0);										// get error data
@@ -376,16 +376,16 @@ irqProceed:;
 			if ( bus )														// are we doint SCSI commands?
 				{
 				OpDone (SCpnt, (DID_OK << 16) | 2);
-				goto irq_return;;
+				goto irq_return;
 				}
 			if ( *SCpnt->cmnd == SCSIOP_TEST_UNIT_READY )
 				OpDone (SCpnt, (DRIVER_SENSE << 24) | (DID_OK << 16) | 2);	// test caller we have sense data too
 			else
 				OpDone (SCpnt, DID_ERROR << 16);
-			goto irq_return;;
+			goto irq_return;
 			}
 		OpDone (SCpnt, DID_ERROR << 16);
-		goto irq_return;;
+		goto irq_return;
 		}
 
 	outb_p (0xFF, padapter->tag);											// clear the op interrupt
diff -pruN linux-2.4.26-vanilla/drivers/scsi/pci2220i.c linux-2.4.26/drivers/scsi/pci2220i.c
--- linux-2.4.26-vanilla/drivers/scsi/pci2220i.c	2001-11-09 22:05:06.000000000 +0000
+++ linux-2.4.26/drivers/scsi/pci2220i.c	2004-05-18 18:26:34.492936808 +0100
@@ -1384,7 +1384,7 @@ static void ReconTimerExpiry (unsigned l
 			 (pdev->DiskMirror[0].pairIdentifier == (pdev->DiskMirror[1].pairIdentifier ^ 1)) )
 			{
 			if ( (pdev->DiskMirror[0].status & UCBF_MATCHED) && (pdev->DiskMirror[1].status & UCBF_MATCHED) )
-				break;;
+				break;
 
 			if ( pdev->DiskMirror[0].status & UCBF_SURVIVOR )				// is first drive survivor?
 				testsize = SetReconstruct (pdev, 0);
@@ -2641,7 +2641,7 @@ int Pci2220i_Detect (Scsi_Host_Template 
 	
 		if ( ++Installed < MAXADAPTER )
 			continue;
-		break;;
+		break;
 unregister:;
 		scsi_unregister (pshost);
 		}
@@ -2775,7 +2775,7 @@ unregister:;
 		
 		if ( ++Installed < MAXADAPTER )
 			continue;
-		break;;
+		break;
 unregister1:;
 		scsi_unregister (pshost);
 		}
diff -pruN linux-2.4.26-vanilla/drivers/scsi/qlogicfc.c linux-2.4.26/drivers/scsi/qlogicfc.c
--- linux-2.4.26-vanilla/drivers/scsi/qlogicfc.c	2004-05-18 18:31:13.350544008 +0100
+++ linux-2.4.26/drivers/scsi/qlogicfc.c	2004-05-18 18:22:30.168079832 +0100
@@ -1783,7 +1783,7 @@ int isp2x00_reset(Scsi_Cmnd * Cmnd, unsi
 
 	LEAVE("isp2x00_reset");
 
-	return return_status;;
+	return return_status;
 }
 
 
diff -pruN linux-2.4.26-vanilla/drivers/scsi/qlogicisp.c linux-2.4.26/drivers/scsi/qlogicisp.c
--- linux-2.4.26-vanilla/drivers/scsi/qlogicisp.c	2003-06-28 22:34:00.000000000 +0100
+++ linux-2.4.26/drivers/scsi/qlogicisp.c	2004-05-18 18:25:17.275675616 +0100
@@ -1235,7 +1235,7 @@ int isp1020_reset(Scsi_Cmnd *Cmnd, unsig
 
 	LEAVE("isp1020_reset");
 
-	return return_status;;
+	return return_status;
 }
 
 
diff -pruN linux-2.4.26-vanilla/drivers/scsi/scsiiom.c linux-2.4.26/drivers/scsi/scsiiom.c
--- linux-2.4.26-vanilla/drivers/scsi/scsiiom.c	2000-12-31 19:06:00.000000000 +0000
+++ linux-2.4.26/drivers/scsi/scsiiom.c	2004-05-18 18:22:42.018278328 +0100
@@ -1682,7 +1682,7 @@ dc390_DoingSRB_Done( PACB pACB, PSCSICMD
 #endif	
 	    psrb  = psrb2;
 	}
-	pdcb->GoingSRBCnt = 0;;
+	pdcb->GoingSRBCnt = 0;
 	pdcb->pGoingSRB = NULL;
 	pdcb->TagMask = 0;
 	pdcb = pdcb->pNextDCB;
diff -pruN linux-2.4.26-vanilla/drivers/scsi/wd33c93.c linux-2.4.26/drivers/scsi/wd33c93.c
--- linux-2.4.26-vanilla/drivers/scsi/wd33c93.c	2002-07-17 17:24:01.000000000 +0100
+++ linux-2.4.26/drivers/scsi/wd33c93.c	2004-05-18 18:26:53.099108240 +0100
@@ -2033,7 +2033,7 @@ static int stop = 0;
       return 0;
       }
    if (off > 0x40000)   /* ALWAYS stop after 256k bytes have been read */
-      stop = 1;;
+      stop = 1;
    if (hd->proc & PR_STOP)    /* stop every other time */
       stop = 1;
    return strlen(bp);

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-sound"

diff -pruN linux-2.4.26-vanilla/drivers/sound/cs46xx.c linux-2.4.26/drivers/sound/cs46xx.c
--- linux-2.4.26-vanilla/drivers/sound/cs46xx.c	2004-05-18 18:30:56.129162056 +0100
+++ linux-2.4.26/drivers/sound/cs46xx.c	2004-05-18 18:27:42.195644432 +0100
@@ -3251,7 +3251,7 @@ static int cs_open(struct inode *inode, 
 			
 		if (dmabuf->channel == NULL) {
 			kfree (card->states[0]);
-			card->states[0] = NULL;;
+			card->states[0] = NULL;
 			return -ENODEV;
 		}
 
@@ -3322,7 +3322,7 @@ static int cs_open(struct inode *inode, 
 			
 		if (dmabuf->channel == NULL) {
 			kfree (card->states[1]);
-			card->states[1] = NULL;;
+			card->states[1] = NULL;
 			return -ENODEV;
 		}
 
diff -pruN linux-2.4.26-vanilla/drivers/sound/nec_vrc5477.c linux-2.4.26/drivers/sound/nec_vrc5477.c
--- linux-2.4.26-vanilla/drivers/sound/nec_vrc5477.c	2004-05-18 18:31:09.885070840 +0100
+++ linux-2.4.26/drivers/sound/nec_vrc5477.c	2004-05-18 18:28:44.131228792 +0100
@@ -295,7 +295,7 @@ static u16 rdcodec(struct ac97_codec *co
 
 	spin_unlock_irqrestore(&s->lock, flags);
 
-	return result & 0xffff;;
+	return result & 0xffff;
 }
 
 
diff -pruN linux-2.4.26-vanilla/drivers/sound/rme96xx.c linux-2.4.26/drivers/sound/rme96xx.c
--- linux-2.4.26-vanilla/drivers/sound/rme96xx.c	2002-08-14 01:07:27.000000000 +0100
+++ linux-2.4.26/drivers/sound/rme96xx.c	2004-05-18 18:28:32.553988800 +0100
@@ -1337,7 +1337,7 @@ static int rme96xx_ioctl(struct inode *i
 			return -EINVAL;
 		val = rme96xx_gethwptr(dma->s,0);
 		spin_lock_irqsave(&s->lock,flags);
-                cinfo.bytes = s->fragsize<<1;;
+                cinfo.bytes = s->fragsize<<1;
 		count = val - dma->readptr;
 		if (count < 0)
 			count += s->fragsize<<1;
@@ -1355,7 +1355,7 @@ static int rme96xx_ioctl(struct inode *i
 			return -EINVAL;
 		val = rme96xx_gethwptr(dma->s,0);
 		spin_lock_irqsave(&s->lock,flags);
-                cinfo.bytes = s->fragsize<<1;;
+                cinfo.bytes = s->fragsize<<1;
 		count = val - dma->writeptr;
 		if (count < 0)
 			count += s->fragsize<<1;
diff -pruN linux-2.4.26-vanilla/drivers/sound/soundcard.c linux-2.4.26/drivers/sound/soundcard.c
--- linux-2.4.26-vanilla/drivers/sound/soundcard.c	2002-08-14 01:07:27.000000000 +0100
+++ linux-2.4.26/drivers/sound/soundcard.c	2004-05-18 18:27:54.364794440 +0100
@@ -739,7 +739,7 @@ void request_sound_timer(int count)
 
 void sound_stop_timer(void)
 {
-	del_timer(&seq_timer);;
+	del_timer(&seq_timer);
 }
 
 void conf_printf(char *name, struct address_info *hw_config)
diff -pruN linux-2.4.26-vanilla/drivers/sound/sys_timer.c linux-2.4.26/drivers/sound/sys_timer.c
--- linux-2.4.26-vanilla/drivers/sound/sys_timer.c	2000-08-11 16:26:44.000000000 +0100
+++ linux-2.4.26/drivers/sound/sys_timer.c	2004-05-18 18:27:27.267913792 +0100
@@ -115,7 +115,7 @@ static void
 def_tmr_close(int dev)
 {
 	opened = tmr_running = 0;
-	del_timer(&def_tmr);;
+	del_timer(&def_tmr);
 }
 
 static int

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-usb"

diff -pruN linux-2.4.26-vanilla/drivers/usb/brlvger.c linux-2.4.26/drivers/usb/brlvger.c
--- linux-2.4.26-vanilla/drivers/usb/brlvger.c	2004-05-18 18:31:05.670711520 +0100
+++ linux-2.4.26/drivers/usb/brlvger.c	2004-05-18 18:17:54.404002344 +0100
@@ -597,7 +597,7 @@ brlvger_write(struct file *file, const c
 	off = *pos;
 
 	if(off > priv->plength)
-		return -ESPIPE;;
+		return -ESPIPE;
 
 	rs = priv->plength - off;
 
diff -pruN linux-2.4.26-vanilla/drivers/usb/se401.c linux-2.4.26/drivers/usb/se401.c
--- linux-2.4.26-vanilla/drivers/usb/se401.c	2003-06-28 22:31:33.000000000 +0100
+++ linux-2.4.26/drivers/usb/se401.c	2004-05-18 18:17:44.763467928 +0100
@@ -478,7 +478,7 @@ static void se401_video_irq(struct urb *
 				se401->scratch_overflow=0;
 				se401->scratch_next++;
 				if (se401->scratch_next>=SE401_NUMSCRATCH)
-					se401->scratch_next=0;;
+					se401->scratch_next=0;
 				break;
 			}
 		}
diff -pruN linux-2.4.26-vanilla/drivers/usb/serial/empeg.c linux-2.4.26/drivers/usb/serial/empeg.c
--- linux-2.4.26-vanilla/drivers/usb/serial/empeg.c	2003-06-28 22:31:33.000000000 +0100
+++ linux-2.4.26/drivers/usb/serial/empeg.c	2004-05-18 18:18:01.760883928 +0100
@@ -147,7 +147,7 @@ static int		bytes_out;
 static int empeg_open (struct usb_serial_port *port, struct file *filp)
 {
 	struct usb_serial *serial = port->serial;
-	int result = 0;;
+	int result = 0;
 
 	if (port_paranoia_check (port, __FUNCTION__))
 		return -ENODEV;
diff -pruN linux-2.4.26-vanilla/drivers/usb/serial/mct_u232.c linux-2.4.26/drivers/usb/serial/mct_u232.c
--- linux-2.4.26-vanilla/drivers/usb/serial/mct_u232.c	2004-05-18 18:31:09.970057920 +0100
+++ linux-2.4.26/drivers/usb/serial/mct_u232.c	2004-05-18 18:18:09.614689968 +0100
@@ -455,7 +455,7 @@ static int mct_u232_write (struct usb_se
 
 	/* only do something if we have a bulk out endpoint */
 	if (!serial->num_bulk_out)
-		return(0);;
+		return(0);
 	
 	/* another write is still pending? */
 	if (port->write_urb->status == -EINPROGRESS) {
diff -pruN linux-2.4.26-vanilla/drivers/usb/stv680.c linux-2.4.26/drivers/usb/stv680.c
--- linux-2.4.26-vanilla/drivers/usb/stv680.c	2004-05-18 18:31:05.773695864 +0100
+++ linux-2.4.26/drivers/usb/stv680.c	2004-05-18 18:18:28.624799992 +0100
@@ -699,7 +699,7 @@ static void stv680_video_irq (struct urb
 			stv680->scratch_overflow = 0;
 			stv680->scratch_next++;
 			if (stv680->scratch_next >= STV680_NUMSCRATCH)
-				stv680->scratch_next = 0;;
+				stv680->scratch_next = 0;
 			break;
 		}		/* switch  */
 	} else {

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-drivers-video"

diff -pruN linux-2.4.26-vanilla/drivers/video/fbcon-cfb16.c linux-2.4.26/drivers/video/fbcon-cfb16.c
--- linux-2.4.26-vanilla/drivers/video/fbcon-cfb16.c	2001-10-15 21:47:13.000000000 +0100
+++ linux-2.4.26/drivers/video/fbcon-cfb16.c	2004-05-18 18:29:06.179876888 +0100
@@ -200,7 +200,7 @@ void fbcon_cfb16_putcs(struct vc_data *c
 		    fb_writel((tab_cfb16[bits & 3] & eorx) ^ bgx, dest+12);
 		}
 	    }
-	    dest0 += fontwidth(p)*2;;
+	    dest0 += fontwidth(p)*2;
 	}
 	break;
     case 12:
diff -pruN linux-2.4.26-vanilla/drivers/video/sis/init301.c linux-2.4.26/drivers/video/sis/init301.c
--- linux-2.4.26-vanilla/drivers/video/sis/init301.c	2004-05-18 18:31:13.622502664 +0100
+++ linux-2.4.26/drivers/video/sis/init301.c	2004-05-18 18:28:52.845903960 +0100
@@ -2368,7 +2368,7 @@ SiS_SetCRT2ModeRegs(SiS_Private *SiS_Pr,
 
 #ifdef SIS315H
 
-        unsigned char bridgerev = SiS_GetReg(SiS_Pr->SiS_Part4Port,0x01);;
+        unsigned char bridgerev = SiS_GetReg(SiS_Pr->SiS_Part4Port,0x01);
 
 	/* The following is nearly unpreditable and varies from machine
 	 * to machine. Especially the 301DH seems to be a real trouble

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-kernel-exec_domain.c"

diff -pruN linux-2.4.26-vanilla/kernel/exec_domain.c linux-2.4.26/kernel/exec_domain.c
--- linux-2.4.26-vanilla/kernel/exec_domain.c	2004-05-18 18:31:03.034112344 +0100
+++ linux-2.4.26/kernel/exec_domain.c	2004-05-18 18:29:39.721777744 +0100
@@ -173,7 +173,7 @@ __set_personality(u_long personality)
 		fsp = copy_fs_struct(current->fs);
 		if (fsp == NULL) {
 			put_exec_domain(ep);
-			return -ENOMEM;;
+			return -ENOMEM;
 		}
 
 		task_lock(current);
@@ -217,7 +217,7 @@ get_exec_domain_list(char *page)
 asmlinkage long
 sys_personality(u_long personality)
 {
-	u_long old = current->personality;;
+	u_long old = current->personality;
 
 	if (personality != 0xffffffff) {
 		set_personality(personality);

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-net-irda"

diff -pruN linux-2.4.26-vanilla/net/irda/irlan/irlan_filter.c linux-2.4.26/net/irda/irlan/irlan_filter.c
--- linux-2.4.26-vanilla/net/irda/irlan/irlan_filter.c	2004-05-18 18:31:06.720551920 +0100
+++ linux-2.4.26/net/irda/irlan/irlan_filter.c	2004-05-18 18:05:54.346467728 +0100
@@ -52,7 +52,7 @@ void handle_filter_request(struct irlan_
 			self->provider.mac_address[4] = 
 				self->provider.send_arb_val & 0xff;
 			self->provider.mac_address[5] = 
-				(self->provider.send_arb_val >> 8) & 0xff;;
+				(self->provider.send_arb_val >> 8) & 0xff;
 		} else {
 			/* Just generate something for now */
 			get_random_bytes(self->provider.mac_address+4, 1);
diff -pruN linux-2.4.26-vanilla/net/irda/irttp.c linux-2.4.26/net/irda/irttp.c
--- linux-2.4.26-vanilla/net/irda/irttp.c	2004-05-18 18:31:06.774543712 +0100
+++ linux-2.4.26/net/irda/irttp.c	2004-05-18 18:06:15.753213408 +0100
@@ -1224,7 +1224,7 @@ void irttp_connect_indication(void *inst
 
 	lsap = (struct lsap_cb *) sap;
 
-	self->max_seg_size = max_seg_size - TTP_HEADER;;
+	self->max_seg_size = max_seg_size - TTP_HEADER;
 	self->max_header_size = max_header_size+TTP_HEADER;
 
 	IRDA_DEBUG(4, "%s(), TSAP sel=%02x\n", __FUNCTION__, self->stsap_sel);

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-net-netfilter"

diff -pruN linux-2.4.26-vanilla/net/ipv4/netfilter/ip_nat_snmp_basic.c linux-2.4.26/net/ipv4/netfilter/ip_nat_snmp_basic.c
--- linux-2.4.26-vanilla/net/ipv4/netfilter/ip_nat_snmp_basic.c	2004-05-18 18:31:06.524581712 +0100
+++ linux-2.4.26/net/ipv4/netfilter/ip_nat_snmp_basic.c	2004-05-18 18:05:36.188228200 +0100
@@ -899,10 +899,10 @@ static unsigned char snmp_trap_decode(st
 		goto err_addr_free;
 		
 	if (cls != ASN1_UNI || con != ASN1_PRI || tag != ASN1_INT)
-		goto err_addr_free;;
+		goto err_addr_free;
 		
 	if (!asn1_uint_decode(ctx, end, &trap->general))
-		goto err_addr_free;;
+		goto err_addr_free;
 		
 	if (!asn1_header_decode(ctx, &end, &cls, &con, &tag))
 		goto err_addr_free;

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-net-sched"

diff -pruN linux-2.4.26-vanilla/net/sched/sch_hfsc.c linux-2.4.26/net/sched/sch_hfsc.c
--- linux-2.4.26-vanilla/net/sched/sch_hfsc.c	2004-05-18 18:31:20.648434560 +0100
+++ linux-2.4.26/net/sched/sch_hfsc.c	2004-05-18 18:08:15.159060960 +0100
@@ -1562,7 +1562,7 @@ hfsc_change_qdisc(struct Qdisc *sch, str
 	struct tc_hfsc_qopt *qopt;
 
 	if (opt == NULL || RTA_PAYLOAD(opt) < sizeof(*qopt))
-		return -EINVAL;;
+		return -EINVAL;
 	qopt = RTA_DATA(opt);
 
 	sch_tree_lock(sch);

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-net-sctp"

diff -pruN linux-2.4.27-pre2-vanilla/net/sctp/bind_addr.c linux-2.4.27-pre2/net/sctp/bind_addr.c
--- linux-2.4.27-pre2-vanilla/net/sctp/bind_addr.c	2004-05-19 13:34:24.000000000 +0100
+++ linux-2.4.27-pre2/net/sctp/bind_addr.c	2004-05-19 13:39:59.461959128 +0100
@@ -292,7 +292,7 @@ int sctp_raw_to_bind_addrs(struct sctp_b
 		if (retval) {
 			/* Can't finish building the list, clean up. */
 			sctp_bind_addr_clean(bp);
-			break;;
+			break;
 		}
 
 		len = ntohs(param->length);
diff -pruN linux-2.4.27-pre2-vanilla/net/sctp/sm_make_chunk.c linux-2.4.27-pre2/net/sctp/sm_make_chunk.c
--- linux-2.4.27-pre2-vanilla/net/sctp/sm_make_chunk.c	2004-05-19 13:36:07.000000000 +0100
+++ linux-2.4.27-pre2/net/sctp/sm_make_chunk.c	2004-05-19 13:39:59.463958824 +0100
@@ -1480,7 +1480,7 @@ malformed:
 struct __sctp_missing {
 	__u32 num_missing;
 	__u16 type;
-}  __attribute__((packed));;
+}  __attribute__((packed));
 
 /*
  * Report a missing mandatory parameter.
diff -pruN linux-2.4.27-pre2-vanilla/net/sctp/socket.c linux-2.4.27-pre2/net/sctp/socket.c
--- linux-2.4.27-pre2-vanilla/net/sctp/socket.c	2004-05-19 13:36:07.000000000 +0100
+++ linux-2.4.27-pre2/net/sctp/socket.c	2004-05-19 13:39:59.467958216 +0100
@@ -4505,7 +4505,7 @@ static void sctp_sock_migrate(struct soc
 	 * 3) Peeling off non-partial delivery; move pd_lobby to recieve_queue.
 	 */
 	skb_queue_head_init(&newsp->pd_lobby);
-	sctp_sk(newsk)->pd_mode = assoc->ulpq.pd_mode;;
+	sctp_sk(newsk)->pd_mode = assoc->ulpq.pd_mode;
 
 	if (sctp_sk(oldsk)->pd_mode) {
 		struct sk_buff_head *queue;

--LZvS9be/3tNcYl/X
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="2.4.27-pre2-net-wanrouter"

diff -pruN linux-2.4.26-vanilla/net/wanrouter/wanmain.c linux-2.4.26/net/wanrouter/wanmain.c
--- linux-2.4.26-vanilla/net/wanrouter/wanmain.c	2001-08-15 09:22:18.000000000 +0100
+++ linux-2.4.26/net/wanrouter/wanmain.c	2004-05-18 18:08:33.214316144 +0100
@@ -604,7 +604,7 @@ static int device_setup (wan_device_t *w
 			    "%s: ERROR, Invalid firmware data size %i !\n",
 					wandev->name, conf->data_size);
 			kfree(conf);
-		        return -EINVAL;;
+		        return -EINVAL;
 		}
 
 #if defined (LINUX_2_1) || defined (LINUX_2_4)

--LZvS9be/3tNcYl/X--
