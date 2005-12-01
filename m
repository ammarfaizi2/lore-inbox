Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVLAGkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVLAGkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 01:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVLAGkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 01:40:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932092AbVLAGkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 01:40:17 -0500
Date: Wed, 30 Nov 2005 22:40:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.15-rc4
Message-ID: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, so -rc3 wasn't so good.

[ Everybody chorus now: "Nooo?" ]

No.

[ Everybody chorus now: "Really?" ]

Really.

[ Everybody chorus now: "So what?" ]

So I made an -rc4.

This one hopefully doesn't have those pesky PageReserved() annoyances, and 
the EHCI host controller bootup problems. 

[ Everybody chorus now: "Hallelujah!" ]

Indeed.

It also has some atm, mtd and cifs updates.

		Linus

[ Btw, some drivers will now complain loudly about their nasty mis-use of 
  page remapping, and that migh look scary, but it should all be good, and 
  we'd love to see the detailed output of dmesg on such machines. ]

---
Adrian Bunk:
      [MTD] Make functions static, include header files with prototypes
      [IPV4]: make two functions static
      [NETFILTER] ipv4: small cleanups
      [IPV6]: make two functions static

Alan Stern:
      USB: documentation update

Antonino A. Daplas:
      fbdev: cirrusfb: Driver cleanup and bug fixes

Arjan van de Ven:
      [NET]: Add const markers to various variables.

Ben Collins:
      Fix missing pfn variables caused by vm changes

Benjamin Herrenschmidt:
      USB: Fix USB suspend/resume crasher (#2)

Chas Williams:
      [ATM]: linux/config.h only needed for #ifdef __KERNEL__ section
      [ATM]: [adummy] dummy ATM driver (similar to net/dummy)

Christoph Hellwig:
      fix megaraid.c locking

Dave Jones:
      [ATM]: [lanai] lanai missing unregister
      Additional device ID for Conexant AccessRunner USB driver

David Brownell:
      USB: ehci fixups

David Gibson:
      Fix crash when ptrace poking hugepage areas

David S. Miller:
      [SPARC64]: Fix >8K I/O mappings.

David Woodhouse:
      [MTD] Make some tables 'const' so they can live in .rodata

Dean Roe:
      [IA64] - Make pfn_valid more precise for SGI Altix systems

Egbert Eich:
      SiS DRM: Fix possible NULL dereference

Grant Coady:
      pci_ids.h: remove duplicate entries

Hugh Dickins:
      pfnmap: remove src_page from do_wp_page
      pfnmap: do_no_page BUG_ON again

Jan Pieter:
      [ATM]: drivers/atm/atmdev_init.c no longer necessary

Jean Delvare:
      hwmon: w83792d fix unused fan pins

Jeff Mahoney:
      reiserfs: handle cnode allocation failure gracefully

John Bowler:
      [MTD] maps/ixp4xx: half-word boundary and little-endian fixups

Keshavamurthy Anil S:
      [IA64] Remove getting break_num by decoding instruction

Linus Torvalds:
      Support strange discontiguous PFN remappings
      VM: add common helper function to create the page tables
      cow_user_page: fix page alignment
      Revert "drivers/message/fusion/mptbase.c: make code static"
      VM: add "vm_insert_page()" function
      Revert "pci_ids.h: remove duplicate entries"
      Linux v2.6.15-rc4

Luiz Capitulino:
      [MTD] maps: sparse fixup

Maciej W. Rozycki:
      [MTD] devices/ms02-nv: phys/virt address fixups

Mark Fortescue:
      fbdev: cg3fb: Kconfig fix

Matt Helsley:
      process events connector: uid_t gid_t size issues

Mike Stroyan:
      [IPV4] tcp/route: Another look at hash table sizes

Mitchell Blank Jr:
      [ATM]: always return the first interface for ATM_ITF_ANY
      [ATM]: atm_pcr_goal() doesn't modify its argument's contents -- mark it as const
      [ATM]: [lanai] better constification
      [ATM]: attempt to autoload atm drivers
      [ATM]: [lanai] kill lanai_ioctl() which just contains some old debugging code

Nick Piggin:
      Fix vma argument in get_usr_pages() for gate areas

Nicolas Pitre:
      [MTD] cfi_cmdset_0001: relax locking rules for multi hardware partition support

Olaf Hering:
      powerpc: prevent stack corruption in call_prom_ret

Otavio Salvador:
      ppc: Export symbol needed by MOL

Paolo Galtieri:
      ppc: fix floating point register corruption
      ppc: fix floating point register corruption

Paul Mackerras:
      powerpc: Export __flush_icache_range for 32-bit
      powerpc: Fix bug causing FP registers corruption on UP + preempt

Pavel Machek:
      fix swsusp on machines not supporting S4

Richard Purdie:
      [MTD] chips: make sharps driver usable again

Roman Zippel:
      hfsplus: don't modify journaled volume

Sean Young:
      [MTD] RFD_FTL: Use lanana assigned major device number

Shaohua Li:
      setting irq affinity is broken in ia32 with MSI enabled

Stanislaw Gruszka:
      [ATM]: avoid race conditions related to atm_devs list
      [ATM]: deregistration removes device from atm_devs list immediately

Steve French:
      [CIFS] When file is deleted locally but later recreated on the server
      [CIFS] Fix missing permission check on setattr when noperm mount option is
      [CIFS] Fix umount --force to wake up the pending response queue, not just
      [CIFS] Missing parenthesis and typo in previous fix
      [CIFS] For previous fix, mode on mkdir needed S_IFDIR left out.

Thierry Vignaud:
      fix rebooting on HP nc6120 laptop

Thomas Gleixner:
      [JFFS2] Fix the slab cache constructor of 'struct jffs2_inode_info' objects.
      [MTD] Remove bogus PQ2FADS driver

Todd Poynor:
      [MTD] CFI: Use 16-bit access to autoselect/read device id data

Trond Myklebust:
      VM: Fix typos in get_locked_pte

YOSHIFUJI Hideaki:
      [IPV6]: Implement appropriate dummy rule 4 in ipv6_dev_get_saddr().

--- diffstat ---

 Documentation/usb/error-codes.txt            |    5 -
 Makefile                                     |    2 
 arch/i386/kernel/io_apic.c                   |    4 -
 arch/i386/kernel/reboot.c                    |    8 +
 arch/ia64/kernel/ia64_ksyms.c                |    1 
 arch/ia64/kernel/kprobes.c                   |    2 
 arch/ia64/kernel/traps.c                     |   18 ---
 arch/powerpc/kernel/ppc_ksyms.c              |    6 -
 arch/powerpc/kernel/process.c                |   62 ++++------
 arch/powerpc/kernel/prom_init.c              |    2 
 arch/ppc/kernel/ppc_ksyms.c                  |    2 
 arch/ppc/kernel/process.c                    |    6 +
 arch/sparc64/mm/generic.c                    |    1 
 drivers/atm/Kconfig                          |    7 +
 drivers/atm/Makefile                         |    1 
 drivers/atm/adummy.c                         |  168 ++++++++++++++++++++++++++
 drivers/atm/atmdev_init.c                    |   54 --------
 drivers/atm/atmtcp.c                         |   20 ---
 drivers/atm/lanai.c                          |  102 +---------------
 drivers/char/drm/drm_context.c               |    5 +
 drivers/hwmon/w83792d.c                      |   25 +++-
 drivers/message/fusion/mptbase.c             |    6 +
 drivers/message/fusion/mptbase.h             |    2 
 drivers/mtd/chips/cfi_cmdset_0001.c          |   10 +-
 drivers/mtd/chips/cfi_probe.c                |    8 +
 drivers/mtd/chips/sharp.c                    |  123 ++++++++++---------
 drivers/mtd/devices/block2mtd.c              |    6 -
 drivers/mtd/devices/ms02-nv.c                |    6 -
 drivers/mtd/ftl.c                            |    6 -
 drivers/mtd/maps/Kconfig                     |    6 -
 drivers/mtd/maps/Makefile                    |    1 
 drivers/mtd/maps/ixp4xx.c                    |   78 ++++++++++--
 drivers/mtd/maps/nettel.c                    |    4 -
 drivers/mtd/maps/pci.c                       |    4 -
 drivers/mtd/maps/physmap.c                   |    3 
 drivers/mtd/maps/sc520cdp.c                  |    4 -
 drivers/mtd/nand/nandsim.c                   |    2 
 drivers/mtd/rfd_ftl.c                        |    6 -
 drivers/scsi/megaraid.c                      |   29 ++--
 drivers/usb/atm/cxacru.c                     |    3 
 drivers/usb/atm/usbatm.c                     |    4 -
 drivers/usb/core/hcd-pci.c                   |    3 
 drivers/usb/core/hcd.c                       |   15 ++
 drivers/usb/core/hcd.h                       |    7 +
 drivers/usb/host/ehci-pci.c                  |   46 ++++++-
 drivers/usb/host/ehci-q.c                    |   24 ++--
 drivers/usb/host/ehci-sched.c                |   18 ++-
 drivers/usb/host/ohci-hcd.c                  |    6 +
 drivers/usb/host/ohci-hub.c                  |   24 +++-
 drivers/usb/host/ohci-pci.c                  |   27 ++++
 drivers/usb/host/uhci-hcd.c                  |    6 +
 drivers/video/Kconfig                        |   13 +-
 drivers/video/cirrusfb.c                     |   15 +-
 fs/cifs/CHANGES                              |    8 +
 fs/cifs/README                               |   30 ++++-
 fs/cifs/TODO                                 |    4 -
 fs/cifs/cifsfs.c                             |   23 +++-
 fs/cifs/cifssmb.c                            |   25 ++++
 fs/cifs/dir.c                                |   34 ++++-
 fs/cifs/inode.c                              |   50 ++++++--
 fs/cifs/misc.c                               |   17 ++-
 fs/cifs/netmisc.c                            |    4 -
 fs/cifs/transport.c                          |    1 
 fs/exec.c                                    |   12 --
 fs/hfsplus/hfsplus_fs.h                      |    1 
 fs/hfsplus/hfsplus_raw.h                     |   12 +-
 fs/hfsplus/options.c                         |    6 +
 fs/hfsplus/super.c                           |   20 +++
 fs/jffs2/fs.c                                |    2 
 fs/jffs2/super.c                             |    2 
 fs/reiserfs/journal.c                        |    9 +
 include/asm-ia64/page.h                      |    3 
 include/linux/atmdev.h                       |   18 +--
 include/linux/cn_proc.h                      |    8 +
 include/linux/mm.h                           |    4 +
 include/linux/mtd/cfi.h                      |   18 +++
 kernel/power/main.c                          |   21 ++-
 kernel/ptrace.c                              |    3 
 mm/fremap.c                                  |   24 ----
 mm/memory.c                                  |  154 ++++++++++++++++++++++--
 mm/rmap.c                                    |    2 
 net/atm/atm_misc.c                           |   11 +-
 net/atm/common.c                             |   66 ++++++----
 net/atm/common.h                             |    2 
 net/atm/resources.c                          |   78 +++++-------
 net/atm/resources.h                          |    3 
 net/ipv4/fib_hash.c                          |    2 
 net/ipv4/fib_semantics.c                     |    2 
 net/ipv4/icmp.c                              |    4 -
 net/ipv4/ip_gre.c                            |    2 
 net/ipv4/ip_output.c                         |    2 
 net/ipv4/ipvs/ip_vs_conn.c                   |    2 
 net/ipv4/ipvs/ip_vs_ctl.c                    |    4 -
 net/ipv4/ipvs/ip_vs_proto_tcp.c              |    2 
 net/ipv4/netfilter/ip_conntrack_amanda.c     |    2 
 net/ipv4/netfilter/ip_conntrack_core.c       |    4 -
 net/ipv4/netfilter/ip_conntrack_ftp.c        |    2 
 net/ipv4/netfilter/ip_conntrack_irc.c        |    2 
 net/ipv4/netfilter/ip_conntrack_proto_icmp.c |    4 -
 net/ipv4/netfilter/ip_conntrack_proto_sctp.c |    4 -
 net/ipv4/netfilter/ip_conntrack_proto_tcp.c  |    6 -
 net/ipv4/netfilter/ip_nat_core.c             |    2 
 net/ipv4/netfilter/ip_tables.c               |    2 
 net/ipv4/netfilter/ipt_LOG.c                 |    4 -
 net/ipv4/proc.c                              |   10 +-
 net/ipv4/route.c                             |    5 -
 net/ipv4/tcp.c                               |    8 -
 net/ipv6/addrconf.c                          |    2 
 net/ipv6/icmp.c                              |    2 
 net/ipv6/ip6_output.c                        |    3 
 net/ipv6/ipv6_sockglue.c                     |    4 -
 net/ipv6/netfilter/ip6_tables.c              |    2 
 112 files changed, 1134 insertions(+), 645 deletions(-)
