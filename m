Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVBWFIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVBWFIO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 00:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVBWFIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 00:08:11 -0500
Received: from faye.voxel.net ([69.9.164.210]:24776 "EHLO faye.voxel.net")
	by vger.kernel.org with ESMTP id S261295AbVBWFGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 00:06:42 -0500
Subject: 2.6.10-as5
From: Andres Salomon <dilinger@voxel.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YmO7r6LnBEpHYMJO8vRB"
Date: Tue, 22 Feb 2005 23:08:40 -0500
Message-Id: <1109131720.9362.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YmO7r6LnBEpHYMJO8vRB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Here's 2.6.10-as5.  2.6.10-as4 was never officially announced; it had
issues (note to self; test, *then* tag).  Distributors should note that
there is an ABI/API change in this release, due to
114-netfilter_private_queues.patch changing ipv4 related function args.
Modules that use these will most likely need to be rebuilt.

Lots of security fixes in here; it's probably a good idea to upgrade.
If I'm missing any security related stuff, please let me know.  I have
been travelling, so my apologies to anyone who hasn't gotten a quick
response from me.  I will also be without an internet connection between
Feb 25th and March 5, so don't expect responses between then.

The -as tree is intended to include only security and bugfixes, from
various sources.  I do not include hardware driver updates
(specifically, anything that changes how the hardware registers
themselves are probed/poked), large subsystem updates, cleanups, and so
on; only fixes that will not contain regressions.  The hope is that
vendors/distributors can use this tree as a base for their kernels.  It
is also what I'd want a 2.6.x.y tree to have.

The kernel patches can be grabbed from here:
http://www.acm.cs.rpi.edu/~dilinger/patches/2.6.10/as5/

4c44b02bb9fe6295bb683e364604d74f  ChangeLog
72421ac55f99af28e0bae87b948a241e  linux-2.6.10-as5.tar.gz
1a9c1a7ec584c67a91c307ce8169f164  patch-2.6.10-as5.gz

Changes from 2.6.10-as3:

2005-02-23 02:58:11 GMT	Andres Salomon <dilinger@voxel.net>	patch-131

    Summary:
      tag 2.6.10-as5
    Revision:
      linux--dilinger--0--patch-131

   =20
   =20

    modified files:
     000-extraversion.patch


2005-02-23 01:53:58 GMT	Andres Salomon <dilinger@voxel.net>	patch-130

    Summary:
      125-netfilter_private_queues_2.patch
    Revision:
      linux--dilinger--0--patch-130

    [SECURITY] Add missing bits needed to make
114-netfilter_private_queues.patch
    compile.  Patch stolen from ubuntu (mainly to keep the same ABI).
   =20

    new files:
     .arch-ids/125-netfilter_private_queues_2.patch.id
     125-netfilter_private_queues_2.patch


2005-02-22 13:55:01 GMT	Andres Salomon <dilinger@voxel.net>	patch-129

    Summary:
      124-setsid_tty_sem_missing_header.patch
    Revision:
      linux--dilinger--0--patch-129

    [SECURITY] 103-setsid_tty_sem_locking_races.patch was missing a
header file,
    causing -as4 to not compile.
   =20
   =20

    new files:
     .arch-ids/124-setsid_tty_sem_missing_header.patch.id
     124-setsid_tty_sem_missing_header.patch


2005-02-22 09:14:25 GMT	Andres Salomon <dilinger@voxel.net>	patch-128

    Summary:
      tag 2.6.10-as4
    Revision:
      linux--dilinger--0--patch-128

   =20
   =20

    modified files:
     000-extraversion.patch


2005-02-22 09:11:15 GMT	Andres Salomon <dilinger@voxel.net>	patch-127

    Summary:
      fix up 123-*.patch
    Revision:
      linux--dilinger--0--patch-127

    Argh, so late, and of course the last patch doesn't apply.
   =20

    modified files:
     123-atm_get_addr_signedness_fix.patch


2005-02-22 09:07:49 GMT	Andres Salomon <dilinger@voxel.net>	patch-126

    Summary:
      123-atm_get_addr_signedness_fix.patch
    Revision:
      linux--dilinger--0--patch-126

    [SECURITY] Fix atm_get_addr()'s usage of its size arg, by making it
    unsigned.  WDYBTGT3-3 on
    http://www.guninski.com/where_do_you_want_billg_to_go_today_3.html
   =20
   =20

    new files:
     .arch-ids/123-atm_get_addr_signedness_fix.patch.id
     123-atm_get_addr_signedness_fix.patch


2005-02-22 09:02:49 GMT	Andres Salomon <dilinger@voxel.net>	patch-125

    Summary:
      122-cpufreq_resume_readd_2.patch
    Revision:
      linux--dilinger--0--patch-125

    [CPUFREQ] Fix a problem w/ 121-cpufreq_resume_readd.patch, where a
return
    value was not being checked correctly.
   =20

    new files:
     .arch-ids/122-cpufreq_resume_readd_2.patch.id
     122-cpufreq_resume_readd_2.patch


2005-02-22 09:01:53 GMT	Andres Salomon <dilinger@voxel.net>	patch-124

    Summary:
      121-cpufreq_resume_readd.patch
    Revision:
      linux--dilinger--0--patch-124

    [CPUFREQ] Somewhere around 2.6.6, a call to cpufreq_driver->resume()
was
    accidentally dropped.  Readd it.
   =20
   =20
   =20

    new files:
     .arch-ids/121-cpufreq_resume_readd.patch.id
     121-cpufreq_resume_readd.patch


2005-02-22 09:00:49 GMT	Andres Salomon <dilinger@voxel.net>	patch-123

    Summary:
      120-openpromfs_property_read_fix.patch
    Revision:
      linux--dilinger--0--patch-123

    Fix an oopsable condition in Openpromfs's property_read().
   =20

    new files:
     .arch-ids/120-openpromfs_property_read_fix.patch.id
     120-openpromfs_property_read_fix.patch


2005-02-22 08:59:49 GMT	Andres Salomon <dilinger@voxel.net>	patch-122

    Summary:
      119-i2c_viapro_i2cdump_overflow.patch
    Revision:
      linux--dilinger--0--patch-122

    [SECURITY] Fix a very hard to exploit buffer overflow in the
i2c-viapro driver.
   =20
   =20

    new files:
     .arch-ids/119-i2c_viapro_i2cdump_overflow.patch.id
     119-i2c_viapro_i2cdump_overflow.patch


2005-02-22 08:58:17 GMT	Andres Salomon <dilinger@voxel.net>	patch-121

    Summary:
      118-i2c_sis5595_setup_pci_config_return_checks.patch
    Revision:
      linux--dilinger--0--patch-121

    [I2C] The i2c-sis5595 was forward ported from 2.4, but the calls to
    read the pci config registers were never updated for 2.6.  As such,
they
    are incorrectly handling the results of the function calls.
   =20
   =20

    new files:
     .arch-ids/118-i2c_sis5595_setup_pci_config_return_checks.patch.id
     118-i2c_sis5595_setup_pci_config_return_checks.patch


2005-02-22 08:57:05 GMT	Andres Salomon <dilinger@voxel.net>	patch-120

    Summary:
      117-reiserfs_file_64bit_size_t_fixes.patch
    Revision:
      linux--dilinger--0--patch-120

    [SECURITY] reiserfs integer fixes; WDYBTGT3-4 on
    http://www.guninski.com/where_do_you_want_billg_to_go_today_3.html
   =20
   =20

    new files:
     .arch-ids/117-reiserfs_file_64bit_size_t_fixes.patch.id
     117-reiserfs_file_64bit_size_t_fixes.patch


2005-02-22 08:56:16 GMT	Andres Salomon <dilinger@voxel.net>	patch-119

    Summary:
      116-n_tty_copy_from_read_buf_signedness_fixes.patch
    Revision:
      linux--dilinger--0--patch-119

    [SECURITY] copy_from_read_buf() fix; WDYBTGT3-2 on
    http://www.guninski.com/where_do_you_want_billg_to_go_today_3.html
    No CAN#, yet.
   =20

    new files:
     .arch-ids/116-n_tty_copy_from_read_buf_signedness_fixes.patch.id
     116-n_tty_copy_from_read_buf_signedness_fixes.patch


2005-02-22 08:55:03 GMT	Andres Salomon <dilinger@voxel.net>	patch-118

    Summary:
      115-proc_file_read_nbytes_signedness_fix.patch
    Revision:
      linux--dilinger--0--patch-118

    [SECURITY] Heap overflow fix in /proc; WDYBTGT3-1 on
    http://www.guninski.com/where_do_you_want_billg_to_go_today_3.html
    No CAN# assigned yet, afaik.
   =20

    new files:
     .arch-ids/115-proc_file_read_nbytes_signedness_fix.patch.id
     115-proc_file_read_nbytes_signedness_fix.patch


2005-02-22 08:52:27 GMT	Andres Salomon <dilinger@voxel.net>	patch-117

    Summary:
      114-netfilter_private_queues.patch
    Revision:
      linux--dilinger--0--patch-117

    [NETFILTER] Amongst netfilter users, skb frag queues were shared.
This could
    cause problems.  See
    http://oss.sgi.com/archives/netdev/2005-01/threads.html#01036 for
more
    details.
   =20

    new files:
     .arch-ids/114-netfilter_private_queues.patch.id
     114-netfilter_private_queues.patch


2005-02-22 08:42:27 GMT	Andres Salomon <dilinger@voxel.net>	patch-116

    Summary:
      113-ip_fragment_ip_summed_set.patch
    Revision:
      linux--dilinger--0--patch-116

    [IPV4] In ip_fragment(), reset ip_summed field in sub-frags.  This
caused
    skb header corruption.  Nasty stuff.
   =20
   =20
   =20

    new files:
     .arch-ids/113-ip_fragment_ip_summed_set.patch.id
     113-ip_fragment_ip_summed_set.patch


2005-02-22 08:13:39 GMT	Andres Salomon <dilinger@voxel.net>	patch-115

    Summary:
      112-audit_receive_skb_double_negative_return_val.patch
    Revision:
      linux--dilinger--0--patch-115

    audit_receive_skb negates the err it receives from
audit_receive_msg.  It
    shouldn't do that.
   =20
   =20

    new files:
     .arch-ids/112-audit_receive_skb_double_negative_return_val.patch.id
     112-audit_receive_skb_double_negative_return_val.patch


2005-02-22 08:03:25 GMT	Andres Salomon <dilinger@voxel.net>	patch-114

    Summary:
      111-security_seclvl_kconfig_dep.patch
    Revision:
      linux--dilinger--0--patch-114

    Add a Kconfig dependency on CRYPTO for SECURITY_SECLVL.
   =20

    new files:
     .arch-ids/111-security_seclvl_kconfig_dep.patch.id
     111-security_seclvl_kconfig_dep.patch


2005-02-22 08:02:17 GMT	Andres Salomon <dilinger@voxel.net>	patch-113

    Summary:
      110-load_module_arg_checking.patch
    Revision:
      linux--dilinger--0--patch-113

    If the parsing of module args failed, the module could still be
loaded
    successfully.  Fix that.
   =20
   =20

    new files:
     .arch-ids/110-load_module_arg_checking.patch.id
     110-load_module_arg_checking.patch


2005-02-22 07:58:14 GMT	Andres Salomon <dilinger@voxel.net>	patch-112

    Summary:
      109-binfmt_elf_loader_solar_designer_fixes.patch
    Revision:
      linux--dilinger--0--patch-112

    [SECURITY] Fix from Solar Designer; the binfmt_elf load routines are
returning
    incorrect values, and are not strict enough in checking the number
of program
    headers.
   =20
   =20

    new files:
     .arch-ids/109-binfmt_elf_loader_solar_designer_fixes.patch.id
     109-binfmt_elf_loader_solar_designer_fixes.patch


2005-02-22 00:43:40 GMT	Andres Salomon <dilinger@voxel.net>	patch-111

    Summary:
      108-xfs_attrmulti_by_handle_limit_mem_alloc.patch
    Revision:
      linux--dilinger--0--patch-111

    [SECURITY] xfs_ioctl(XFS_IOC_ATTRMULTI_BY_HANDLE) calls
    xfs_attrmulti_by_handle, which allocates memory based on user input.
This
    patch adds a check for a max size of memory to alloc; otherwise, a
user
    can potentially DoS the system by exhausting memory.  Not sure
whether root
    is required to open the vnode device, but to be on the safe side...
   =20
   =20

    new files:
     .arch-ids/108-xfs_attrmulti_by_handle_limit_mem_alloc.patch.id
     108-xfs_attrmulti_by_handle_limit_mem_alloc.patch


2005-02-22 00:28:46 GMT	Andres Salomon <dilinger@voxel.net>	patch-110

    Summary:
      107-xfs_finish_reclaim_always_inode.patch
    Revision:
      linux--dilinger--0--patch-110

    [XFS] In xfs_finish_reclaim(), xfs_ireclaim() should always be
called (unless
    there's some sort of locking problem) before returning.
   =20

    new files:
     .arch-ids/107-xfs_finish_reclaim_always_inode.patch.id
     107-xfs_finish_reclaim_always_inode.patch


2005-02-22 00:17:20 GMT	Andres Salomon <dilinger@voxel.net>	patch-109

    Summary:
      106-smbfs_input_validation_and_int_checks.patch
    Revision:
      linux--dilinger--0--patch-109

    [SECURITY] This patch adds various input validation and sanity
checks to
    the smbfs driver; fixes include integer underflow checks in
    smb_proc_readX_data and smb_recv_trans2.
   =20
   =20

    new files:
     .arch-ids/106-smbfs_input_validation_and_int_checks.patch.id
     106-smbfs_input_validation_and_int_checks.patch


2005-02-21 08:16:49 GMT	Andres Salomon <dilinger@voxel.net>	patch-108

    Summary:
      105-cmsg_compat_ok_proper_cmsghdr_struct.patch
    Revision:
      linux--dilinger--0--patch-108

    [NET] CMSG_COMPAT_OK() does a sanity check using the size of a
cmsghdr
    struct, when it should be using a compat_cmsghdr struct, instead.
This
    fixes that.
   =20

    new files:
     .arch-ids/105-cmsg_compat_ok_proper_cmsghdr_struct.patch.id
     105-cmsg_compat_ok_proper_cmsghdr_struct.patch


2005-02-21 07:57:18 GMT	Andres Salomon <dilinger@voxel.net>	patch-107

    Summary:
      104-wan_sdla_firmware_cap_sys_rawio_addition.patch
    Revision:
      linux--dilinger--0--patch-107

    [SECURITY] The SDLA driver only checked CAP_NET_ADMIN when doing
firmware
    uploads.  This patch adds an additional check for CAP_SYS_RAWIO, as
well.
   =20

    new files:
     .arch-ids/104-wan_sdla_firmware_cap_sys_rawio_addition.patch.id
     104-wan_sdla_firmware_cap_sys_rawio_addition.patch


2005-02-21 07:52:37 GMT	Andres Salomon <dilinger@voxel.net>	patch-106

    Summary:
      103-setsid_tty_sem_locking_races.patch
    Revision:
      linux--dilinger--0--patch-106

    [SECURITY] CAN-2005-0178; fix races in tty handling in setsid().
This CAN
    may have the most useless descriptions ever.
   =20
   =20

    new files:
     .arch-ids/103-setsid_tty_sem_locking_races.patch.id
     103-setsid_tty_sem_locking_races.patch


2005-02-21 07:35:02 GMT	Andres Salomon <dilinger@voxel.net>	patch-105

    Summary:
      102-cosa_sppp_channel_init_delay_attach.patch
    Revision:
      linux--dilinger--0--patch-105

    Fix buglet in cosa's sppp_channel_init(); do not call sppp_attach()
until
    the netdev contains info that sppp_attach needs.
   =20
   =20

    new files:
     .arch-ids/102-cosa_sppp_channel_init_delay_attach.patch.id
     102-cosa_sppp_channel_init_delay_attach.patch


2005-02-20 06:44:35 GMT	Andres Salomon <dilinger@voxel.net>	patch-104

    Summary:
      101-ppc64_hugetlb_mm_free_pgd_unlock.patch
    Revision:
      linux--dilinger--0--patch-104

    [PPC64] In hugetlb_mm_free_pgd(), mm->page_table_lock is locked, but
never
    unlocked in the event of an error.  This patch fixes that.
   =20

    new files:
     .arch-ids/101-ppc64_hugetlb_mm_free_pgd_unlock.patch.id
     101-ppc64_hugetlb_mm_free_pgd_unlock.patch


2005-02-20 06:41:03 GMT	Andres Salomon <dilinger@voxel.net>	patch-103

    Summary:
      100-nls_ascii_overflow_fix.patch
    Revision:
      linux--dilinger--0--patch-103

    [SECURITY] CAN-2005-0177; fix nls_ascii tables, as they were too
small, and
    an attacker could cause an overflow.
   =20

    new files:
     .arch-ids/100-nls_ascii_overflow_fix.patch.id
     100-nls_ascii_overflow_fix.patch


2005-02-19 20:27:11 GMT	Andres Salomon <dilinger@voxel.net>	patch-102

    Summary:
      099-jfs_commit_inode_commit_race.patch
    Revision:
      linux--dilinger--0--patch-102

    [JFS] Fix race in jfs_commit_inode(); before actually doing the
commit,
    retest to ensure that the inode is both dirty and linked.
   =20

    new files:
     .arch-ids/099-jfs_commit_inode_commit_race.patch.id
     099-jfs_commit_inode_commit_race.patch


2005-02-19 20:06:17 GMT	Andres Salomon <dilinger@voxel.net>	patch-101

    Summary:
      098-jffs2_do_mount_fs_init_bad_count.patch
    Revision:
      linux--dilinger--0--patch-101

    [JFFS2] Initialize each eraseblock's bad_count to 0 in
jffs2_do_mount_fs().
    Unitialized memory sure is fun, eh?
   =20
   =20

    new files:
     .arch-ids/098-jffs2_do_mount_fs_init_bad_count.patch.id
     098-jffs2_do_mount_fs_init_bad_count.patch


2005-02-19 19:53:12 GMT	Andres Salomon <dilinger@voxel.net>	patch-100

    Summary:
      097-mtd_s3c2410_nand_inithw_calc_rate_fix.patch
    Revision:
      linux--dilinger--0--patch-100

    [MTD] s3c2410_nand_inithw() was pulling timing information from the
wrong
    place, making the timing incorrect.  This patch makes it pull the
info from
    the right place.
   =20

    new files:
     .arch-ids/097-mtd_s3c2410_nand_inithw_calc_rate_fix.patch.id
     097-mtd_s3c2410_nand_inithw_calc_rate_fix.patch


2005-02-19 19:44:21 GMT	Andres Salomon <dilinger@voxel.net>	patch-99

    Summary:
      096-mtd_formatblock_zero_before_assignment.patch
    Revision:
      linux--dilinger--0--patch-99

    [MTD] Inside NFTL_formatblock and INFTL_formatblock, the code was
previously
    assigning values to instr, then zero'ing out the values.  Instead,
move the
    assignment to after the memset.
   =20
   =20

    new files:
     .arch-ids/096-mtd_formatblock_zero_before_assignment.patch.id
     096-mtd_formatblock_zero_before_assignment.patch


2005-02-19 07:48:31 GMT	Andres Salomon <dilinger@voxel.net>	patch-98

    Summary:
      095-jffs2_build_filesystem_memory_leak.patch
    Revision:
      linux--dilinger--0--patch-98

    [JFFS2] Fix memory leak in jffs2_build_filesystem(), if
jffs2_scan_medium
    fails.
   =20
   =20

    new files:
     .arch-ids/095-jffs2_build_filesystem_memory_leak.patch.id
     095-jffs2_build_filesystem_memory_leak.patch


2005-02-19 06:33:16 GMT	Andres Salomon <dilinger@voxel.net>	patch-97

    Summary:
      094-scsi_device_set_state_missing_oldstate.patch
    Revision:
      linux--dilinger--0--patch-97

    [SCSI] scsi_device_set_state() might be setting a device offline, w/
an
    oldstate of BLOCK; that shouldn't be considered an error.  Add the
missing
    state transition.
   =20
   =20

    new files:
     .arch-ids/094-scsi_device_set_state_missing_oldstate.patch.id
     094-scsi_device_set_state_missing_oldstate.patch


2005-02-19 04:05:24 GMT	Andres Salomon <dilinger@voxel.net>	patch-96

    Summary:
      093-e1000_eeprom_read_off_by_one.patch
    Revision:
      linux--dilinger--0--patch-96

    The e1000 driver's read_eeprom and write_eeprom functions allowed a
bit to
    much data to be read/written; an extra word.  Fix that.
   =20
   =20

    new files:
     .arch-ids/093-e1000_eeprom_read_off_by_one.patch.id
     093-e1000_eeprom_read_off_by_one.patch


2005-02-19 03:57:28 GMT	Andres Salomon <dilinger@voxel.net>	patch-95

    Summary:
      092-net_sched_police_locate_sanity_check_input.patch
    Revision:
      linux--dilinger--0--patch-95

    [NET] Some sanity checks are needed to ensure payloads are the same
size
    as the structures they're being copied into.  AFAICT, there's no way
for a
    malicious user to inject a payload in here (it looks like
police_locate
    stuff is called during routing changes by root); however, I can't
say that
    I'm too familiar w/ tcf stuff.
   =20

    new files:
     .arch-ids/092-net_sched_police_locate_sanity_check_input.patch.id
     092-net_sched_police_locate_sanity_check_input.patch


2005-02-19 03:08:59 GMT	Andres Salomon <dilinger@voxel.net>	patch-94

    Summary:
      091-alsa_emu8000_load_fx_skip_header.patch
    Revision:
      linux--dilinger--0--patch-94

    [ALSA] emu8000's load_fx() loads a userspace blob, and should be
skipping over
    the header.
   =20
   =20

    new files:
     .arch-ids/091-alsa_emu8000_load_fx_skip_header.patch.id
     091-alsa_emu8000_load_fx_skip_header.patch


2005-02-19 02:53:07 GMT	Andres Salomon <dilinger@voxel.net>	patch-93

    Summary:
      090-alsa_midi_emulation_chorus_reverb_swap.patch
    Revision:
      linux--dilinger--0--patch-93

    [ALSA] seq_midi_emul.c had CHORUS_MODE and REVERB_MODE swapped in
sysex().
    This patch fixes that.
   =20

    new files:
     .arch-ids/090-alsa_midi_emulation_chorus_reverb_swap.patch.id
     090-alsa_midi_emulation_chorus_reverb_swap.patch


2005-02-19 02:44:56 GMT	Andres Salomon <dilinger@voxel.net>	patch-92

    Summary:
      089-i386_acpi_backwards_ifdef.patch
    Revision:
      linux--dilinger--0--patch-92

    [I386] An ACPI related printk is wrapped in an #ifdef that should be
an
    #ifndef.  Correct that.
   =20
   =20

    new files:
     .arch-ids/089-i386_acpi_backwards_ifdef.patch.id
     089-i386_acpi_backwards_ifdef.patch


2005-02-19 02:37:34 GMT	Andres Salomon <dilinger@voxel.net>	patch-91

    Summary:
      088-ibmvscsi_event_struct_use_after_free.patch
    Revision:
      linux--dilinger--0--patch-91

    The ibmvscsi driver has paths that free evt_struct, and then proceed
to
    use it.  That's clearly a no-no in SMP/threaded contexts; once an
evt_struct
    is free, something else may grab it.  So, this patch:
    	- moves the free_event_struct() to after usage of the evt_struct
    	- creates a single path for cleanup
    	- calls evt_struct->done during cleanup, which is something that
    	  should've been happening.
   =20
   =20

    new files:
     .arch-ids/088-ibmvscsi_event_struct_use_after_free.patch.id
     088-ibmvscsi_event_struct_use_after_free.patch



--=20
Andres Salomon <dilinger@voxel.net>

--=-YmO7r6LnBEpHYMJO8vRB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCHAHI78o9R9NraMQRAgRlAKCnl7PyLiJ8kSstGc0oM62IcdDn6wCff9Jc
t1rw1OR1XlojsY4BCRnipiM=
=WdJl
-----END PGP SIGNATURE-----

--=-YmO7r6LnBEpHYMJO8vRB--

