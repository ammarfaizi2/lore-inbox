Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265436AbUAZCsq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 21:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265443AbUAZCsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 21:48:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:42371 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265436AbUAZCsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 21:48:39 -0500
Date: Sun, 25 Jan 2004 18:48:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.2-rc2
Message-ID: <Pine.LNX.4.58.0401251844440.32583@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's being uploaded right now, and the BK trees should already
be uptodate.

There's a x86-64 update and IRDA updates here, and a number of USB storage
fixes. The rest is pretty small. Full changelog from -rc1 appended.

		Linus

----

Summary of changes from v2.6.2-rc1 to v2.6.2-rc2
============================================

Adam Kropelin:
  o input: Always wait for hid request completion in hiddev before
    returning to the caller process.

Andi Kleen:
  o x86-64 merge
  o Kconfig fixes for x86-64

Andrew Morton:
  o [NET]: Do not mark dummy_free_one() __exit in dummy.c driver
  o RAID-6 fixes
  o document RAID-6 support in mdadm-1.5.0
  o ppc64: add missing sched_balance_exec() call
  o ppc64: include i2c in config
  o LSI Logic MegaRAID3 PCI ID
  o RAID-6 fix for IA-64
  o ppc32: Fixes to the signal context code
  o Fix rq_for_each_bio() macro again
  o md: Fix possible hang in raid shutdown
  o Fix CPU hotplug in networking
  o aha1542 warning fix
  o IDE build fix
  o pdc202xx_new.c: fix PDC20270/1 init on the Xserve Apple machines
  o Array overindexing in w9968cf
  o DMI update fix
  o The RAW_GETBIND compat_ioctl fails
  o request_firmware(): use del_timer_sync()
  o i8042 timer fix

Andrey Borzenkov:
  o input: Move devfs entries for joystick into /dev/input

Bart Samwel:
  o [NET]: Return 'unsigned char *' from *skb_pull*() routines

Ben Collins:
  o [VIDEO]: kbuildify the promcons_tbl and logo source files
  o [SPARC64]: Move setting of current_thread_info()->cpu to
    smp_prepare_boot_cpu()
  o [SPARC64]: Add CONFIG_DEBUG_BOOTMEM option
  o [SPARC64]: Correctly mask the physical address for remapping the
    kernel TLB's
  o [SUNZILOG]: Fix locking in cases where UART layer has grabbed the
    lock already
  o [IDE]: Fix compilation warning

Chas Williams:
  o [ATM]: [horizon] avoid warning about limited range of data type

Dave Jones:
  o Check for MCE ability before checking registers
  o PCI probing typo
  o OOSTORE needs MTRR
  o Reduce stack usage in w9966 driver
  o Restore 2.4 MTRR feature
  o logic error in aty128fb
  o Remove unused CONFIG symbol
  o Reduce stack usage in ttusb driver
  o Correct CPUs printout on boot
  o Remove useless cruft from ATM HE driver
  o logic error in radeonfb
  o logic error in XFS
  o DMI updates from 2.4
  o Update post-halloween doc url

David S. Miller:
  o [SPARC64]: Fix 32-bit execve out_mm error path
  o [TTUSB]: ttusb_dec.c needs linux/init.h
  o [SPARC64]: Update defconfig
  o [SPARC64]: Add missing sched_balance_exec() to 32-bit compat
    execve()

David Stevens:
  o [MULTICAST]: multicast loop with include filters fix

Dean Roehrich:
  o [XFS] In xfs_bulkstat, we need to do the readahead loop always

Dirk Jagdmann:
  o input: Add backslash and 102nd key to amikbd.c list of scancodes

Dmitry Torokhov:
  o input: Allow Synaptics packet rate to be controlled by the
    psmouse_rate= option.
  o input: If we get a byte with timeout or parity flags in psmouse.c,
    we take the appropriate action. (throw the byte away, reset byte
    counter, return NAK if acking, and complain).

Eric Sandeen:
  o [XFS] Fix for large allocation groups, so that extent sizes will
    not overflow pagebuf lengths.

Gerd Knorr:
  o selinux build fix
  o video4linux driver documentation update

Glenn Burkhardt:
  o input: Properly recompute initial values upon recalibration in
    joydev

Helge Deller:
  o input: Bugfixes in atkbd and psmouse-base probing. (use unsigned
    char param[] in atkbd_event, like everywhere else, use param[0]
    instead of *param at the same place, properly set serio->private to
    NULL if probe fails in both atkbd and psmouse, and fix
    preinitializing of the return buffer in *_command() funcitons.)
  o input: Add support for HP PARISC keyboards to atkbd.c

Hideaki Yoshifuji:
  o [IPV6]: Fix several comment spelling errors and typos

Hirofumi Ogawa:
  o [netdrvr 8139cp] fix NAPI race

James Bottomley:
  o drivers/scsi/Kconfig URL update: resource.cx
  o aic7xxx parallel build

James Morris:
  o [IPSEC]: Guard against potentially fatal stack usage for auth_data

Jean Tourrilhes:
  o [IRDA]: Update dongle api
  o [IRDA]: Update actisys-sir driver
  o [IRDA]: Update esr-sir driver
  o [IRDA]: Update tekram-sir driver
  o [IRDA]: Add litelink-sir driver
  o [IRDA]: Add act200l-sir driver
  o [IRDA]: Add girbil-sir driver
  o [IRDA]: Add ma600-sir driver
  o [IRDA]: Add mcp2120-sir driver
  o [IRDA]: Add old_belkin-sir driver
  o [IRDA]: Kconfig changes to enable new drivers into the build, from
    Martin Diehl

Jeff Garzik:
  o [BK] add two helper scripts to Documentation/BK-usage

Jens Axboe:
  o remove mt rainier warning

Johann Deneux:
  o input: Fixes and updates of the USB ForceFeedback drivers

Krishna Kumar:
  o [IPV6]: Explicity set *dst to NULL at top of ip6_dst_lookup()

Linus Torvalds:
  o Fix APIC timer initialization
  o Fix up he.c misuse of pci_pool_create() that slipped in.

Marcel Holtmann:
  o input: Added BUS_BLUETOOTH definition for BlueTooth HID devices

Mark Haverkamp:
  o Fix for aacraid and high memory on 2.6.1

Michael Hunold:
  o Fix up 'linux-dvb' maintainers entry

Mikael Pettersson:
  o non-integrated local APIC LVTT init compatibility

Panagiotis Issaris:
  o Graphire3 support

Pavel Machek:
  o input: Alt-arrow console switch is routinely dropped under high
    load. This patch fixes it: alt-arrow has to start from console _we
    want to switch to_, if switch is already pending.

Peter Berg Larsen:
  o input: i8042.c: Add exists=0 into an error path, change the mux/aux
    init order to make some of the probing code (second irq probe)
    unnecessary.

Richard Henderson:
  o [ALPHA] Tidy ELF_HWCAP and ELF_PLATFORM
  o [ALPHA] Tidy buglets in sigreturn paths

Russell King:
  o [PCMCIA] Add refcounting to struct pcmcia_bus_socket
  o [PCMCIA] Get rid of racy interruptible_sleep_on()
  o [PCMCIA] Remove write-only socket_dev
  o [PCMCIA] Remove unused variable warnings
  o [SERIAL] Eliminate a couple of redundant tests
  o [SERIAL] Fix missing NULL check
  o [SERIAL] Use tty_name() when printing the tty name

Rusty Russell:
  o [NET]: Simplify net/flow.c per-cpu handling

Stephen Hemminger:
  o [IPV6]: More missing sysctl table sentinels in addrconf.c
  o Make xircom cardbus handle shared irq

Tom Rini:
  o Elvis^H^H^H^H^HPaul has left the building

Ville Nuorvala:
  o [IPV6]: Fix link-local address check in datagram.c
  o [IPV6]: Add and use new 'strict' parameter to ip6_chk_addr()
  o [IPV6]: addrconf_sysctl_forward_strategy() needs to invoke
    rt6_purge_dflt_routers() too

Vojtech Pavlik:
  o input: Move keycode definitions around to get as close to 2.4
    compatibility as we can at the moment. This also kills KEY_103RD,
    because PS/2 keyboards don't have it and everyone is expecting to
    get KEY_BACKSLASH anyway. Fix rawmode generation for PrintScreen
    key, too.
  o input: Add support for Logitech MX700 mouse
  o input: Expect only one character in interrupt in i8042.c, this
    eases the load on the controller (only one status read per
    interrupt). Also do polling only some time after an interrupt
    happened.
  o input: Add informational printk()s to atkbd.c
  o input: Add IBM GamePad to the BADPAD list
  o input: Key 89 is RO, not ROMAJI
  o input: Add a missing space in atkbd warning message
  o input: Make scancode for a Sun5 type keyboard one of those not
    ignored because of protocol nastiness.

