Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282823AbRLBJ3t>; Sun, 2 Dec 2001 04:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282825AbRLBJ3j>; Sun, 2 Dec 2001 04:29:39 -0500
Received: from smtp-abo-6.wanadoo.fr ([193.252.19.222]:27104 "EHLO
	citronier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282823AbRLBJ31>; Sun, 2 Dec 2001 04:29:27 -0500
Message-ID: <3C09F402.B2B04478@wanadoo.fr>
Date: Sun, 02 Dec 2001 10:27:30 +0100
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
		<3C0898AD.FED8EF4A@wanadoo.fr> <200112011836.fB1IaxY31897@vindaloo.ras.ucalgary.ca>
Content-Type: multipart/mixed;
 boundary="------------92794F34F604303DCD4C2624"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------92794F34F604303DCD4C2624
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Richard Gooch wrote:
> 
> Pierre Rousselet writes:
> > Richard Gooch wrote:
> > > Indeed I do. Please Cc: me on devfs related stuff. And please apply
> > > devfs-patch-v200, which fixes a stupid typo. I'd also be interested in
> > > knowing the behaviour with 2.4.17-pre1.

Same looking Oops with 2.4.17-pre1 as with 2.5.1-pre5. A log with devfs
debug message is attached. I was able to reboot from the command line
after this oops.

Dec  2 10:04:31 milou kernel: Unable to handle kernel paging request at
virtual address 5a5a5a5e 
Dec  2 10:04:31 milou kernel: c014f509 
Dec  2 10:04:31 milou kernel: *pde = 00000000 
Dec  2 10:04:31 milou kernel: Oops: 0002 
Dec  2 10:04:31 milou kernel: CPU:    0 
Dec  2 10:04:31 milou kernel: EIP:    0010:[ext2_remount+105/312]    Not
tainted 
Dec  2 10:04:31 milou kernel: EFLAGS: 00010206 
Dec  2 10:04:31 milou kernel: eax: 5a5a5a5a   ebx: 5a5a5a5a   ecx:
0000000b   edx: 5a5a5a5a 
Dec  2 10:04:31 milou kernel: esi: 00000000   edi: 00000027   ebp:
00000000   esp: c7f61f40 
Dec  2 10:04:31 milou kernel: ds: 0018   es: 0018   ss: 0018 
Dec  2 10:04:31 milou kernel: Process devfsd (pid: 129,
stackpage=c7f61000) 
Dec  2 10:04:31 milou kernel: Stack: 00000027 c015246c 5a5a5a5a c8282414
ffffffea 00000000 00000420 c847a800  
Dec  2 10:04:31 milou kernel:        c01e5280 c7e16224 5a5a5a5a 000003f9
00000000 00000000 00000001 00000000  
Dec  2 10:04:31 milou kernel:        c7f60000 00000000 00000000 00000000
c7f60000 c01e52ac c01e52ac c012e926  
Dec  2 10:04:31 milou kernel: Call Trace: [devfs_read_super+144/212]
[sys_read+150/204] [system_call+51/56]  
Dec  2 10:04:31 milou kernel: Code: ff 4b 04 0f 94 c0 84 c0 0f 84 09 01
00 00 3b 1d 40 e4 20 c0  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 4b 04                  decl   0x4(%ebx)
Code;  00000002 Before first symbol
   3:   0f 94 c0                  sete   %al
Code;  00000006 Before first symbol
   6:   84 c0                     test   %al,%al
Code;  00000008 Before first symbol
   8:   0f 84 09 01 00 00         je     117 <_EIP+0x117> 00000116
Before first symbol
Code;  0000000e Before first symbol
   e:   3b 1d 40 e4 20 c0         cmp    0xc020e440,%ebx


Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
--------------92794F34F604303DCD4C2624
Content-Type: text/plain; charset=us-ascii;
 name="oops-2.4.17-pre1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops-2.4.17-pre1"

Dec  2 10:03:33 milou kernel: devfs: d_delete(): dentry: c7f41a48  inode: c7e6f9cc  devfs_entry: c7fe75cc 
Dec  2 10:04:21 milou kernel: devfs: lookup(ptmx): dentry: c7d96d94 parent: c1419724 by: "mc" 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dropping negative dentry: c7d96d94 
Dec  2 10:04:21 milou kernel: devfs: d_release(): dentry: c7d96d94 inode: 00000000 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dentry: c7fd78cc  inode: c7fd4804  devfs_entry: c7fd30c4 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dentry: c7fd79b4  inode: c7fd4bd4  devfs_entry: c7fd314c 
Dec  2 10:04:21 milou kernel: devfs: devfs_register(pty/s1): de: c7fe74bc dir: c14db8dc "pty"  pp: c1419724 
Dec  2 10:04:21 milou kernel: devfs: lookup(ttyp1): dentry: c7d96d94 parent: c1419724 by: "devfsd" 
Dec  2 10:04:21 milou kernel: devfs: devfs_do_symlink(ttyp1) 
Dec  2 10:04:21 milou kernel: devfs: get_vfs_inode(817): VFS inode: c7d9c9cc  devfs_entry: c7fe73ac 
Dec  2 10:04:21 milou kernel: devfs:   mode: 0120555  uid: 0  gid: 0 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dentry: c7d96d94  inode: c7d9c9cc  devfs_entry: c7fe73ac 
Dec  2 10:04:21 milou kernel: devfs: lookup(s1): dentry: c7d96e7c parent: c14db8dc by: "mc" 
Dec  2 10:04:21 milou kernel: devfs: get_vfs_inode(816): VFS inode: c7d9c7e4  devfs_entry: c7fe74bc 
Dec  2 10:04:21 milou kernel: devfs:   mode: 020600  uid: 0  gid: 0 
Dec  2 10:04:21 milou kernel: devfs: lookup(): new VFS inode(816): c7d9c7e4  devfs_entry: c7fe74bc 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dentry: c7d96d94  inode: c7d9c9cc  devfs_entry: c7fe73ac 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dentry: c7d96e7c  inode: c7d9c7e4  devfs_entry: c7fe74bc 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dentry: c7d96d94  inode: c7d9c9cc  devfs_entry: c7fe73ac 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dentry: c7d96e7c  inode: c7d9c7e4  devfs_entry: c7fe74bc 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dentry: c7d96d94  inode: c7d9c9cc  devfs_entry: c7fe73ac 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dentry: c7d96e7c  inode: c7d9c7e4  devfs_entry: c7fe74bc 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dentry: c7d96d94  inode: c7d9c9cc  devfs_entry: c7fe73ac 
Dec  2 10:04:21 milou kernel: devfs: d_delete(): dentry: c7d96d94  inode: c7d9c9cc  devfs_entry: c7fe73ac 
Dec  2 10:04:26 milou kernel: devfs: devfs_unregister(): de->name: "s1" de: c7fe74bc 
Dec  2 10:04:26 milou kernel: devfs: d_delete(): dentry: c7fd7940  inode: c7fd49ec  devfs_entry: c14db9ec 
Dec  2 10:04:26 milou kernel: devfs: unlink(ttyp1) 
Dec  2 10:04:26 milou kernel: devfs: d_iput(): dentry: c7d96d94 inode: c7d9c9cc de: c7fe73ac  de->dentry: c7d96d94 
Dec  2 10:04:26 milou kernel: devfs: devfs_put(ttyp1): de: c7fe73ac, parent: c1419724 "" 
Dec  2 10:04:26 milou kernel: devfs: d_delete(): dropping negative dentry: c7d96d94 
Dec  2 10:04:26 milou kernel: devfs: d_release(): dentry: c7d96d94 inode: 00000000 
Dec  2 10:04:26 milou kernel: devfs: d_delete(): dentry: c7d96e7c  inode: c7d9c7e4  devfs_entry: c7fe74bc 
Dec  2 10:04:26 milou kernel: devfs: d_iput(): dentry: c7d96e7c inode: c7d9c7e4 de: c7fe74bc  de->dentry: c7d96e7c 
Dec  2 10:04:26 milou kernel: devfs: devfs_put(s1): de: c7fe74bc, parent: c14db8dc "pty" 
Dec  2 10:04:26 milou kernel: devfs: d_release(): dentry: c7d96e7c inode: 00000000 
Dec  2 10:04:31 milou kernel: devfs: d_delete(): dentry: cff34138  inode: cff6cc14  devfs_entry: c14ea23c 
Dec  2 10:04:31 milou kernel: devfs: d_delete(): dentry: c7f74634  inode: c7f73bf4  devfs_entry: c15e86bc 
Dec  2 10:04:31 milou kernel: devfs: devfs_unregister(): de->name: "s0" de: c7fe76dc 
Dec  2 10:04:31 milou kernel: devfs: d_delete(): dentry: c7fd7858  inode: c7fd461c  devfs_entry: c14db964 
Dec  2 10:04:31 milou kernel: devfs: d_delete(): dentry: c7f41ba4  inode: c7e6fbb4  devfs_entry: c7fe76dc 
Dec  2 10:04:31 milou kernel: devfs: d_iput(): dentry: c7f41ba4 inode: c7e6fbb4 de: c7fe76dc  de->dentry: c7f41ba4 
Dec  2 10:04:31 milou kernel: devfs: d_release(): dentry: c7f41ba4 inode: 00000000 
Dec  2 10:04:31 milou kernel: devfs: devfs_put(s0): de: c7fe76dc, parent: c14db8dc "pty" 
Dec  2 10:04:31 milou kernel: Unable to handle kernel paging request at virtual address 5a5a5a5e 
Dec  2 10:04:31 milou kernel:  printing eip: 
Dec  2 10:04:31 milou kernel: c014f509 
Dec  2 10:04:31 milou kernel: *pde = 00000000 
Dec  2 10:04:31 milou kernel: Oops: 0002 
Dec  2 10:04:31 milou kernel: CPU:    0 
Dec  2 10:04:31 milou kernel: EIP:    0010:[ext2_remount+105/312]    Not tainted 
Dec  2 10:04:31 milou kernel: EFLAGS: 00010206 
Dec  2 10:04:31 milou kernel: eax: 5a5a5a5a   ebx: 5a5a5a5a   ecx: 0000000b   edx: 5a5a5a5a 
Dec  2 10:04:31 milou kernel: esi: 00000000   edi: 00000027   ebp: 00000000   esp: c7f61f40 
Dec  2 10:04:31 milou kernel: ds: 0018   es: 0018   ss: 0018 
Dec  2 10:04:31 milou kernel: Process devfsd (pid: 129, stackpage=c7f61000) 
Dec  2 10:04:31 milou kernel: Stack: 00000027 c015246c 5a5a5a5a c8282414 ffffffea 00000000 00000420 c847a800  
Dec  2 10:04:31 milou kernel:        c01e5280 c7e16224 5a5a5a5a 000003f9 00000000 00000000 00000001 00000000  
Dec  2 10:04:31 milou kernel:        c7f60000 00000000 00000000 00000000 c7f60000 c01e52ac c01e52ac c012e926  
Dec  2 10:04:31 milou kernel: Call Trace: [devfs_read_super+144/212] [sys_read+150/204] [system_call+51/56]  
Dec  2 10:04:31 milou kernel:  
Dec  2 10:04:31 milou kernel: Code: ff 4b 04 0f 94 c0 84 c0 0f 84 09 01 00 00 3b 1d 40 e4 20 c0  
Dec  2 10:04:53 milou kernel:  devfs: d_delete(): dentry: c141b4b8  inode: c155d434  devfs_entry: c14ea2c4 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c141b4b8  inode: c155d434  devfs_entry: c14ea2c4 
Dec  2 10:04:53 milou last message repeated 6 times
Dec  2 10:04:53 milou kernel: devfs: devfs_unregister(): de->name: "6" de: c84799cc 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c7f74e5c  inode: c7f70064  devfs_entry: c84799cc 
Dec  2 10:04:53 milou kernel: devfs: d_iput(): dentry: c7f74e5c inode: c7f70064 de: c84799cc  de->dentry: c7f74e5c 
Dec  2 10:04:53 milou kernel: devfs: d_release(): dentry: c7f74e5c inode: 00000000 
Dec  2 10:04:53 milou kernel: devfs: devfs_unregister(): de->name: "a6" de: c8479a54 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c7f74f44  inode: c7f70434  devfs_entry: c8479a54 
Dec  2 10:04:53 milou kernel: devfs: d_iput(): dentry: c7f74f44 inode: c7f70434 de: c8479a54  de->dentry: c7f74f44 
Dec  2 10:04:53 milou kernel: devfs: d_release(): dentry: c7f74f44 inode: 00000000 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c8306b30  inode: c8319a2c  devfs_entry: c14ea67c 
Dec  2 10:04:53 milou kernel: devfs: devfs_unregister(): de->name: "5" de: c15f69ec 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c7f74abc  inode: c7f71044  devfs_entry: c15f69ec 
Dec  2 10:04:53 milou kernel: devfs: d_iput(): dentry: c7f74abc inode: c7f71044 de: c15f69ec  de->dentry: c7f74abc 
Dec  2 10:04:53 milou init: Switching to runlevel: 6
Dec  2 10:04:53 milou kernel: devfs: d_release(): dentry: c7f74abc inode: 00000000 
Dec  2 10:04:53 milou kernel: devfs: devfs_unregister(): de->name: "a5" de: c15f6eb4 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c7f74ba4  inode: c7f71414  devfs_entry: c15f6eb4 
Dec  2 10:04:53 milou kernel: devfs: d_iput(): dentry: c7f74ba4 inode: c7f71414 de: c15f6eb4  de->dentry: c7f74ba4 
Dec  2 10:04:53 milou kernel: devfs: d_release(): dentry: c7f74ba4 inode: 00000000 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c8306abc  inode: c8319844  devfs_entry: c14ea5f4 
Dec  2 10:04:53 milou kernel: devfs: devfs_unregister(): de->name: "4" de: c15f6a74 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c7f74c8c  inode: c7f717e4  devfs_entry: c15f6a74 
Dec  2 10:04:53 milou kernel: devfs: d_iput(): dentry: c7f74c8c inode: c7f717e4 de: c15f6a74  de->dentry: c7f74c8c 
Dec  2 10:04:53 milou kernel: devfs: d_release(): dentry: c7f74c8c inode: 00000000 
Dec  2 10:04:53 milou kernel: devfs: devfs_unregister(): de->name: "a4" de: c8479944 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c7f74d74  inode: c7f71bb4  devfs_entry: c8479944 
Dec  2 10:04:53 milou kernel: devfs: d_iput(): dentry: c7f74d74 inode: c7f71bb4 de: c8479944  de->dentry: c7f74d74 
Dec  2 10:04:53 milou kernel: devfs: d_release(): dentry: c7f74d74 inode: 00000000 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c8306a48  inode: c831965c  devfs_entry: c14ea56c 
Dec  2 10:04:53 milou kernel: devfs: devfs_unregister(): de->name: "3" de: c15f6e2c 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c7f748ec  inode: c7f72844  devfs_entry: c15f6e2c 
Dec  2 10:04:53 milou kernel: devfs: d_iput(): dentry: c7f748ec inode: c7f72844 de: c15f6e2c  de->dentry: c7f748ec 
Dec  2 10:04:53 milou kernel: devfs: d_release(): dentry: c7f748ec inode: 00000000 
Dec  2 10:04:53 milou kernel: devfs: devfs_unregister(): de->name: "a3" de: c15f6d1c 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c7f749d4  inode: c7f72c14  devfs_entry: c15f6d1c 
Dec  2 10:04:53 milou kernel: devfs: d_iput(): dentry: c7f749d4 inode: c7f72c14 de: c15f6d1c  de->dentry: c7f749d4 
Dec  2 10:04:53 milou kernel: devfs: d_release(): dentry: c7f749d4 inode: 00000000 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c83069d4  inode: c8319474  devfs_entry: c14ea4e4 
Dec  2 10:04:53 milou kernel: devfs: devfs_unregister(): de->name: "2" de: c15f6da4 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c7f7471c  inode: c7f720a4  devfs_entry: c15f6da4 
Dec  2 10:04:53 milou kernel: devfs: d_iput(): dentry: c7f7471c inode: c7f720a4 de: c15f6da4  de->dentry: c7f7471c 
Dec  2 10:04:53 milou kernel: devfs: d_release(): dentry: c7f7471c inode: 00000000 
Dec  2 10:04:53 milou kernel: devfs: devfs_unregister(): de->name: "a2" de: c15f6f3c 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c7f74804  inode: c7f72474  devfs_entry: c15f6f3c 
Dec  2 10:04:53 milou kernel: devfs: d_iput(): dentry: c7f74804 inode: c7f72474 de: c15f6f3c  de->dentry: c7f74804 
Dec  2 10:04:53 milou kernel: devfs: d_release(): dentry: c7f74804 inode: 00000000 
Dec  2 10:04:53 milou kernel: devfs: d_delete(): dentry: c8306960  inode: c831928c  devfs_entry: c14ea45c 
Dec  2 10:04:58 milou kernel: devfs: d_delete(): dentry: c141b4b8  inode: c155d434  devfs_entry: c14ea2c4 
Dec  2 10:04:58 milou last message repeated 2 times
Dec  2 10:04:58 milou kernel: devfs: devfs_unregister(): de->name: "1" de: c15e8634 
Dec  2 10:04:58 milou kernel: devfs: d_delete(): dentry: c7f7454c  inode: c7f73824  devfs_entry: c15e8634 
Dec  2 10:04:58 milou kernel: devfs: d_iput(): dentry: c7f7454c inode: c7f73824 de: c15e8634  de->dentry: c7f7454c 
Dec  2 10:04:58 milou kernel: devfs: d_release(): dentry: c7f7454c inode: 00000000 
Dec  2 10:04:58 milou kernel: devfs: devfs_unregister(): de->name: "a1" de: c15e86bc 
Dec  2 10:04:58 milou kernel: devfs: d_delete(): dentry: c7f74634  inode: c7f73bf4  devfs_entry: c15e86bc 
Dec  2 10:04:58 milou kernel: devfs: d_iput(): dentry: c7f74634 inode: c7f73bf4 de: c15e86bc  de->dentry: c7f74634 
Dec  2 10:04:58 milou kernel: devfs: d_release(): dentry: c7f74634 inode: 00000000 
Dec  2 10:04:58 milou kernel: devfs: d_delete(): dentry: c83068ec  inode: c83190a4  devfs_entry: c14ea3d4 
Dec  2 10:04:59 milou kernel: devfs: devfs_register(1): de: c7fe729c dir: c14d1ba4 "vcc"  pp: c1419724 
Dec  2 10:04:59 milou exiting on signal 15

--------------92794F34F604303DCD4C2624--

