Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbTDBU01>; Wed, 2 Apr 2003 15:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262198AbTDBU01>; Wed, 2 Apr 2003 15:26:27 -0500
Received: from photon.hao.ucar.edu ([128.117.16.7]:31924 "EHLO
	photon.hao.ucar.edu") by vger.kernel.org with ESMTP
	id <S262184AbTDBU0W>; Wed, 2 Apr 2003 15:26:22 -0500
Message-Id: <200304022037.h32Kbl515811@photon.hao.ucar.edu>
Date: Wed, 2 Apr 2003 13:37:47 -0700 (MST)
From: Barry Gamblin <bgamblin@hao.ucar.edu>
Reply-To: Barry Gamblin <bgamblin@hao.ucar.edu>
Subject: kernel BUG at page_alloc.c:145!
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Drove_of_Cattle_068_000
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.3.5 SunOS 5.7 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Drove_of_Cattle_068_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: UStcpCpR+llmJLjWFjvbog==

I got this in /var/log/messages today. Can anyone tell me what this 
means? I have been having lots of trouble with this server - Supermicro 
p4dc6, dual Xeon 1.7G processors, 2.4.18-19.7.xsmp kernel, Redhat 7.3.

Does this indicate a software or hardware error?

Thanks, Barry

--Drove_of_Cattle_068_000
Content-Type: TEXT/plain; name=kernelbug; charset=us-ascii; x-unix-mode=0664
Content-Description: kernelbug
Content-MD5: uAgYj5QloJ7U+bcA+VF77w==

Apr  2 10:59:16 cedar-l kernel: ------------[ cut here ]------------
Apr  2 10:59:16 cedar-l kernel: kernel BUG at page_alloc.c:145!
Apr  2 10:59:16 cedar-l kernel: invalid operand: 0000
Apr  2 10:59:16 cedar-l kernel: nfsd autofs nfs lockd sunrpc eepro100 usb-uhci usbcore aic7xxx sd_mod scsi_mod  
Apr  2 10:59:16 cedar-l kernel: CPU:    1
Apr  2 10:59:16 cedar-l kernel: EIP:    0010:[<c013acd8>]    Not tainted
Apr  2 10:59:16 cedar-l kernel: EFLAGS: 00010206
Apr  2 10:59:16 cedar-l kernel: 
Apr  2 10:59:16 cedar-l kernel: EIP is at __free_pages_ok [kernel] 0xe8 (2.4.18-19.7.xsmp)
Apr  2 10:59:16 cedar-l kernel: eax: 00000000   ebx: c205d1a0   ecx: 11000000   edx: 00000000
Apr  2 10:59:16 cedar-l kernel: esi: 00000000   edi: c1000030   ebp: 00000000   esp: d8d33e38
Apr  2 10:59:16 cedar-l kernel: ds: 0018   es: 0018   ss: 0018
Apr  2 10:59:16 cedar-l kernel: Process gridncclient (pid: 31116, stackpage=d8d33000)
Apr  2 10:59:16 cedar-l kernel: Stack: c205d210 c1c40030 c0306288 c205d1a0 00000000 c0130127 c205d1a0 c205d1a0 
Apr  2 10:59:16 cedar-l kernel:        00000000 e5f7d284 e5f7d284 c0130538 00000000 d8d32000 00000001 f8aba3ec 
Apr  2 10:59:16 cedar-l kernel:        f4f0eb10 d8d33eb0 0000000c d8d33ea0 d8d33eb0 00000000 0000000c d8d33ea0 
Apr  2 10:59:16 cedar-l kernel: Call Trace: [<c0130127>] remove_inode_page [kernel] 0x27 (0xd8d33e4c))
Apr  2 10:59:16 cedar-l kernel: [<c0130538>] truncate_list_pages [kernel] 0x218 (0xd8d33e64))
Apr  2 10:59:16 cedar-l kernel: [<f8aba3ec>] nfs3_proc_remove [nfs] 0xbc (0xd8d33e74))
Apr  2 10:59:16 cedar-l kernel: [<c01305cd>] truncate_inode_pages [kernel] 0x5d (0xd8d33eb4))
Apr  2 10:59:16 cedar-l kernel: [<f8ac38c0>] nfs_sops [nfs] 0x0 (0xd8d33ed8))
Apr  2 10:59:16 cedar-l kernel: [<c0159bdb>] iput [kernel] 0xbb (0xd8d33ee0))
Apr  2 10:59:16 cedar-l kernel: [<f8aafdda>] nfs_dentry_iput [nfs] 0x5a (0xd8d33efc))
Apr  2 10:59:16 cedar-l kernel: [<c0157bc7>] d_delete [kernel] 0x57 (0xd8d33f0c))
Apr  2 10:59:16 cedar-l kernel: [<f8ab2373>] nfs_zap_caches [nfs] 0x53 (0xd8d33f1c))
Apr  2 10:59:16 cedar-l kernel: [<f8ab0557>] nfs_safe_remove [nfs] 0x127 (0xd8d33f30))
Apr  2 10:59:16 cedar-l kernel: [<f8ab05b7>] nfs_unlink [nfs] 0x47 (0xd8d33f4c))
Apr  2 10:59:16 cedar-l kernel: [<c01501d4>] vfs_unlink [kernel] 0x1b4 (0xd8d33f5c))
Apr  2 10:59:16 cedar-l kernel: [<c014ee4a>] lookup_hash [kernel] 0x4a (0xd8d33f68))
Apr  2 10:59:16 cedar-l kernel: [<c01502c9>] sys_unlink [kernel] 0x89 (0xd8d33f88))
Apr  2 10:59:16 cedar-l kernel: [<c0108c83>] system_call [kernel] 0x33 (0xd8d33fc0))
Apr  2 10:59:16 cedar-l kernel: 
Apr  2 10:59:16 cedar-l kernel: 
Apr  2 10:59:16 cedar-l kernel: Code: 0f 0b 91 00 17 09 25 c0 c6 43 24 05 8b 43 18 89 f1 83 e0 eb 


--Drove_of_Cattle_068_000--
