Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311570AbSC1Dpx>; Wed, 27 Mar 2002 22:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311572AbSC1Dpo>; Wed, 27 Mar 2002 22:45:44 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:26118
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311570AbSC1Dph> convert rfc822-to-8bit; Wed, 27 Mar 2002 22:45:37 -0500
Date: Wed, 27 Mar 2002 19:44:55 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7-dj1
In-Reply-To: <20020328015928.A3607@suse.de>
Message-ID: <Pine.LNX.4.10.10203271943420.6661-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anton A reported an error so I need to go back and see what else got
broken before this release.  Since there is not diag layer anymore it is
all a pig in a poke :-/

On Thu, 28 Mar 2002, Dave Jones wrote:

> This catches up with the bits and pieces that have happened in 2.4 over the
> last few weeks, scoops up this weeks Linux-kernel bits, and throws in
> various compile fixes so it hopefully all works out.
> Particularly of note in this one are Andre's ide fixes, feedback appreciated
> from anyone seeing problems in 2.5 mainline.
> 
> In other news, work has begun splitting this monster diff into lots of
> Bitkeeper trees. Hopefully when Linus gets back, resyncing is going to be
> a lot easier than it used to be.
> 
> As usual,..
> Patch against 2.5.7 vanilla is available from:
> ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/
> 
> Merged patch archive: http://www.codemonkey.org.uk/patches/merged/
> 
> Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
> known bugs that are also in mainline.
> 
>  -- Davej.
> 
> 2.5.7-dj2
> o   Merge bits of 2.4.19pre3 & pre4.
>     | Dropped quite a bit, 2.5 is really starting to diverge
>     | in quite a few areas.
> o   Numerous compile fixups.				(Me)
> o   Various config.help updates.			(Steven Cole, ESR)
> o   AFFS compile fix.					(Jarno Paananen)
> o   Update bttv to use new v4l API.			(Jarno Paananen)
> o   Removal extraneous BUG() from accounting code.	(Bob Miller)
> o   Fix up JFS txnmgr race.				(Christoph Hellwig)
> o   Update documentation index.				(Rolf Eike Beer)
> o   Use seq_file for /proc/partitions.			(Randy Dunlap)
> o   Fix initrd kdev_same thinko.			(Al Viro)
> o   Minor sg update.					(Doug Gilbert)
> o   install .config with 'make install'			(Kelly French) 
> o   Add yet another VAIO to the DMI APM blacklist.	(Michael Piotrowski)
> o   Detect get_block errors in block_read_full_page.	(Anton Altaparmakov)
> o   Kill off noquot.c					(Al Viro)
> o   Special case P4/Xeon bluesmoke init.		(Jon Hourd)
> o   Fix up ide-scsi documentation typo.			(Bill Jonas)
> o   Increment tcpPassiveOpens counter.			(Dave Miller)
> o   Fix up some of Linus' criticisms of SEM_UNDO	(Dave Olien)
> o   ibmphp compile fix.					(Greg KH)
> o   Fix up two possible panics in microcode driver.	(Tigran Aivazian)
> o   fcntl return code POSIX compliance.			(Christopher Yeoh)
> o   Lessen debug info from ide-tape.			(Alfredo Sanjuán)
> o   Various ide fixes.					(Andre Hedrick)
>     | pdc4030 bent into shape a little by me, please test carefully.
> o   EasyDisk USB storage support.			(Stanislav Karchebny)
> o   Flush cache/TLB on MCE.				(Me)
> o   Fix double free in efi partition handling.		(Takanori Kawano)
> o   Correct pci_set_mwi documentation typo.		(Geert Uytterhoeven)
> o   Fix up race in indydog driver.			(Dave Hansen)
> o   3ware driver update.				(Adam Radford)
> o   Fix mmap bug with drivers that adjust vm_start.	(Benjamin LaHaise)
> o   Register mad16 gameport with input subsystem.	(Michael Haardt)
> o   Remove stale comment.				(William Lee Irwin III)
> o   P4/Xeon Thermal LVT support for MCE.		(Zwane Mwaikambo)
> o   Various fbdev compilation fixes.			(James Simmons)
> o   Move touchscreen drivers to their own dir.		(James Simmons)
> o   Seperate reiserfs_sb_info from struct super_block	(Brian Gerst)
> 
> 
> 2.5.7-dj1
> o   Various x86-64 compile fixes.			(Me, Andi Kleen)
> o   Fix up hfs superblock cleanup typo.			(Brian Gerst)
> o   Remove 2.1.x/2.3.x checks from rocket driver.	(William Stinson)
> o   JFS compile fixes.					(Dave Kleikamp)
> o   pci_alloc_consistent ZONE_NORMAL fix.		(Badari Pulavarty)
> o   v4l unregister with open file handles fix.		(Gerd Knorr)
> o   ACPI throttling fixes.				(Dominik Brodowski)
> o   Updated NFS root_server_path patch.			(Martin Schwenke)
> o   Backout problematic sym53c8xx_2 changes.		(Douglas Gilbert)
> o   Fix up one of my MCE SNAFU's.			(Douglas Gilbert)
>     | Also make it AMD only for now, pending further investigation.
> o   Support for Belkin Wireless card.			(Brendan W. McAdams)
> o   input/gameport makefile & config.in fixes.		(Steven Cole)
> o   UDF write compile fix.
> 
> 
> 2.5.6-dj2
> o   machine check background checker SMP improvements.	(Me)
> o   Hush INVALIDATE_AGID noise on Toshiba DVD drives.	(Jens Axboe)
> o   Remove delayed vfree() in ppp_deflate.		(David Woodhouse)
> o   Fix devfs 64-bit portability issues.		(Carsten Otte)
> o   UFS blocksize fix.					(Zwane Mwaikambo)
> o   Fix proc race on task_struct->sig.			(Chris Mason)
> o   Pull NFS server IP from root_server_path.		(Martin Schwenke)
> o   Fix broken tristate in ALSA config.			(Steven Cole)
> o   Work around mpc_apicid > MAX_APICS problem.		(James Cleverdon)
> o   cs4281 OSS compile fix.				(Sebastian Droege)
> o   Fix locking in ATM device allocation.		(Maksim Krasnyanskiy)
> o   Fix MSDOS filesystem option mistreatment.		(Rene Scharfe)
> o   Increase number of JFS transaction locks.		(Steve Best)
> o   page_to_phys() fix for >4GB pages on x86.		(Badari Pulavarty)
> o   Append kernel config to zImage.			(Randy Dunlap)
>     | See also scripts/extract-ikconfig
> o   Remove useless check from shmem_link()		(Alexander Viro)
> o   Enable Natsemi MMX extensions.			(Zwane Mwaikambo)
> o   Superblock cleanups for isofs,udf & bfs.		(Brian Gerst)
> o   request_region() checking for hisax avm_a1		(Dan D Carpenter)
> o   uninitialise lots of static vars in net/		(William Stinson)
> o   D-Link DE620 janitor work.				(Karol Kasprzak)
> o   Netfilter conntrack compile fix.			(Christopher Barton)
> 
> 
> -- 
> Dave Jones.                    http://www.codemonkey.org.uk
> SuSE Labs.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

