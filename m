Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282799AbRLBHNa>; Sun, 2 Dec 2001 02:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282801AbRLBHNV>; Sun, 2 Dec 2001 02:13:21 -0500
Received: from smtp-abo-5.wanadoo.fr ([193.252.19.58]:32644 "EHLO
	mahonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282800AbRLBHNM>; Sun, 2 Dec 2001 02:13:12 -0500
Message-ID: <3C09D414.B1811231@wanadoo.fr>
Date: Sun, 02 Dec 2001 08:11:16 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre5 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
		<9u9qas$1eo$1@penguin.transmeta.com>
		<200112010701.fB171N824084@vindaloo.ras.ucalgary.ca>
		<3C0898AD.FED8EF4A@wanadoo.fr>
		<200112011836.fB1IaxY31897@vindaloo.ras.ucalgary.ca>
		<3C093F86.DA02646D@wanadoo.fr> <200112012347.fB1NleW03464@vindaloo.ras.ucalgary.ca>
Content-Type: multipart/mixed;
 boundary="------------D0899884FD97F70ECB739B7D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D0899884FD97F70ECB739B7D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Richard Gooch wrote:
> 
>   I should also point out that you need to compile with
> CONFIG_DEVFS_DEBUG=y. Otherwise passing "devfs=dall" will have no
> effect.

2.5.1-pre5 with devfs-patch-v200
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVFS_DEBUG=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_BUGVERBOSE=y

The oops comes shortly after booting, loging in, starting devfsd-v1.3.20
and playing with mc.
The attached file is the same; it may be easier to read. The last line
is the last entry of the log before <SysRq U>, <SysRq B>.


Dec  2 07:39:29 milou kernel: devfs: devfs_unregister(): de->name: "s3"
de: cf6ddf3c 
Dec  2 07:39:29 milou kernel: devfs: d_delete(): dentry: cf6c4c8c 
inode: cf6c1a0c  devfs_entry: c14d0a94 
Dec  2 07:39:29 milou kernel: devfs: unlink(ttyp3) 
Dec  2 07:39:29 milou kernel: devfs: d_iput(): dentry: cf45d654 inode:
cf378454 de: cf6ddd1c  de->dentry: cf45d654 
Dec  2 07:39:29 milou kernel: devfs: devfs_put(ttyp3): de: cf6ddd1c,
parent: c1419724 "" 
Dec  2 07:39:29 milou kernel: devfs: d_delete(): dropping negative
dentry: cf45d654 
Dec  2 07:39:29 milou kernel: devfs: d_release(): dentry: cf45d654
inode: 00000000 
Dec  2 07:39:29 milou kernel: devfs: d_delete(): dentry: cf45d5e0 
inode: cf37826c  devfs_entry: cf6ddf3c 
Dec  2 07:39:29 milou kernel: devfs: d_iput(): dentry: cf45d5e0 inode:
cf37826c de: cf6ddf3c  de->dentry: cf45d5e0 
Dec  2 07:39:29 milou kernel: devfs: devfs_put(s3): de: cf6ddf3c,
parent: c14d0874 "pty" 
Dec  2 07:39:29 milou kernel: devfs: d_release(): dentry: cf45d5e0
inode: 00000000 
Dec  2 07:39:32 milou kernel: devfs: devfs_unregister(): de->name: "s2"
de: cf6da18c 
Dec  2 07:39:32 milou kernel: devfs: d_delete(): dentry: cf6c4ba4 
inode: cf6c163c  devfs_entry: c14d0a0c 
Dec  2 07:39:32 milou kernel: devfs: d_delete(): dentry: cf45d410 
inode: cf463bd4  devfs_entry: cf6da18c 
Dec  2 07:39:32 milou kernel: devfs: d_iput(): dentry: cf45d410 inode:
cf463bd4 de: cf6da18c  de->dentry: cf45d410 
Dec  2 07:39:32 milou kernel: devfs: d_release(): dentry: cf45d410
inode: 00000000 
Dec  2 07:39:32 milou kernel: devfs: devfs_put(s2): de: cf6da18c,
parent: c14d0874 "pty" 
Dec  2 07:39:32 milou kernel: Unable to handle kernel paging request at
virtual address 5a5a5a5e 
Dec  2 07:39:32 milou kernel:  printing eip: 
Dec  2 07:39:32 milou kernel: c01516f9 
Dec  2 07:39:32 milou kernel: *pde = 00000000 
Dec  2 07:39:32 milou kernel: Oops: 0002 
Dec  2 07:39:32 milou kernel: CPU:    0 
Dec  2 07:39:32 milou kernel: EIP:    0010:[devfs_put+13/296]    Not
tainted 
Dec  2 07:39:32 milou kernel: EFLAGS: 00010206 
Dec  2 07:39:32 milou kernel: eax: 5a5a5a5a   ebx: 5a5a5a5a   ecx:
00000001   edx: 5a5a5a5a 
Dec  2 07:39:32 milou kernel: esi: 00000000   edi: 00000027   ebp:
00000000   esp: cf657f40 
Dec  2 07:39:32 milou kernel: ds: 0018   es: 0018   ss: 0018 
Dec  2 07:39:32 milou kernel: Process devfsd-new (pid: 130,
stackpage=cf657000) 
Dec  2 07:39:32 milou kernel: Stack: 00000027 c015465c 5a5a5a5a cf978484
ffffffea 00000000 00000420 cfb97800  
Dec  2 07:39:32 milou kernel:        c01e7f40 cf4fc224 5a5a5a5a 000003f9
00000000 00000000 00000001 00000000  
Dec  2 07:39:32 milou kernel:        cf656000 00000000 00000000 00000000
cf656000 c01e7f6c c01e7f6c c012f5e6  
Dec  2 07:39:32 milou kernel: Call Trace: [devfsd_read+856/976]
[sys_read+150/204] [system_call+51/56]  
Dec  2 07:39:32 milou kernel:  
Dec  2 07:39:32 milou kernel: Code: ff 4b 04 0f 94 c0 84 c0 0f 84 09 01
00 00 3b 1d 00 15 21 c0  
Dec  2 07:39:39 milou kernel:  devfs: devfs_unregister(): de->name: "s1"
de: cf6da3ac 
Dec  2 07:39:39 milou kernel: devfs: d_delete(): dentry: cf6c4abc 
inode: cf6c126c  devfs_entry: c14d0984 
Dec  2 07:39:39 milou kernel: devfs: d_delete(): dentry: cf45d240 
inode: cf46361c  devfs_entry: cf6da3ac 
Dec  2 07:39:39 milou kernel: devfs: d_iput(): dentry: cf45d240 inode:
cf46361c de: cf6da3ac  de->dentry: cf45d240 
Dec  2 07:39:39 milou kernel: devfs: d_release(): dentry: cf45d240
inode: 00000000 
Dec  2 07:39:42 milou kernel: devfs: d_delete(): dentry: cff25294 
inode: cff2122c  devfs_entry: c14d512c 
Dec  2 07:39:42 milou kernel: devfs: d_delete(): dentry: cf6cbe3c 
inode: cf6c50a4  devfs_entry: c15d45ac 
Dec  2 07:39:42 milou kernel: devfs: devfs_unregister(): de->name: "s0"
de: cf6da5cc 
Dec  2 07:39:42 milou kernel: devfs: d_delete(): dentry: cf6c49d4 
inode: cf6c2dbc  devfs_entry: c14d08fc 
Dec  2 07:39:42 milou kernel: devfs: d_delete(): dentry: cf620d00 
inode: cf52824c  devfs_entry: cf6da5cc 
Dec  2 07:39:42 milou kernel: devfs: d_iput(): dentry: cf620d00 inode:
cf52824c de: cf6da5cc  de->dentry: cf620d00 
Dec  2 07:39:42 milou kernel: devfs: d_release(): dentry: cf620d00
inode: 00000000 
Dec  2 07:39:56 milou kernel: devfs: d_delete(): dentry: cf6cbeb0 
inode: cf6c528c  devfs_entry: cf6c625c 
Dec  2 07:39:56 milou kernel: devfs: lookup(ptmx): dentry: cf620878
parent: c1419724 by: "mc" 



-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
--------------D0899884FD97F70ECB739B7D
Content-Type: text/plain; charset=us-ascii;
 name="Oops-devfs-v200-2.5.1-pre5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Oops-devfs-v200-2.5.1-pre5"

Dec  2 07:39:29 milou kernel: devfs: devfs_unregister(): de->name: "s3" de: cf6ddf3c 
Dec  2 07:39:29 milou kernel: devfs: d_delete(): dentry: cf6c4c8c  inode: cf6c1a0c  devfs_entry: c14d0a94 
Dec  2 07:39:29 milou kernel: devfs: unlink(ttyp3) 
Dec  2 07:39:29 milou kernel: devfs: d_iput(): dentry: cf45d654 inode: cf378454 de: cf6ddd1c  de->dentry: cf45d654 
Dec  2 07:39:29 milou kernel: devfs: devfs_put(ttyp3): de: cf6ddd1c, parent: c1419724 "" 
Dec  2 07:39:29 milou kernel: devfs: d_delete(): dropping negative dentry: cf45d654 
Dec  2 07:39:29 milou kernel: devfs: d_release(): dentry: cf45d654 inode: 00000000 
Dec  2 07:39:29 milou kernel: devfs: d_delete(): dentry: cf45d5e0  inode: cf37826c  devfs_entry: cf6ddf3c 
Dec  2 07:39:29 milou kernel: devfs: d_iput(): dentry: cf45d5e0 inode: cf37826c de: cf6ddf3c  de->dentry: cf45d5e0 
Dec  2 07:39:29 milou kernel: devfs: devfs_put(s3): de: cf6ddf3c, parent: c14d0874 "pty" 
Dec  2 07:39:29 milou kernel: devfs: d_release(): dentry: cf45d5e0 inode: 00000000 
Dec  2 07:39:32 milou kernel: devfs: devfs_unregister(): de->name: "s2" de: cf6da18c 
Dec  2 07:39:32 milou kernel: devfs: d_delete(): dentry: cf6c4ba4  inode: cf6c163c  devfs_entry: c14d0a0c 
Dec  2 07:39:32 milou kernel: devfs: d_delete(): dentry: cf45d410  inode: cf463bd4  devfs_entry: cf6da18c 
Dec  2 07:39:32 milou kernel: devfs: d_iput(): dentry: cf45d410 inode: cf463bd4 de: cf6da18c  de->dentry: cf45d410 
Dec  2 07:39:32 milou kernel: devfs: d_release(): dentry: cf45d410 inode: 00000000 
Dec  2 07:39:32 milou kernel: devfs: devfs_put(s2): de: cf6da18c, parent: c14d0874 "pty" 
Dec  2 07:39:32 milou kernel: Unable to handle kernel paging request at virtual address 5a5a5a5e 
Dec  2 07:39:32 milou kernel:  printing eip: 
Dec  2 07:39:32 milou kernel: c01516f9 
Dec  2 07:39:32 milou kernel: *pde = 00000000 
Dec  2 07:39:32 milou kernel: Oops: 0002 
Dec  2 07:39:32 milou kernel: CPU:    0 
Dec  2 07:39:32 milou kernel: EIP:    0010:[devfs_put+13/296]    Not tainted 
Dec  2 07:39:32 milou kernel: EFLAGS: 00010206 
Dec  2 07:39:32 milou kernel: eax: 5a5a5a5a   ebx: 5a5a5a5a   ecx: 00000001   edx: 5a5a5a5a 
Dec  2 07:39:32 milou kernel: esi: 00000000   edi: 00000027   ebp: 00000000   esp: cf657f40 
Dec  2 07:39:32 milou kernel: ds: 0018   es: 0018   ss: 0018 
Dec  2 07:39:32 milou kernel: Process devfsd-new (pid: 130, stackpage=cf657000) 
Dec  2 07:39:32 milou kernel: Stack: 00000027 c015465c 5a5a5a5a cf978484 ffffffea 00000000 00000420 cfb97800  
Dec  2 07:39:32 milou kernel:        c01e7f40 cf4fc224 5a5a5a5a 000003f9 00000000 00000000 00000001 00000000  
Dec  2 07:39:32 milou kernel:        cf656000 00000000 00000000 00000000 cf656000 c01e7f6c c01e7f6c c012f5e6  
Dec  2 07:39:32 milou kernel: Call Trace: [devfsd_read+856/976] [sys_read+150/204] [system_call+51/56]  
Dec  2 07:39:32 milou kernel:  
Dec  2 07:39:32 milou kernel: Code: ff 4b 04 0f 94 c0 84 c0 0f 84 09 01 00 00 3b 1d 00 15 21 c0  
Dec  2 07:39:39 milou kernel:  devfs: devfs_unregister(): de->name: "s1" de: cf6da3ac 
Dec  2 07:39:39 milou kernel: devfs: d_delete(): dentry: cf6c4abc  inode: cf6c126c  devfs_entry: c14d0984 
Dec  2 07:39:39 milou kernel: devfs: d_delete(): dentry: cf45d240  inode: cf46361c  devfs_entry: cf6da3ac 
Dec  2 07:39:39 milou kernel: devfs: d_iput(): dentry: cf45d240 inode: cf46361c de: cf6da3ac  de->dentry: cf45d240 
Dec  2 07:39:39 milou kernel: devfs: d_release(): dentry: cf45d240 inode: 00000000 
Dec  2 07:39:42 milou kernel: devfs: d_delete(): dentry: cff25294  inode: cff2122c  devfs_entry: c14d512c 
Dec  2 07:39:42 milou kernel: devfs: d_delete(): dentry: cf6cbe3c  inode: cf6c50a4  devfs_entry: c15d45ac 
Dec  2 07:39:42 milou kernel: devfs: devfs_unregister(): de->name: "s0" de: cf6da5cc 
Dec  2 07:39:42 milou kernel: devfs: d_delete(): dentry: cf6c49d4  inode: cf6c2dbc  devfs_entry: c14d08fc 
Dec  2 07:39:42 milou kernel: devfs: d_delete(): dentry: cf620d00  inode: cf52824c  devfs_entry: cf6da5cc 
Dec  2 07:39:42 milou kernel: devfs: d_iput(): dentry: cf620d00 inode: cf52824c de: cf6da5cc  de->dentry: cf620d00 
Dec  2 07:39:42 milou kernel: devfs: d_release(): dentry: cf620d00 inode: 00000000 
Dec  2 07:39:56 milou kernel: devfs: d_delete(): dentry: cf6cbeb0  inode: cf6c528c  devfs_entry: cf6c625c 
Dec  2 07:39:56 milou kernel: devfs: lookup(ptmx): dentry: cf620878 parent: c1419724 by: "mc" 

--------------D0899884FD97F70ECB739B7D--

