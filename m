Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265724AbSKATVJ>; Fri, 1 Nov 2002 14:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbSKATVI>; Fri, 1 Nov 2002 14:21:08 -0500
Received: from smtp.slac.stanford.edu ([134.79.18.80]:61380 "EHLO
	smtp.slac.stanford.edu") by vger.kernel.org with ESMTP
	id <S265724AbSKATVB>; Fri, 1 Nov 2002 14:21:01 -0500
Date: Fri, 01 Nov 2002 11:27:28 -0800
From: "John A. Goebel" <jgoebel@SLAC.Stanford.EDU>
Subject: System oops on invalidate_inode
To: linux-kernel@vger.kernel.org
Message-id: <20021101192728.GC8712@noric15.slac.stanford.edu>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_x1avQRutfrEFCFwVDo24hA)"
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_x1avQRutfrEFCFwVDo24hA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

Hello,

Under heavy load, with lots of memory usage, our machines crash. Often this
happens during a write across NFS at the end of a long process (runs of over 24
hours). They're not large writes (4 megs), but there are 32-64 happening on the
the same mount point pretty much at the same time (within seconds). The
mountpoint is on a Solaris 2.8 system.  

Redhat 2.4.18-5 kernel
am-utils-6.0.6-3

I've attached the ksymoops, oops, and kernel objdump.

Please cc me. I am not on the lkml.

Thanks for your help,
John

##############################################
# John Goebel <jgoebel(at)slac.stanford.edu> #
# Stanford Linear Accelerator Center         #
# 2575 Sand Hill Road, Menlo Park, CA 94025  #
############################################ #

--Boundary_(ID_x1avQRutfrEFCFwVDo24hA)
Content-type: text/plain; charset=us-ascii; NAME=barb0308.ksyms
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=barb0308.ksyms

ksymoops 2.4.1 on i686 2.4.18-5smp.  Options used
     -V (default)
     -k /var/log/ksyms.1 (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-5smp/ (default)
     -m /boot/System.map-2.4.18-5smp (default)

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Error (expand_objects): cannot stat(/lib/sym53c8xx.o) for sym53c8xx
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Warning (compare_ksyms_lsmod): module binfmt_misc is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module eepro100 is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module i2c-core is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module i2c-piix4 is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module i2c-proc is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module libafs-2.4.18-5smp.mp is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module lockd is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module nfs is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module sunrpc is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module w83781d is in lsmod but not in ksyms, probably no symbols exported
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Warning (compare_maps): scsi_mod symbol GPLONLY_scsi_reset_provider not found in /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o.  Ignoring /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says f8828a28, /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o says f88270ec.  Ignoring /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says f8828a54, /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o says f8827118.  Ignoring /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says f8828a50, /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o says f8827114.  Ignoring /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says f8828a58, /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o says f882711c.  Ignoring /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says f8828a24, /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o says f88270e8.  Ignoring /lib/modules/2.4.18-5smp/kernel/drivers/scsi/scsi_mod.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000002
c0157d3a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0157d3a>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: c7a09c00   ebx: 00000002   ecx: 00000000   edx: ee78e000
esi: c1eebf78   edi: 00000002   ebp: ee78ff3c   esp: ee78ff04
ds: 0018   es: 0018   ss: 0018
Process amd (pid: 7918, stackpage=ee78f000)
Stack: ee78e000 00000009 00000000 ee78ff3c ee78ff3c c7a09c00 00000000 c0157d9d 
       c02f420c c7a09c00 ee78ff3c c02f4204 c7a09c00 ee78ff3c ccdc2048 ddc6a428 
       c7a09c00 c51d09a0 f8dfcca0 f8dfcdbc c0147da8 c7a09c00 ee78ff90 00000000 
Call Trace: [<c0157d9d>] invalidate_inodes [kernel] 0x3d 
[<f8dfcca0>] nfs_sops [nfs] 0x0 
[<f8dfcdbc>] nfs_fs_type [nfs] 0x0 
[<c0147da8>] kill_super [kernel] 0xd8 
[<c014c189>] path_release [kernel] 0x29 
[<c015aa28>] sys_umount [kernel] 0x78 
[<c012e3a5>] sys_munmap [kernel] 0x35 
[<c015aa3c>] sys_oldumount [kernel] 0xc 
[<c0108c6b>] system_call [kernel] 0x33 
Code: 8b 3b 3b 5c 24 20 0f 85 4a ff ff ff 8b 54 24 04 8b 44 24 08 

>>EIP; c0157d3a <invalidate_list+ea/110>   <=====
Trace; c0157d9d <invalidate_inodes+3d/80>
Trace; f8dfcca0 <END_OF_CODE+592781/????>
Trace; f8dfcdbc <END_OF_CODE+59289d/????>
Trace; c0147da8 <kill_super+d8/170>
Trace; c014c189 <path_release+29/30>
Trace; c015aa28 <sys_umount+78/80>
Trace; c012e3a5 <sys_munmap+35/60>
Trace; c015aa3c <sys_oldumount+c/10>
Trace; c0108c6b <system_call+33/38>
Code;  c0157d3a <invalidate_list+ea/110>
00000000 <_EIP>:
Code;  c0157d3a <invalidate_list+ea/110>   <=====
   0:   8b 3b                     mov    (%ebx),%edi   <=====
Code;  c0157d3c <invalidate_list+ec/110>
   2:   3b 5c 24 20               cmp    0x20(%esp,1),%ebx
Code;  c0157d40 <invalidate_list+f0/110>
   6:   0f 85 4a ff ff ff         jne    ffffff56 <_EIP+0xffffff56> c0157c90 <invalidate_list+40/110>
Code;  c0157d46 <invalidate_list+f6/110>
   c:   8b 54 24 04               mov    0x4(%esp,1),%edx
Code;  c0157d4a <invalidate_list+fa/110>
  10:   8b 44 24 08               mov    0x8(%esp,1),%eax


17 warnings and 5 errors issued.  Results may not be reliable.

--Boundary_(ID_x1avQRutfrEFCFwVDo24hA)
Content-type: text/plain; charset=us-ascii; NAME=barb0308.oops
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=barb0308.oops

Unable to handle kernel NULL pointer dereference at virtual address 00000002
 printing eip:
c0157d3a
*pde = 00000000
Oops: 0000
binfmt_misc w83781d i2c-proc i2c-piix4 i2c-core nfs lockd sunrpc libafs-2.4.18
CPU:    0
EIP:    0010:[<c0157d3a>]    Tainted: PF
EFLAGS: 00010283

EIP is at invalidate_list [kernel] 0xea (2.4.18-5smp)
eax: c7a09c00   ebx: 00000002   ecx: 00000000   edx: ee78e000
esi: c1eebf78   edi: 00000002   ebp: ee78ff3c   esp: ee78ff04
ds: 0018   es: 0018   ss: 0018
Process amd (pid: 7918, stackpage=ee78f000)
Stack: ee78e000 00000009 00000000 ee78ff3c ee78ff3c c7a09c00 00000000 c0157d9d 
       c02f420c c7a09c00 ee78ff3c c02f4204 c7a09c00 ee78ff3c ccdc2048 ddc6a428 
       c7a09c00 c51d09a0 f8dfcca0 f8dfcdbc c0147da8 c7a09c00 ee78ff90 00000000 
Call Trace: [<c0157d9d>] invalidate_inodes [kernel] 0x3d 
[<f8dfcca0>] nfs_sops [nfs] 0x0 
[<f8dfcdbc>] nfs_fs_type [nfs] 0x0 
[<c0147da8>] kill_super [kernel] 0xd8 
[<c014c189>] path_release [kernel] 0x29 
[<c015aa28>] sys_umount [kernel] 0x78 
[<c012e3a5>] sys_munmap [kernel] 0x35 
[<c015aa3c>] sys_oldumount [kernel] 0xc 
[<c0108c6b>] system_call [kernel] 0x33 


Code: 8b 3b 3b 5c 24 20 0f 85 4a ff ff ff 8b 54 24 04 8b 44 24 08 

--Boundary_(ID_x1avQRutfrEFCFwVDo24hA)
Content-type: text/plain; charset=us-ascii; NAME=barb0308-snip.obj
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=barb0308-snip.obj

<snip>
c0157c50 <invalidate_list>:
c0157c50:	55                   	push   %ebp
c0157c51:	57                   	push   %edi
c0157c52:	56                   	push   %esi
c0157c53:	53                   	push   %ebx
c0157c54:	83 ec 0c             	sub    $0xc,%esp
c0157c57:	8b 44 24 20          	mov    0x20(%esp,1),%eax
c0157c5b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp,1)
c0157c62:	00 
c0157c63:	8b 6c 24 28          	mov    0x28(%esp,1),%ebp
c0157c67:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp,1)
c0157c6e:	00 
c0157c6f:	8b 18                	mov    (%eax),%ebx
c0157c71:	39 c3                	cmp    %eax,%ebx
c0157c73:	8b 3b                	mov    (%ebx),%edi
c0157c75:	0f 84 cb 00 00 00    	je     c0157d46 <invalidate_list+0xf6>
c0157c7b:	c7 04 24 00 e0 ff ff 	movl   $0xffffe000,(%esp,1)
c0157c82:	ba 00 e0 ff ff       	mov    $0xffffe000,%edx
c0157c87:	21 e2                	and    %esp,%edx
c0157c89:	89 14 24             	mov    %edx,(%esp,1)
c0157c8c:	8d 74 26 00          	lea    0x0(%esi,1),%esi
c0157c90:	8b 14 24             	mov    (%esp,1),%edx
c0157c93:	8d 73 f8             	lea    0xfffffff8(%ebx),%esi
c0157c96:	8b 42 14             	mov    0x14(%edx),%eax
c0157c99:	85 c0                	test   %eax,%eax
c0157c9b:	74 22                	je     c0157cbf <invalidate_list+0x6f>
c0157c9d:	f0 ff 43 24          	lock incl 0x24(%ebx)
c0157ca1:	b0 01                	mov    $0x1,%al
c0157ca3:	86 05 1c 42 2f c0    	xchg   %al,0xc02f421c
c0157ca9:	e8 62 23 fc ff       	call   c011a010 <set_running_and_schedule>
c0157cae:	f0 fe 0d 1c 42 2f c0 	lock decb 0xc02f421c
c0157cb5:	0f 88 e0 0e 00 00    	js     c0158b9b <.text.lock.inode+0x13e>
c0157cbb:	f0 ff 4b 24          	lock decl 0x24(%ebx)
c0157cbf:	8b 44 24 24          	mov    0x24(%esp,1),%eax
c0157cc3:	39 86 9c 00 00 00    	cmp    %eax,0x9c(%esi)
c0157cc9:	75 6d                	jne    c0157d38 <invalidate_list+0xe8>
c0157ccb:	f0 ff 43 24          	lock incl 0x24(%ebx)
c0157ccf:	b0 01                	mov    $0x1,%al
c0157cd1:	86 05 1c 42 2f c0    	xchg   %al,0xc02f421c
c0157cd7:	56                   	push   %esi
c0157cd8:	e8 23 be fe ff       	call   c0143b00 <invalidate_inode_buffers>
c0157cdd:	5a                   	pop    %edx
c0157cde:	f0 fe 0d 1c 42 2f c0 	lock decb 0xc02f421c
c0157ce5:	0f 88 c0 0e 00 00    	js     c0158bab <.text.lock.inode+0x14e>
c0157ceb:	f0 ff 4b 24          	lock decl 0x24(%ebx)
c0157cef:	8b 46 2c             	mov    0x2c(%esi),%eax
c0157cf2:	85 c0                	test   %eax,%eax
c0157cf4:	75 3a                	jne    c0157d30 <invalidate_list+0xe0>
c0157cf6:	8b 53 fc             	mov    0xfffffffc(%ebx),%edx
c0157cf9:	8b 43 f8             	mov    0xfffffff8(%ebx),%eax
c0157cfc:	89 50 04             	mov    %edx,0x4(%eax)
c0157cff:	89 02                	mov    %eax,(%edx)
c0157d01:	89 73 f8             	mov    %esi,0xfffffff8(%ebx)
c0157d04:	89 73 fc             	mov    %esi,0xfffffffc(%ebx)
c0157d07:	8b 53 04             	mov    0x4(%ebx),%edx
c0157d0a:	8b 46 08             	mov    0x8(%esi),%eax
c0157d0d:	89 50 04             	mov    %edx,0x4(%eax)
c0157d10:	89 02                	mov    %eax,(%edx)
c0157d12:	8b 45 00             	mov    0x0(%ebp),%eax
c0157d15:	89 58 04             	mov    %ebx,0x4(%eax)
c0157d18:	89 46 08             	mov    %eax,0x8(%esi)
c0157d1b:	89 6b 04             	mov    %ebp,0x4(%ebx)
c0157d1e:	89 5d 00             	mov    %ebx,0x0(%ebp)
c0157d21:	83 8e 0c 01 00 00 10 	orl    $0x10,0x10c(%esi)
c0157d28:	ff 44 24 04          	incl   0x4(%esp,1)
c0157d2c:	eb 0a                	jmp    c0157d38 <invalidate_list+0xe8>
c0157d2e:	89 f6                	mov    %esi,%esi
c0157d30:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp,1)
c0157d37:	00 
c0157d38:	89 fb                	mov    %edi,%ebx
c0157d3a:	8b 3b                	mov    (%ebx),%edi
c0157d3c:	3b 5c 24 20          	cmp    0x20(%esp,1),%ebx
c0157d40:	0f 85 4a ff ff ff    	jne    c0157c90 <invalidate_list+0x40>
c0157d46:	8b 54 24 04          	mov    0x4(%esp,1),%edx
c0157d4a:	8b 44 24 08          	mov    0x8(%esp,1),%eax
c0157d4e:	29 15 f0 12 3a c0    	sub    %edx,0xc03a12f0
c0157d54:	83 c4 0c             	add    $0xc,%esp
c0157d57:	5b                   	pop    %ebx
c0157d58:	5e                   	pop    %esi
c0157d59:	5f                   	pop    %edi
c0157d5a:	5d                   	pop    %ebp
c0157d5b:	c3                   	ret    
c0157d5c:	8d 74 26 00          	lea    0x0(%esi,1),%esi

c0157d60 <invalidate_inodes>:
c0157d60:	55                   	push   %ebp
c0157d61:	57                   	push   %edi
c0157d62:	56                   	push   %esi
c0157d63:	53                   	push   %ebx
c0157d64:	83 ec 08             	sub    $0x8,%esp
c0157d67:	89 e3                	mov    %esp,%ebx
c0157d69:	89 1c 24             	mov    %ebx,(%esp,1)
c0157d6c:	89 de                	mov    %ebx,%esi
c0157d6e:	8b 7c 24 1c          	mov    0x1c(%esp,1),%edi
c0157d72:	89 74 24 04          	mov    %esi,0x4(%esp,1)
c0157d76:	f0 fe 0d 1c 42 2f c0 	lock decb 0xc02f421c
c0157d7d:	0f 88 38 0e 00 00    	js     c0158bbb <.text.lock.inode+0x15e>
c0157d83:	53                   	push   %ebx
c0157d84:	57                   	push   %edi
c0157d85:	68 04 42 2f c0       	push   $0xc02f4204
c0157d8a:	e8 c1 fe ff ff       	call   c0157c50 <invalidate_list>
c0157d8f:	53                   	push   %ebx
c0157d90:	89 c5                	mov    %eax,%ebp
c0157d92:	57                   	push   %edi
c0157d93:	68 0c 42 2f c0       	push   $0xc02f420c
c0157d98:	e8 b3 fe ff ff       	call   c0157c50 <invalidate_list>
c0157d9d:	53                   	push   %ebx
c0157d9e:	09 c5                	or     %eax,%ebp
c0157da0:	8d 47 60             	lea    0x60(%edi),%eax
c0157da3:	57                   	push   %edi
c0157da4:	50                   	push   %eax
c0157da5:	e8 a6 fe ff ff       	call   c0157c50 <invalidate_list>
c0157daa:	83 c4 24             	add    $0x24,%esp
c0157dad:	09 c5                	or     %eax,%ebp
c0157daf:	53                   	push   %ebx
c0157db0:	57                   	push   %edi
c0157db1:	83 c7 68             	add    $0x68,%edi
c0157db4:	57                   	push   %edi
c0157db5:	e8 96 fe ff ff       	call   c0157c50 <invalidate_list>
c0157dba:	09 c5                	or     %eax,%ebp
c0157dbc:	83 c4 0c             	add    $0xc,%esp
c0157dbf:	b0 01                	mov    $0x1,%al
c0157dc1:	86 05 1c 42 2f c0    	xchg   %al,0xc02f421c
c0157dc7:	53                   	push   %ebx
c0157dc8:	e8 03 fe ff ff       	call   c0157bd0 <dispose_list>
c0157dcd:	83 c4 0c             	add    $0xc,%esp
c0157dd0:	89 e8                	mov    %ebp,%eax
c0157dd2:	5b                   	pop    %ebx
c0157dd3:	5e                   	pop    %esi
c0157dd4:	5f                   	pop    %edi
c0157dd5:	5d                   	pop    %ebp
c0157dd6:	c3                   	ret    
c0157dd7:	89 f6                	mov    %esi,%esi
c0157dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,1),%edi

<snip>

--Boundary_(ID_x1avQRutfrEFCFwVDo24hA)--
