Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263160AbUJ2CM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbUJ2CM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 22:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbUJ2CL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 22:11:26 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:26033 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263247AbUJ2CIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 22:08:45 -0400
Date: Thu, 28 Oct 2004 22:02:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [RFC] Linux 2.6.9.1-pre1 contents
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200410282205_MC3-1-8D77-F5C5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been working on a set of patches that I currently call
Linux 2.6.9.1.  What follows is the file 000-MANIFEST, the table
of contents for the patchset.  Since the patchset is currently
65 separate files and the administrator of kernel.org says I
have to be in the MAINTAINERS file to post patches there, I
propose to upload the whole patchset as a uuencoded .tar.bz2
to the mailing list (it is about 42K.)

Comments and suggestions for addition or removal of patches welcomed.

-------------------------------------------------------------------------------

000-MANIFEST

        (this file) Contents of patchset 2.6.9.1-pre1


--- NOTE ----------------------------------
Always apply patches in alphabetical order:
        $ ls <dir>/*.patch | sort | xargs --verbose -n 1 patch -p1 -i 
To un-apply:
        $ ls <dir>/*.patch | sort -r | xargs --verbose -n 1 patch -R -p1 -i 
--- NOTE ----------------------------------


000-Makefile.1-pre1.patch

        Update Makefile version

3c59x_pci_disable_device.patch

        Add missing pci_disable_device() in failure paths
        NOTE: 3c59x_remove_one() needs disable call, too
              ...as do tulip, natsemi, etc.

8250_pnp.patch

        Trivial 8250 Pnp fix

ac3_compiler.h_assembly.patch
ac3_config_via_velocity.patch
ac3_cpia_fixes.patch
ac3_i8042.patch
ac3_i8xx_tco_timer.patch
ac3_moxa_wakeup.patch
ac3_ppp_hangup.patch
ac3_skbuff_tso.patch
ac3_smbfs_request.patch
ac3_vm_io.patch

        Fixes from 2.6.9-ac3
                - "blink keyboard lights on panic" code
                  was removed from the i8042 patch

ac4_aic7xxx.patch
ac4_visor.patch

        Fixes from 2.6.9-ac4

cdrom_mrw.patch

        Some drives were incorrectly identified
          as Mt. Ranier capable

compat_ioctl_tiocsbrk.patch

        Add 32-bit compatible IOCTLS

cross_compile_makefile.patch

        Fix Makefile for some cross-compile configs

decnet_connrefused.patch

        Trivial decnet fix

delay_rq_lock.patch

        Prevent auditing deadlock

dm_duplicate_kfree.patch

        Remove duplicate kfree from dm_target.c

exec_no_binfmt.patch

        Return an error on exec with no binfmt handlers

exec_timers_and_signals.patch

        Fix three bugs in exec with threaded apps

fbdev-fix-logo-vga16fb.patch

        Restore missing penguin logo on vga16fb at boot time
          (included because user complained loudly)

hvsi_oops.patch

        Prevent oops in hvsi driver

i2c_amd_kconfig.patch

        Add missing dependency and clarify comments

ide_maxtor_probe.patch

        Another Maxtor IDE drive serial number oddity

ide_no_chs.patch

        Allow ide drives with no C/H/S info to work

ide_pdc202xx_lba48.patch

        LBA48 fix for PDC20267

ide_smart_threshold.patch

        Fix obvious bug in smart_threshold function

init_poison.patch

        Poison __init memory before freeing

initpipefs_proper.patch

        Make init of pipefs an fs_initcall

ioapic_init_section.patch

        Remove __init from referenced ioapic functions

ioapic_on_nvidia_boards.patch

        Ignore all ACPI timer overrides on nVIDIA x86-64 boards
        (Note: enable of IO-APIC in original patch removed
         due to bug reports)

log_buf_shift.patch

        Allow larger kernel log buffer

media_toaster_share_irq.patch

        Permit IRQ sharing on Media Toaster (sym53c500_cs)

memset_signal_ppc64.patch

        Correct memset size in ppc64 signal code

msleep_at_least_amount.patch

        make msleep sleep at least the amount of time asked for

negative_statm.patch

        Don't allow statm fields to go negative

netif_rx_ni_preempt_safe.patch

        Make netif_rx_ni preempt-safe
        NOTE: A better (uninlined) fix is in 2.6.10-rc

netpoll_setup_crash.patch

        Prevent crash on netpoll setup

nfs_fqdn_len_2.patch

        Allow longer FQDN in NFS mount

o_direct_mmapped_io.patch

        Fix O_DIRECT vs. mmapped IO problem
        (Not a complete fix, but at least an improvement)

parport_superio.patch

        Gets superio parports working again

pcdp_swap_args.patch

        Correct argument order in pcdp.c

pci_dev_put.patch

        Define pci_dev_put() for non-PCI builds

percpu_alignment.patch

        Make percpu alignment work right on x86 cpus

pnpbios_msleep.patch

        Use msleep_interruptible instead of schedule_timeout

proc_wrong_parent.patch

        Backport BK changesets 1.2000.4.120 and 1.2000.12.16
        Fixes wrong parent process display in /proc

quoted_env_vars_3.patch

        Unquote kernel arg strings

return_enfile_not_emfile.patch

        return -ENFILE when out of handles, not -EMFILE

s390_sacf_exception.patch

        Fix s390 security hole

spurious_oomkill.patch

        Stop spurious out-of-memory process kills

suspend_time_adjust.patch

        Correct system time after suspend

tcp_output_skbuff_fix.patch

        With TSO, skbuffs were allocated with wrong size

tso_needs_sg.patch

        TSO feature requires SG

unbalanced_tasks_v3.patch

        Scheduler fix for pinned tasks causing too much rebalance

usr_courier_pnp_id.patch

        Add USR Courier PnP modem ID

vga_console_font.patch

        Fix two small bugs in VGA console
        
vm_dirty_ratio_clamp.patch

        Prevent divide-by-zero

vm_pages_scanned_active_list.patch

        kswapd: pages scanned were not counted properly

x86_64_syscall32_initdata.patch

        More __init/__initdata fixes



--Chuck Ebbert  28-Oct-04  20:16:13
