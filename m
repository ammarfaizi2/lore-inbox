Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSGOARn>; Sun, 14 Jul 2002 20:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317260AbSGOARn>; Sun, 14 Jul 2002 20:17:43 -0400
Received: from lsanca2-ar27-4-3-064-252.lsanca2.dsl-verizon.net ([4.3.64.252]:8832
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S315595AbSGOARl>; Sun, 14 Jul 2002 20:17:41 -0400
Date: Sun, 14 Jul 2002 17:20:06 -0700 (PDT)
From: Ben Clifford <benc@hawaga.org.uk>
To: Dave Jones <davej@suse.de>
cc: Heinz Diehl <hd@cavy.de>, <linux-kernel@vger.kernel.org>, <axboe@suse.de>,
       <andre@linux-ide.org>
Subject: Re: Linux 2.5.25-dj2
In-Reply-To: <20020715012823.I20781@suse.de>
Message-ID: <Pine.LNX.4.44.0207141716590.3174-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 15 Jul 2002, Dave Jones wrote:

>  > Anyone else have any luck with ide-scsi24?
> 
> decode oops, post, cc: axboe@suse.de and andre@linux-ide.org

Here is the first oops - I managed to get it written to disk before the 
second oops occurs (which locks up the machine) a few seconds later.

I captured it by saying:
modprobe ide-scsi24; sleep 3s; dmesg > a.log; sync

As I said about, a second oops occurs about 5 seconds later - in between,
still appers to be responsive (I can type text into a bash prompt), but
the second oops locks the machine up. I'll try and capture that now.

Ben

ksymoops 2.4.4 on i686 2.5.25-dj2+bc.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.25-dj2+bc/ (default)
     -m /boot/System.map-2.5.25-dj2+bc (default)

Error (regular_file): read_system_map stat /boot/System.map-2.5.25-dj2+bc failed
Unable to handle kernel paging request at virtual address d08ff420
d08ff420
*pde = 01334067
Oops: 0000
CPU:    0
EIP:    0010:[<d08ff420>]    Tainted: P  
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: d08ff420   ebx: c133f69c   ecx: c02bee74   edx: c02bee74
esi: c02bee74   edi: c02bee74   ebp: 00000206   esp: cb5cfb40
ds: 0018   es: 0018   ss: 0018
Stack: c01a7014 c02bee74 c133f69c c02bee30 c02bee74 c01af5fa c02bee74 cb5ce000 
       c02bee74 c133f69c 00000003 00000206 c01afd75 c13402dc 00000000 c02bee74 
       c133f69c c02bee74 c13402dc 00000000 00000000 cb5cfba4 cb5cfba4 00000000 
Call Trace: [<c01a7014>] [<c01af5fa>] [<c01afd75>] [<d08fd482>] [<d08e3611>] 
   [<d08e3b40>] [<d08e9e2c>] [<d08e925c>] [<d08e92da>] [<d08e3766>] [<d08e30c0>] 
   [<d08ea7e2>] [<c01a6d1c>] [<c01a732f>] [<d08eb182>] [<d08ea618>] [<c014e993>] 
   [<c014d5ce>] [<c01618d9>] [<c01619cc>] [<c0161990>] [<c014561c>] [<c0145337>] 
   [<c0162280>] [<c016218d>] [<c0184646>] [<c01849c1>] [<c0184c83>] [<d08fdad2>] 
   [<d08e4823>] [<d08f1640>] [<d08fdf84>] [<d08fd55f>] [<d08fdfa0>] [<c0118215>] 
   [<d08fdec4>] [<d08fc060>] [<c0106ebb>] 
Code:  Bad EIP value.

>>EIP; d08ff420 <[ide-cd]ll_10byte_cmd_build+0/d0>   <=====
Trace; c01a7014 <elv_next_request+14/a0>
Trace; c01af5fa <ide_stall_queue+2ca/360>
Trace; c01afd75 <ide_do_drive_cmd+d5/120>
Trace; d08fd482 <[ide-cd]restore_request+22/a0>
Trace; d08e3611 <[scsi_mod]__kstrtab_scsi_driverfs_bus_type+11/f0>
Trace; d08e3b40 <[scsi_mod]scsi_done+0/80>
Trace; d08e9e2c <[scsi_mod]scsi_request_fn+39c/3f0>
Trace; d08e925c <[scsi_mod]__scsi_insert_special+6c/a0>
Trace; d08e92da <[scsi_mod]scsi_insert_special_req+1a/20>
Trace; d08e3766 <[scsi_mod]scsi_wait_req+76/b0>
Trace; d08e30c0 <[scsi_mod]__ksymtab_scsi_ioctl_send_command+0/0>
Trace; d08ea7e2 <[scsi_mod]scan_scsis_single+f2/740>
Trace; c01a6d1c <agp_enable+b19c/b380>
Trace; c01a732f <blk_queue_make_request+5f/90>
Trace; d08eb182 <[scsi_mod]scan_scsis_target+32/170>
Trace; d08ea618 <[scsi_mod]scan_scsis+2c8/3a0>
Trace; c014e993 <new_inode+63/70>
Trace; c014d5ce <d_instantiate+4e/60>
Trace; c01618d9 <wipe_partitions+a89/1260>
Trace; c01619cc <wipe_partitions+b7c/1260>
Trace; c0161990 <wipe_partitions+b40/1260>
Trace; c014561c <vfs_create+ec/7f0>
Trace; c0145337 <lookup_hash+67/90>
Trace; c0162280 <driverfs_create_file+c0/120>
Trace; c016218d <driverfs_create_dir+dd/110>
Trace; c0184646 <put_device+16/a0>
Trace; c01849c1 <device_create_file+71/80>
Trace; c0184c83 <device_remove_file+2b3/2d0>
Trace; d08fdad2 <[ide-cd]cdrom_write_intr+1e2/290>
Trace; d08e4823 <[scsi_mod]scsi_register_host+213/340>
Trace; d08f1640 <[scsi_mod].rodata.end+5851/8d51>
Trace; d08fdf84 <[ide-cd]cdrom_lockdoor+94/f0>
Trace; d08fd55f <[ide-cd]cdrom_start_read+5f/90>
Trace; d08fdfa0 <[ide-cd]cdrom_lockdoor+b0/f0>
Trace; c0118215 <inter_module_put+7c5/8b0>
Trace; d08fdec4 <[ide-cd]cdrom_check_status+54/80>
Trace; d08fc060 <[ide-cd]__module_license+0/0>
Trace; c0106ebb <__up_wakeup+107b/2e30>


1 error issued.  Results may not be reliable.

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
http://www.hawaga.org.uk/ben/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9MhU5sYXoezDwaVARAsMCAJ4iTjmUa9dhvj7vaDV30M152k+eHwCfdc/h
be8awHV3cfoSUiKUzoVq7X4=
=u109
-----END PGP SIGNATURE-----

