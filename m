Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVBZIgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVBZIgV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 03:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVBZIgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 03:36:21 -0500
Received: from faye.voxel.net ([69.9.164.210]:16524 "EHLO faye.voxel.net")
	by vger.kernel.org with ESMTP id S261860AbVBZIfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 03:35:21 -0500
Subject: 2.6.10-as6
From: Andres Salomon <dilinger@voxel.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iLMSVF648yTxSvuRrEW1"
Date: Sat, 26 Feb 2005 03:33:48 -0500
Message-Id: <1109406828.8123.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iLMSVF648yTxSvuRrEW1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

2.6.10-as6 includes a few more fixes, including a bug introduced by me
in earlier -as kernels; if -as didn't work on your x86_64 SMP machine,
this kernel should fix it.  Thanks to Frederik Sch=FCler for pointing out
the problem.  There is also some potential security related stuff in
there, as well.

I'll be offline for the next week or so (yay, vacation).

The -as tree is intended to include only security and bugfixes, from
various sources.  I do not include hardware driver updates
(specifically, anything that changes how the hardware registers
themselves are probed/poked), large subsystem updates, cleanups, and so
on; only fixes that will not contain regressions.  The hope is that
vendors/distributors can use this tree as a base for their kernels.  It
is also what I'd want a 2.6.x.y tree to have.

The kernel patches can be grabbed from here:
http://www.acm.cs.rpi.edu/~dilinger/patches/2.6.10/as6/

27354299d1a76c69c2d8bca60dea9646  ChangeLog
cad896bc0a7a256c124a0a83f7d4d6f1  linux-2.6.10-as6.tar.gz
c8085158617f9f10a831bb1eae15dc31  patch-2.6.10-as6.gz

Changes from 2.6.10-as5:


2005-02-26 07:40:27 GMT	Andres Salomon <dilinger@voxel.net>	patch-152

    Summary:
      tag 2.6.10-as6
    Revision:
      linux--dilinger--0--patch-152

   =20
   =20

    modified files:
     000-extraversion.patch


2005-02-26 07:16:10 GMT	Andres Salomon <dilinger@voxel.net>	patch-151

    Summary:
      make 141*.patch apply
    Revision:
      linux--dilinger--0--patch-151

   =20
   =20

    modified files:
     141-pci_devices_dont_disable_dev_if_busy.patch


2005-02-26 07:13:47 GMT	Andres Salomon <dilinger@voxel.net>	patch-150

    Summary:
      drop 128-usb_hcd_driver_model_class.patch
    Revision:
      linux--dilinger--0--patch-150

    Scratch that; this is only deref'd if the driver model class stuff
in bk is
    used.  No need to use this patch.
   =20

    removed files:
     .arch-ids/128-usb_hcd_driver_model_class.patch.id
     128-usb_hcd_driver_model_class.patch

    modified files:
     142-r8169_dev_alloc_skb_alignment_fix.patch


2005-02-26 06:55:59 GMT	Andres Salomon <dilinger@voxel.net>	patch-149

    Summary:
      142-r8169_dev_alloc_skb_alignment_fix.patch
    Revision:
      linux--dilinger--0--patch-149

    The r8169 driver wasn't alloc'ing enough memory for skbs; the size
should
    be padded by NET_IP_ALIGN.
   =20
   =20

    new files:
     .arch-ids/142-r8169_dev_alloc_skb_alignment_fix.patch.id
     142-r8169_dev_alloc_skb_alignment_fix.patch


2005-02-26 06:20:55 GMT	Andres Salomon <dilinger@voxel.net>	patch-148

    Summary:
      141-pci_devices_dont_disable_dev_if_busy.patch
    Revision:
      linux--dilinger--0--patch-148

    For various pci devices, if pci_request_regions fails (because
resources
    are already in use), don't disable the pci device (someone else is
using it)
   =20
   =20

    new files:
     .arch-ids/141-pci_devices_dont_disable_dev_if_busy.patch.id
     141-pci_devices_dont_disable_dev_if_busy.patch


2005-02-26 06:14:37 GMT	Andres Salomon <dilinger@voxel.net>	patch-147

    Summary:
      140-s390_memset_arg_order_fixes.patch
    Revision:
      linux--dilinger--0--patch-147

    [S390] Fix various drivers that call memset() with args in the wrong
order.
   =20

    new files:
     .arch-ids/140-s390_memset_arg_order_fixes.patch.id
     140-s390_memset_arg_order_fixes.patch


2005-02-26 06:03:24 GMT	Andres Salomon <dilinger@voxel.net>	patch-146

    Summary:
      139-pci_dma_free_coherent.patch
    Revision:
      linux--dilinger--0--patch-146

    [I386] dma_free_coherent() was calling kmalloc with its args
reversed;
    clearly incorrect.
   =20
   =20

    new files:
     .arch-ids/139-pci_dma_free_coherent.patch.id
     139-pci_dma_free_coherent.patch


2005-02-26 06:00:21 GMT	Andres Salomon <dilinger@voxel.net>	patch-145

    Summary:
      138-tulip_de_init_one_irq_init.patch
    Revision:
      linux--dilinger--0--patch-145

    The tulip driver's de_init_one() was using pdev->irq before it had
been
    initialized.  Move its usage until after it has been initted.
   =20

    new files:
     .arch-ids/138-tulip_de_init_one_irq_init.patch.id
     138-tulip_de_init_one_irq_init.patch


2005-02-26 05:45:07 GMT	Andres Salomon <dilinger@voxel.net>	patch-144

    Summary:
      137-ppc64_prom_initialize_tce_table_typo.patch
    Revision:
      linux--dilinger--0--patch-144

    [PPC64] prom_initialize_tce_table() refers to 'vbase', which doesn't
actually
    exist; instead, 'base' was what was meant.
   =20

    new files:
     .arch-ids/137-ppc64_prom_initialize_tce_table_typo.patch.id
     137-ppc64_prom_initialize_tce_table_typo.patch


2005-02-26 05:39:01 GMT	Andres Salomon <dilinger@voxel.net>	patch-143

    Summary:
      136-64bit_sys_compat_overflows.patch
    Revision:
      linux--dilinger--0--patch-143

    More of the same as 135*.patch, except for stuff like sys_ipc,
sys_semget,
    sys_msgsnd, etc.
   =20

    new files:
     .arch-ids/136-64bit_sys_compat_overflows.patch.id
     136-64bit_sys_compat_overflows.patch


2005-02-26 05:33:17 GMT	Andres Salomon <dilinger@voxel.net>	patch-142

    Summary:
      135-64bit_sys_shmget_compat_size_t_overflow.patch
    Revision:
      linux--dilinger--0--patch-142

    64bit archs that offer 32bit compat wrappers for sys_shmget were
mostly
    passing the second arg as a 32bit signed int; what would happen then
is,
    it would be casted to a size_t (64bit unsigned), and the sign would
cause
    it to overflow.  Instead, we need to cast to a 32bit unsigned value
first,
    and then cast to 64bit unsigned.
   =20

    new files:
     .arch-ids/135-64bit_sys_shmget_compat_size_t_overflow.patch.id
     135-64bit_sys_shmget_compat_size_t_overflow.patch


2005-02-26 05:03:57 GMT	Andres Salomon <dilinger@voxel.net>	patch-141

    Summary:
      134-cciss_scsi_detect_put_host_on_error.patch
    Revision:
      linux--dilinger--0--patch-141

    [SCSI] cciss_scsi_detect() calls scsi_add_host(), which bumps the
refcount
    (even in the event of an error).  Thus, if scsi_add_host fails, the
    scsi host refcount needs to be decremented; so, call scsi_host_put
upon
    error.
   =20
   =20

    new files:
     .arch-ids/134-cciss_scsi_detect_put_host_on_error.patch.id
     134-cciss_scsi_detect_put_host_on_error.patch


2005-02-26 01:14:57 GMT	Andres Salomon <dilinger@voxel.net>	patch-140

    Summary:
      drop 083-x86_64_switch_mm_context_race.patch
    Revision:
      linux--dilinger--0--patch-140

    [X86-64] Drop 083-x86_64_switch_mm_context_race.patch; something
with the
    4 level page table changes prior to this made it break w/ x86_64 smp
    machines.  It also broke one of the rules for this tree, by tweaking
    registers.
   =20

    removed files:
     .arch-ids/083-x86_64_switch_mm_context_race.patch.id
     083-x86_64_switch_mm_context_race.patch


2005-02-25 18:08:20 GMT	Andres Salomon <dilinger@voxel.net>	patch-139

    Summary:
      133-scsi_advansys_build_with_non_pci.patch
    Revision:
      linux--dilinger--0--patch-139

    [SCSI] Allow advansys driver to compile if CONFIG_PCI isn't set.
   =20

    new files:
     .arch-ids/133-scsi_advansys_build_with_non_pci.patch.id
     133-scsi_advansys_build_with_non_pci.patch


2005-02-25 08:20:31 GMT	Andres Salomon <dilinger@voxel.net>	patch-138

    Summary:
      132-sparc32_get_tv32_use_correct_variable.patch
    Revision:
      linux--dilinger--0--patch-138

    [SPARC] get_tv32() uses a non-existent variable 'tv32'.  Fix that.
   =20

    new files:
     .arch-ids/132-sparc32_get_tv32_use_correct_variable.patch.id
     132-sparc32_get_tv32_use_correct_variable.patch


2005-02-25 08:13:44 GMT	Andres Salomon <dilinger@voxel.net>	patch-137

    Summary:
      131-sparc_check_prom_getproperty.patch
    Revision:
      linux--dilinger--0--patch-137

    [SPARC] Check return value from prom_getproperty() in various places
where
    it wasn't being checked.
   =20
   =20

    new files:
     .arch-ids/131-sparc_check_prom_getproperty.patch.id
     131-sparc_check_prom_getproperty.patch


2005-02-25 07:59:33 GMT	Andres Salomon <dilinger@voxel.net>	patch-136

    Summary:
      130-sparc_prom_nodematch_check_getproperty.patch
    Revision:
      linux--dilinger--0--patch-136

    [SPARC] In prom_nodematch, check whether prom_getproperty() actually
    succeeds before using the string it sets.
   =20
   =20

    new files:
     .arch-ids/130-sparc_prom_nodematch_check_getproperty.patch.id
     130-sparc_prom_nodematch_check_getproperty.patch


2005-02-25 07:37:28 GMT	Andres Salomon <dilinger@voxel.net>	patch-135

    Summary:
      129-video_cg3_screen_blanking.patch
    Revision:
      linux--dilinger--0--patch-135

    [SPACE] Fix cg3 blanking; the driver was setting _ENABLE_VIDEO on
POWERDOWN,
    instead of unsetting it.
   =20
   =20

    new files:
     .arch-ids/129-video_cg3_screen_blanking.patch.id
     129-video_cg3_screen_blanking.patch


2005-02-25 07:30:53 GMT	Andres Salomon <dilinger@voxel.net>	patch-134

    Summary:
      128-usb_hcd_driver_model_class.patch
    Revision:
      linux--dilinger--0--patch-134

    [USB] Ensure the hcd driver inits the class_dev struct correctly;
set the
    class earlier, so that the driver doesn't deref it and oops before
it is
    assigned.
   =20
   =20

    new files:
     .arch-ids/128-usb_hcd_driver_model_class.patch.id
     128-usb_hcd_driver_model_class.patch


2005-02-25 07:23:19 GMT	Andres Salomon <dilinger@voxel.net>	patch-133

    Summary:
      127-ia64_ptrace_corner_case.patch
    Revision:
      linux--dilinger--0--patch-133

    [IA64] Fix some ptrace corner cases in ia64.  Nasty stuff.
   =20

    new files:
     .arch-ids/127-ia64_ptrace_corner_case.patch.id
     127-ia64_ptrace_corner_case.patch


2005-02-25 07:13:02 GMT	Andres Salomon <dilinger@voxel.net>	patch-132

    Summary:
      126-ftdi_sio_set_serial_info_baud_base_check.patch
    Revision:
      linux--dilinger--0--patch-132

    [USB] Change ftdi_sio's set_serial_info() to do a correct check for
baud_base;
    it should be checking if baud_base<9600 if the baud_base has
changed.
   =20

    new files:
     .arch-ids/126-ftdi_sio_set_serial_info_baud_base_check.patch.id
     126-ftdi_sio_set_serial_info_baud_base_check.patch




--=20
Andres Salomon <dilinger@voxel.net>

--=-iLMSVF648yTxSvuRrEW1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCIDRs78o9R9NraMQRAmyvAJ4le2m8qjFv5vCyLtO/Fdi1vEk8VwCgr32P
IHNtsqA0ttmVCuhjOv9uOJQ=
=k4c7
-----END PGP SIGNATURE-----

--=-iLMSVF648yTxSvuRrEW1--

