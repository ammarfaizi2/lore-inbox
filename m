Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUBJDo1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 22:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265536AbUBJDo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 22:44:27 -0500
Received: from red-corpb4-7-68.telnor.net ([200.76.246.68]:59568 "EHLO
	pubserv01.bajawireless.net") by vger.kernel.org with ESMTP
	id S265267AbUBJDoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 22:44:13 -0500
Cc: linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.3-rc2
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
Message-ID: <opr24yeut6q5eh14@localhost>
From: Misshielle Wong <mwl@bajoo.net>
Content-Type: text/plain; format=flowed; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Mon, 09 Feb 2004 19:53:08 -0800
In-Reply-To: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
User-Agent: Opera7.23/Linux M2 build 518
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yay! :)

Testing time ^_^

On Mon, 9 Feb 2004 19:17:37 -0800 (PST), Linus Torvalds 
<torvalds@osdl.org> wrote:

>
> Uhhuh. There was a bit more pending, so here's a -rc2. Now please calm
> down, I'd like this to have some time to stabilize..
>
> The rc1->rc2 changes are mostly driver side stuff: PnP update, USB, ACPI,
> IRDA, i2c, hotplug-PCI and netdrivers etc. But there's a NFSv4 update and
> soem XFS fixes there too.
>
> And some ARM and sparc updates.
>
> 		Linus
>
>
> Summary of changes from v2.6.3-rc1 to v2.6.3-rc2
> ============================================
>
> Adam Belay:
>   o PCI: Remove uneeded resource structures from pci_dev
>   o [PNP]: Fix Serial PnP driver
>   o [PNP]: Resource flags update
>   o [PNP]: Disable resources fix
>   o [PNP]: Avoid static requests
>   o [PNP] Move ID declarations
>   o [PNP]: file2alias support
>   o [PNP]: Card matching code fix
>   o [PNP]: Add additonal sysfs entries
>   o [PNP]: Cleanup Kconfig
>
> Adrian Bunk:
>   o USB: remove USB_SCANNER from the build
>
> Alan Stern:
>   o USB gadget: file_storage.c -- remove device_unregister_wait()
>   o USB gadget: fix usb/gadget/file_storage.c doesn't compile with gcc
>     2.95
>   o USB: change uhci maintainer
>   o USB: fix unneeded SubClass entry in unusual_devs.h
>
> Alexander Viro:
>   o [netdrvr qeth] use alloc_etherdev instead of hand-allocating struct
>     net_device
>   o [netdrvr meth] use alloc_etherdev; fix leaks on error/cleanup
>   o [wireless ray_cs] use alloc_etherdev
>   o [netdrvr ne3210] remove #if 0'd code
>   o [appletalk ipddp] dynamically allocate struct net_device
>   o [arcnet com90io] use alloc_netdev
>   o [arcnet arc-rimi] use alloc_netdev; module params; fix bugs on
>     error/cleanup
>   o [arcnet com20020] netdev dynamic alloc; module params; fix bugs
>   o [arcnet com90xx] netdev dynamic alloc; module params; fix bugs
>   o [arcnet] create and use alloc_arcdev helper
>   o [netdrvr ppp] netdev dynamic alloc; convert ppp_net_init to
>     alloc_netdev setup function
>   o [wan synclink] netdev dynamic alloc
>   o [wan cosa] netdev dyamic alloc
>   o net_device and netdev private struct allocation improvements
>   o [hamradio dmascc] convert embedded net_device to dynamic allocation
>   o [char synclinkmp] convert net_device to dynamic allocation
>   o [pcmcia] synclink_cs] convert net_device to dynamic allocation
>   o [atm clip] convert to using alloc_netdev(), const-offset priv
>   o [netdrvr] s/kfree/free_netdev/ where appropriate
>   o [wireless wl3501_cs] remove unused constructor
>   o [netdrvr] convert most 8390 drivers to using alloc_ei_netdev()
>   o [netdrvr smc-mca] alloc_ei_netdev(), other fixes
>   o [netdrvr pcnet_cs] alloc_ei_netdev-associated cleanups
>   o [netdrvr 8390] convert 8390 lib to use const-offset priv struct
>   o [NET] s/kfree/free_netdev/ in bridge driver
>   o [netdrvr axnet_cs] use embedded private struct
>   o [netdrvr ns83820] Switched to sane net_device allocation
>   o [netdrvr ns83820] Plugs the races around too early
>     register_netdev()
>   o [netdrvr ibmlana] ibmlana switched to sane allocation, leaks fixed
>   o [netdrvr] A bunch of gratitious ->init() killed; several leaks
>     plugged
>   o [netdrvr 8390] Forgotten return 0; removed
>   o [netdrvr pcnet32] Added missing check and cleanup for
>     register_netdev() failure in pcnet32
>   o [netdrvr ibmtr, ibmtr_cs]  cleanup and leak fixes
>   o [irda sa1100_ir] convert to using standard alloc_irdadev()
>   o Fix imm/ppa initializing bug in driver updates
>
> Andrew Morton:
>   o [netdrvr] new-probe warning fix
>   o USB: gcc-3.5: drivers/usb/gadget/net2280.c
>   o USB: gcc-3.5: drivers/usb/input/hid-core.c
>   o USB: gcc-3.5: drivers/usb/misc/uss720.c
>   o USB: gcc-3.5: drivers/usb/storage/usb.c
>   o Fix qla2xxx warnings
>   o v850: Add some #includes for the v850 to eliminate some compiler
>     warnings
>   o v850: Define ARCH_HAS_*_EXTABLE macros for v850
>   o v850: make __delay function handle a loop count of zero
>   o add device id to radeonfb
>   o Fix ppa/imm warnings
>   o Fix __filemap_fdatawrite() comment
>   o bitmap_snprintf() optimization
>   o alpha: fix build error due to __attribute_const__ conversion
>   o vx222_ops.c warning fix
>   o cciss: PCI BAR sizing fix
>   o cciss: Fix freeing of incorrect IO memory address
>   o cciss: Add support for SA 6i embedded controller
>   o cciss: IRQ sharing fix
>   o cciss: disble prefetching in ASIC
>   o cciss: intialisation oops fix
>   o cciss: avoid reading PCI config space
>   o cciss: printk format fix
>   o cciss: improve /proc presentation
>   o cciss: use pci_module_init()
>   o cciss: rmmod oops fix
>   o NFS: fix for older gcc's
>   o Remove duplicated HPPA bits in kernel/sysctl.c
>   o getxattr error checking fix
>
> Andrew Vasquez:
>   o qla2xxx Kconfig fix
>
> Bartlomiej Zolnierkiewicz:
>   o remove MOD_INC_USE_COUNT from drivers/ide/
>   o fix ns87415.c for PA-RISC Super I/O chip
>   o fix too early probing of default IDE ports
>   o fix duplication of DMA {black,white}list in icside.c
>   o fix OOPS for multiple IDE PCI modules and CONFIG_PROC_FS=y
>
> Benjamin Herrenschmidt:
>   o ide-cd: incorrect use of sector_div
>
> Christoph Hellwig:
>   o [SUNRPC]: Use completions instead of sleep_on for rpciod
>   o [XFS] Fix buffer teardown on _pagebuf_lookup_pages failure
>   o [XFS] Remove the lockable/not lockable buffer distinction
>   o [XFS] Remove PBF_MAPPABLE
>   o [XFS] plug a pagebuf leak
>   o [XFS] Avoid NULL returns from pagebuf_get
>   o [XFS] Fix gcc 3.5 compilation for real
>
> Dan Scholnik:
>   o USB: fix Casio digicam entry in unusual_devs.h
>
> David Brownell:
>   o USB: fix Bug 1821: sleeping function called
>   o USB: remove pci_unmap_single() calls from usbcore
>   o PCI: dma_pool fixups
>   o USB Gadget: ethernet gadget locking tweaks
>   o USB Gadget: pxa2xx_udc updates
>   o USB: usbtest updates
>   o USB: usbnet updates (new devices)
>   o USB: USB misc OHCI updates
>   o USB: re-factor enumeration/reset paths
>
> David Martínez Moreno:
>   o I2C: fix typos
>
> David S. Miller:
>   o [SPARC]: Fix AIO syscall numbering
>   o [ECONET]: Use LL_RESERVED_SPACE() where applicable.  Noticed by
>     yoshfuji
>
> Deepak Saxena:
>   o PCI: Replace pci_pool with generic dma_pool
>   o PCI: Replace pci_pool with generic dma_pool, part 2
>   o USB: remove reference to usb_hcd.refcnt in ohci-sa111.c
>
> Dely Sy:
>   o PCI: Patch to get cpqphp working with IOAPIC
>
> Dominik Brodowski:
>   o [ACPI] update passive cooling algorithm from Dominik Brodowski
>   o [ACPI] remove unnecessary check in acpi-cpufreq driver from Dominik
>     Brodowski
>   o [ACPI] update _PPC handling -- from Dominik Brodowski
>   o [ACPI] acpi-cpufreq fixups from Dominik Brodowski
>   o [ACPI] more acpi-cpufreq fixups from Dominik Brodowski
>   o [ACPI] Move the _PSS and _PCT access to drivers/acpi/processor.c so
>     that it can be used by various low-level drivers (centrino,
>     acpi-io, powernow-k{7,8}, ...) from Dominik Brodowski
>   o [ACPI] Move the /proc/acpi/processor/./performance output to
>     drivers/acpi/processor.c -- it's the same for all lowlevel drivers.
>   o [ACPI] Abstract the registration method between low-level drivers
>     and the ACPI Processor P-States driver.
>   o [ACPI] add _PDC support
>   o [ACPI] make # of performance states dynamic
>
> Eric Sandeen:
>   o [XFS] Make more xfs errors trappable with panic_mask
>
> Eugene Teo:
>   o Kobject: export some missing symbols
>
> Geert Uytterhoeven:
>   o m68k-related net driver fixes
>   o sun3-related net driver fixes
>   o 2.6.x experimental net driver queue fix
>   o I2C: add Hydra i2c bus driver
>
> Greg Kroah-Hartman:
>   o USB: remove unused usb-debug.c file
>   o PCI: add back some pci.ids entries that got deleted in the last big
>     update
>   o dmapool: use dev_err() whenever we can to get the better
>     information in it
>   o USB: add support for the Aceeca Meazura device to the visor driver
>   o I2C: fix oops when CONFIG_I2C_DEBUG_CORE is enabled and the bttv
>     driver is loaded
>   o Driver core: remove device_unregister_wait() as it's a very bad
>     idea
>   o dmapool: Remove sentance in documentation that is now false on 2.6
>   o USB: remove scanner driver files
>   o PCI: remove stupid MSI debugging code that was never used
>   o PCI: move pci_msi.h out of include/linux to drivers/pci where it
>     belongs
>   o USB: fix bug number 1980 about keyspan devices not getting
>     recognized
>   o Driver Core: fix up list_for_each() calls to list_for_each_entry()
>   o dmapool: fix up list_for_each() calls to list_for_each_entry()
>
> Hideaki Yoshifuji:
>   o [IPV6]: Kill broken and unused IPV6_AUTHHDR support
>   o [WANROUTER]: Use LL_RESERVED_SPACE() where applicable
>   o [PACKET]: Use LL_RESERVED_SPACE() where applicable
>   o [IPVS]: Use LL_RESERVED_SPACE() where applicable
>   o [IPV4/IGMP]: Use LL_RESERVED_SPACE() where applicable
>   o [NETFILER/ipt_REJECT]: Use LL_RESERVED_SPACE() where applicable
>   o [IPV6]: Use LL_RESERVED_SPACE() where applicable
>
> Hirofumi Ogawa:
>   o [AF_UNIX]: Print out paths correctly in /proc/net/unix, matching
>     2.4.x
>
> James Bottomley:
>   o SCSI: undelete qlogicfc driver
>
> Jean Delvare:
>   o I2C: Bring w83l785ts in compliance with sysfs naming conventions
>   o I2C: Handle read errors in w83l785ts
>   o I2C: add new driver, gl518sm
>   o I2C: Update I2C maintainers entry
>   o I2C: add new chip driver: fscher
>
> Jean Tourrilhes:
>   o [IRDA]: Ultra sendto support
>   o [IRDA]: IrLAP disconnection pending race
>   o [IRDA]: Remove net notifier
>   o [IRDA]: nsc-ircc irq retval
>   o [IRDA]: ali-ircc irq retval
>   o [IRDA]: smsc-ircc2 irq retval
>   o [IRDA]: via-ircc irq retval
>   o [IRDA]: w83977af_ir irq retval
>
> Jeff Garzik:
>   o [netdrvr bonding] fix broken build
>
> Jens Axboe:
>   o ide-cd invalidate toc cache on last close
>
> Jes Sorensen:
>   o [ACPI] Check for overflow when parsing MADT entries from Jes
>     Sorensen
>
> John Belmonte:
>   o toshiba_acpi 0.17 from John Belmonte
>
> Jon Smirl:
>   o Driver core: add hotplug support for class_simple
>
> Jonathan Corbet:
>   o Char drivers: cdev_unmap()
>
> Karol Kozimor:
>   o acpi4asus update from Karol 'sziwan' Kozimor
>
> Kevin Owen:
>   o USB: ehci - clear TT buffer command patch
>
> Len Brown:
>   o [ACPI] add Bruno Ducrot to CREDITS
>   o fix build error from undefined NR_IRQ_VECTORS
>   o [ACPI] quiet numa boot -- from Jes Sorensen
>   o [ACPI] proposed fix for AML parameter passing from Bob Moore
>     http://bugzilla.kernel.org/show_bug.cgi?id=1766
>   o [ACPI] fix IA64 build warning from Martin Hicks
>
> Linus Torvalds:
>   o Don't read i8042 data if no data exists
>   o Make SET_INPUT_KEYCODE return the old value, and clean up users of
>     this that were very confused indeed.
>   o Add forward-declaration of "struct nfs4_client" to make nfs_idmap.h
>     independent of CONFIG_NFS4 and other header files.
>   o Clean up dentry pointer validation by moving it into a function of
>     its own.
>   o Linux 2.6.3-rc2
>
> Marcelo Tosatti:
>   o Fix pc300_tty.c -> implement tiocmset/tiocmget
>
> Markus Demleitner:
>   o USB: DSBR-100 tiny patch
>
> Matthew Dobson:
>   o PCI: fix "pcibus_class" Device Class, release function
>
> Matthew Wilcox:
>   o PA-RISC needs IPC64 structs
>   o PA-RISC Harmony driver update
>   o New ptrace.h definitions
>
> Nathan Scott:
>   o [XFS] Use list_move for moving pagebufs between lists, not
>     list_add/list_del
>   o [XFS] Fix compile warning, ensure _pagebuf_lookup_pages return
>     value is inited
>   o [XFS] Add back a missing pflags check in releasepage
>   o [XFS] Fix data loss when writing into unwritten extents while
>     memory is being reclaimed
>   o [XFS] Fix a trivial compiler warning, remove some no-longer-used
>     macros
>   o [XFS] Update XFS config entries - add security entry, update ACL
>     entry
>
> Olaf Hering:
>   o USB storage: fix sign bug in usb-storage datafab
>
> Oliver Neukum:
>   o USB: fix DMA to stack in tt-usb
>   o USB: fix URB leak in belkin driver
>
> Petri Koistinen:
>   o [SCTP]: Unify URL referencing in Kconfig documentation
>   o [NET_SCHED]: Unify URL referencing in Kconfig documentation
>   o [IPV6]: Unify URL referencing in Kconfig documentation
>   o [IPVS]: Unify URL referencing in Kconfig documentation
>   o USB: usb-storage Kconfig_URL_update
>   o USB: drivers/usb/net config URI update and unify
>   o USB: drivers/usb/misc/Kconfig URI update & unify: modules.txt
>   o USB: drivers/usb/input/Kconfig URI unify
>   o USB: drivers/usb/media/Kconfig URL fixups
>
> Rolf Eike Beer:
>   o PCI Hotplug: coding style for cpqphp_pci.c
>   o PCI Hotplug: Whitespace fixes for acpiphp
>   o PCI Hotplug: Kill spaces before \n in ibmphp*
>   o PCI Hotplug: Kill useless instructions from ibmphp_core.c
>   o PCI: avoid two returns directly after each other in pcidriver.c
>   o PCI Hotplug: Coding style fixes for drivers/pci/hotplug.c
>   o PCI Hotplug: very small optimisations for ibmphp_pci.c
>   o PCI Hotplug: kill hpcrc from several functions in ibmphp_core.c
>   o PCI Hotplug: make ibm_unconfigure_device void
>   o PCI Hotplug: mark functions __init/__exit in acpiphp
>   o PCI Hotplug: Convert error paths in ibmphp to use goto
>
> Russell King:
>   o [netdrvr pcmcia] fix hot unplugging
>   o [irda sa1100_ir] "resurrect from bitrot hell"
>   o [ARM] Fix asm syntax for gcc3
>   o [ARM] Use scsi_host_{alloc,put}() rather than scsi_{un,}register()
>   o [ARM] Add prefix to driver constants to prevent namespace clashes
>
> Shmulik Hen:
>   o bonding cleanup 2.6 - Simplify ifenslave
>   o bonding cleanup 2.6 - Consolidate prints
>   o bonding cleanup 2.6 - death of typedefs
>   o bonding cleanup 2.6 - remove dead code
>   o bonding cleanup 2.6 - Consolidate timer handling
>   o bonding cleanup 2.6 - Fix handling of bond->primary
>   o bonding cleanup 2.6 - Remove multicast_mode module param
>   o bonding cleanup 2.6 - Fix slave list iteration
>   o bonding cleanup 2.6 - Consolidate function declarations
>   o bonding cleanup 2.6 - consolidate param names of function params
>     and variables
>   o bonding cleanup 2.6 - Re-org struct bonding members (re-send)
>   o bonding cleanup 2.6 - consolidate return values of functions
>   o bonding cleanup 2.6 - Consolidate conditions & statements
>   o bonding cleanup 2.6 - Consolidate error handling in all xmit
>     functions
>   o bonding cleanup 2.6 - Whitespace cleanup
>   o bonding cleanup 2.6 - empty lines cleanup
>   o bonding cleanup 2.6 - fix indentations
>   o bonding cleanup 2.6 - Code re-org
>   o bonding cleanup 2.6 - Fix rejects from previous patches
>
> Sridhar Samudrala:
>   o [SCTP] provide valid tos and oif values for ip_route_output_key.
>     (ja@ssi.bg)
>   o [SCTP] Add sysctl parameters to update socket send/receive buffers
>   o [SCTP] Removed the deprecated ADLER32 checksum support
>   o [SCTP] Removed SCTP specific rmem/wmem sysctl's and use the global
>     rmem_default/wmem_default values for SCTP socket buffer sizes.
>
> Stephen Hemminger:
>   o [netdrvr skfddi] use PCI hotplug API; other cleanups
>   o USB: fix usb hc and shared irq handling
>   o USB: uhci - unused urbp element
>
> Tom Rini:
>   o USB: mark the scanner driver BROKEN
>
> Tony Lindgren:
>   o USB: Update ohci-omap to compile
>
> Trond Myklebust:
>   o NFSv4/RPCSEC_GSS: Ensure that RPC userland upcalls time out
>     correctly if the corresponding userland daemon is not up and
>     running.
>   o RPCSEC_GSS: More fixes to the upcall mechanism
>   o RPCSEC_GSS: Make the upcalls detect if the userland daemon dies
>     while processing a request.
>   o NFSv4: Fix an Oopsable condition if we fail to get the root
>     directory under NFSv4.
>   o NFSv4: Bugfixes for the NFSv4 client name to uid mapper
>   o NFSv4: Bugfixes and cleanups for the NFSv4 client name to uid
>     mapper. Includes a fix by Tim Woods to deal with a caching bug in
>     the case where a user and a group share the same numerical id
>     and/or name.
>   o RPCSEC_GSS: Make it safe to share crypto tfms among multiple
>     threads.
>   o RPCSEC_GSS: Oops. Major memory leak here
>   o RPCSEC_GSS: Fix two more memory leaks found by the Stanford
>     checker.
>   o RPCSEC_GSS: Fix yet more memory leaks
>   o RPCSEC_GSS: Miscellaneous cleanups of the krb5 code required for
>     the integrity checksumming mode.
>   o RPCSEC_GSS: Instead of having gss_get_mic allocate memory for the
>     mic, require the caller to pass an output buffer whose data pointer
>     already points to preallocated memory.
>   o RPCSEC_GSS: Client-side only support for rpcsec_gss integrity
>     protection. Since this requires checksumming an entire request,
>     instead of just the header, and since the request may include, for
>     example, pages with write data, we modify the gss_api routines to
>     pass xdr_bufs instead of xdr_netobjs where necessary.
>   o RPCSEC_GSS: Move the gss sequence number history from the task
>     structure to the request structure, where it makes more sense.
>   o RPC: xdr_encode_pages either leaves the tail iovec pointing to null
>     or, if padding onthe page data is needed, sets it to point to a
>     little bit of static data. This is a problem if we're expecting to
>     later append some data in gss_wrap_req. Modify xdr_encode_pages to
>     make tail point to the end of the data in head, as xdr_inline_pages
>     and xdr_write_pages do.
>   o RPC: Add support for sharing the same RPC transport and credential
>     caches between different mountpoints by allowing cloning of the
>     rpc_client struct.
>   o NFSv4/RPCSEC_GSS: Make Frank's server->client_sys feature use RPC
>     cloning in order to avoid duplicating sockets etc. Make NFSv4 share
>     a single socket for all communication to the same server.
>   o NFSv4: Convert the RENEW operation from using nfs4_compound, to
>     being a standalone RPC call in preparation for the renew daemon
>   o NFSv4: Convert the lease renewal daemon from being per-mountpoint
>     to being per-server. Instead of running it on top of rpciod,
>     convert it to use keventd. This mean we can use the struct
>     nfs4_client semaphores for ordering purposes.
>   o NFSv4: Split out the code for retrieving static server information
>     out of the GETATTR compound.
>   o NFSv4: Convert SETCLIENTID and SETCLIENTID_CONFIRM to be standalone
>     operations. Ensure that SETCLIENTID_CONFIRM always returns the
>     lease timeout length.
>   o NFSv4: Don't translate those NFSv4 errors that are needed by the
>     kernel itself into EIO.
>   o NFSv4: Preparation for the server reboot recovery code
>   o NFSv4: Basic code for recovering file OPEN state after a server
>     reboot.
>   o RPC/NFSv4: Allow lease RENEW calls to be soft (i.e. to time
>   o RPC: Ensure that we disconnect TCP sockets if there has been no NFS
>     traffic for the last 5 minutes. This code also affects NFSv2/v3.
>   o NFSv4: Atomic open(). Fixes races w.r.t. opening files
>   o NFSv4: Share open_owner structs between several different
>     processes. Reduces the load on the server.
>   o NFSv4: Fix a bug which was causing Oopses if the client was
>     mounting more than one partition from the same server.
>   o NFSv4: Add support for POSIX file locking
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



-- 
Using M2, Opera's revolutionary e-mail client: http://www.opera.com/m2/
