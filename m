Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUJIW7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUJIW7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 18:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUJIW7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 18:59:39 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:5870 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267543AbUJIW6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 18:58:54 -0400
Message-ID: <1c1c8636041009155811812617@mail.gmail.com>
Date: Sun, 10 Oct 2004 11:58:53 +1300
From: "mdew ." <some.nzguy@gmail.com>
Reply-To: "mdew ." <some.nzguy@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Linux 2.4.28-pre4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041008112135.GG16028@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041008112135.GG16028@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no chance of including IMQ?

http://www.linuximq.net/

On Fri, 8 Oct 2004 08:21:35 -0300, Marcelo Tosatti
<marcelo.tosatti@cyclades.com> wrote:
> 
> Hi,
> 
> Here goes 2.4.28-pre4...
> 
> It contains a number of driver updates (pcnet, e1000, gdth, prism54),
> a network update from David, few more gcc3.4 warning fixes.
> 
> I'm happy that the number of updates is small, -pre3
> has been released more than one month ago.
> 
> From now on can now change only what is necessary and let
> the 2.4 tree in peace :)
> 
> Summary of changes from v2.4.28-pre3 to v2.4.28-pre4
> ============================================
> 
> <ajgrothe:yahoo.com>:
>   o [CRYPTO]: Whirlpool algorithm updates
>   o [CRYPTO]: Add missing tcrypt part of whirlpool updates
> 
> <ananth:broadcom.com>:
>   o [libata sata_svw] race condition fix, new device support
> 
> <joshk:triplehelix.org>:
>   o radeonfb: Fix module unload and red/blue typo
>   o hotplug: Don't build cpqphp_proc.o if !PROC_FS
> 
> <lesanti:sinectis.com.ar>:
>   o fix dcache nr_dentry race
> 
> <martin.wilck:fujitsu-siemens.com>:
>   o [TG3]: Fix pause handling, we had duplicate flags for the same thing
> 
> <michael.waychison:sun.com>:
>   o [TG3]: Fix thinko in 5704 fibre hw autoneg code
> 
> <peter:pantasys.com>:
>   o [IPCONFIG]: Verify DHCPACK packets
>   o [IPV4]: Fix DHCPACK checking in ipconfig.c
> 
> <tkooda-patch-kernel:devsec.org>:
>   o [CRYPTO]: xtea_encrypt() should use XTEA_DELTA instead of TEA_DELTA
> 
> <vda:port.imtp.ilyichevsk.odessa.ua>:
>   o trivial patch for 2.4: always inline __constant_*
> 
> Achim Leubner:
>   o gdth update
> 
> David S. Miller:
>   o [NET]: Kill SCM_CONNECT, never used and unreferenced
>   o [TCP]: Just silently ignore ICMP Source Quench messages
>   o [TG3]: Recognize all onboard Sun variants, not just 5704
>   o [TG3]: Update driver version and reldate
>   o [CRYPTO]: Zero out tfm before freeing in crypto_free_tfm()
>   o [SPARC64]: Do not log streaming byte hole errors
>   o [PKT_SCHED]: sch_netem.c needs linux/init.h
>   o [SPARC64]: Disable SBH interrupt properly
> 
> David Woodhouse:
>   o [NET]: In compat syscall handling, check socket option types correctly
> 
> Don Fry:
>   o pcnet32: discard oversize rx packets
>   o pcnet32: recover after rx hang
>   o pcnet32: cleanup IRQ limitation
>   o pcnet32: Add HomePNA parameter for 79C978
>   o pcnet32: correctly program bcr32
> 
> Doug Ledford:
>   o RAID1 error handling locking fix
> 
> Ganesh Venkatesan:
>   o e1000 - ethtool support cleanup
>   o e1000 - Enable TSO
>   o e1000 - Replace kmalloc with vmalloc for data structures not shared with h/w
>   o e1000 - TSO context descriptor setup fixes (in preparation for IPv6 TSO)
>   o e1000 - Fix to prevent infinite loop trying to re-establish link while actively communicating
>   o e1000 - Condition that determines when to quit polling mode includes work done in Tx path
>   o e1000 - Shutdown PHY while bringing the interface down (if WoL not enabled)
>   o e1000 - add likely/unlikely to assist branch prediction, other cleanups
>   o e1000 - more DPRINTK messages
>   o e1000 - suspend/resume fix from alex@zodiac.dasalias.org
>   o e1000 - white space corrections
>   o e1000 - remove support for advanced TCO features
>   o e1000 - Fix MODULE_PARM, module_param and module_param_array usage
>   o e1000 - Fix VLAN filter setup errors (while running on PPC)
>   o e1000 - Polarity reversal workaround for 10F/10H links
>   o e1000 - white space corrections, other cleanups
>   o e1000 update - reset default ITR value to 8000
> 
> Geert Uytterhoeven:
>   o m68k MM off-by-one
>   o Atari ST-RAM setup
>   o Amiga frame buffer: kill obsolete DMI Resolver code
>   o fbdev monochrome lines
> 
> Herbert Xu:
>   o Backport Via IRQ mask fix
> 
> Hideaki Yoshifuji:
>   o [IPV6] Fix routing header handling
>   o [IPV6] Fix skb allocation size for RST and ACK
>   o [IPV6]: Missing ip_rt_put() in SIT error path
> 
> Jack Hammer:
>   o broken ips update
> 
> Jean Delvare:
>   o Update Documentation/i2c/writing-clients
> 
> Jeff Garzik:
>   o [TG3]: Kill all on-chip send BD support code
>   o linux/compiler.h: dummy __iomem macro (an sparse annotation)
>   o [libata] resync with 2.6.x
>   o [libata] remove distinction between MMIO/PIO helper functions
>   o [libata] consolidate legacy/native mode init code into helpers
>   o [libata] minor comment updates, preparing for iomap merge
> 
> Jens Axboe:
>   o irq safe gendisk_lock
> 
> Linus Torvalds:
>   o libata: initial PCI memory annotations
> 
> Marcelo Tosatti:
>   o Cset exclude: Achim_Leubner@adaptec.com|ChangeSet|20040928105422|00490
>   o Mike Miller: cciss typo fix
>   o Changed EXTRAVERSION to -pre4
> 
> Margit Schubert-While:
>   o prism54 Code cleanup
>   o prism54 remove module params
>   o prism54 add WE17 support
>   o prism54 initial WPA support
>   o prism54 fix wpa_supplicant frequency parsing
>   o prism54 remove TRACE
>   o prism54 Bug in timeout scheduling
>   o prism54 print firmware version
>   o prism54 bug initialization/mgt_commit
> 
> Maximilian Attems:
>   o menuconfig fix crash due to infinite recursion
> 
> Mikael Pettersson:
>   o 53c700 scsi driver gcc-3.4 fixes
>   o pcmcia mem_op.h gcc-3.4 fixes
>   o ATM drivers gcc-3.4 fixes
>   o IBM PCI hotplug controller driver gcc-3.4 fixes
>   o ISDN drivers gcc-3.4 fixes
>   o MTD drivers gcc-3.4 fixes
>   o RIVA driver gcc-3.4 fix
>   o E100 driver gcc-3.4 fixes
>   o PPC32 PReP residual data gcc-3.4 fix
>   o matrox framebuffer driver gcc-3.4 fix
> 
> Pete Zaitcev:
>   o USB drivers gcc-3.4 fixes
> 
> Stephen Hemminger:
>   o [TCP]: Store congestion algorithm per socket
>   o [TCP]: Add vegas style bandwidth info to 2.4.x tcp diag
>   o [TCP]: Backport 2.6.x cleanup of westwood code
> 
> Thomas Graf:
>   o [PKT_SCHED]: Fix slab corruption in cbq_destroy
>   o [PKT_SCHED] Report qdisc parent to userspace
> 
> Wensong Zhang:
>   o [IPVS] add the MAINTAINERS entry
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
