Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbSBDSC6>; Mon, 4 Feb 2002 13:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSBDSCs>; Mon, 4 Feb 2002 13:02:48 -0500
Received: from albator.hlfl.org ([213.41.91.230]:25107 "HELO albator.hlfl.org")
	by vger.kernel.org with SMTP id <S283003AbSBDSCh>;
	Mon, 4 Feb 2002 13:02:37 -0500
Date: Mon, 4 Feb 2002 19:02:36 +0100
From: Arnaud Launay <asl@launay.org>
To: linux-kernel@vger.kernel.org
Subject: Oops kernel 2.2.20
Message-ID: <20020204190236.A5871@profile4u.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Some days ago we got an oops on our master nfs server.

Here it is, passed through ksymoops.

If you need more things, please tell me.

	Arnaud.

ksymoops 2.4.3 on i686 2.2.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.2.20/ (default)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
Jan 28 10:06:51 devfs kernel: Unable to handle kernel paging request at virtual address 73914c3a
Jan 28 10:06:51 devfs kernel: current->tss.cr3 = 17596000, %cr3 = 17596000
Jan 28 10:06:51 devfs kernel: *pde = 00000000
Jan 28 10:06:51 devfs kernel: Oops: 0000
Jan 28 10:06:51 devfs kernel: CPU:    0
Jan 28 10:06:51 devfs kernel: EIP:    0010:[find_buffer+104/144]
Jan 28 10:06:51 devfs kernel: EFLAGS: 00010206
Jan 28 10:06:51 devfs kernel: eax: 73914c3a   ebx: 00000007   ecx: 0000f3c0   edx: 73914c3a
Jan 28 10:06:51 devfs kernel: esi: 0000000d   edi: 00000801   ebp: 00180a2e   esp: d7241e88
Jan 28 10:06:51 devfs kernel: ds: 0018   es: 0018   ss: 0018
Jan 28 10:06:51 devfs kernel: Process rpc.nfsd (pid: 63, process nr: 16, stackpage=d7241000)
Jan 28 10:06:51 devfs kernel: Stack: 00180a2e 00000011 0000f3c0 c0144eec 00000801 00180a2e 00001000 00000058 
Jan 28 10:06:51 devfs kernel:        00000400 c4992ae0 00000000 00001000 cd29476c 00000008 00000400 00180a1d 
Jan 28 10:06:51 devfs kernel:        00000000 000001db c0145138 ce354188 0001640c ca7fc160 c4992ae0 00000000 
Jan 28 10:06:51 devfs kernel: Call Trace: [trunc_indirect+392/668] [trunc_dindirect+312/356] [ext2_truncate+151/508] [ext2_delete_inode+102/140] [ext2_delete_inode+124/140] [iput+155/588] [d_delete+74/104] 
Jan 28 10:06:51 devfs kernel: Code: 8b 00 39 6a 04 75 15 8b 4c 24 20 39 4a 08 75 0c 66 39 7a 0c 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
   2:   39 6a 04                  cmp    %ebp,0x4(%edx)
Code;  00000004 Before first symbol
   5:   75 15                     jne    1c <_EIP+0x1c> 0000001c Before first symbol
Code;  00000006 Before first symbol
   7:   8b 4c 24 20               mov    0x20(%esp,1),%ecx
Code;  0000000a Before first symbol
   b:   39 4a 08                  cmp    %ecx,0x8(%edx)
Code;  0000000e Before first symbol
   e:   75 0c                     jne    1c <_EIP+0x1c> 0000001c Before first symbol
Code;  00000010 Before first symbol
  10:   66 39 7a 0c               cmp    %di,0xc(%edx)

