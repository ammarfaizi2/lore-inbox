Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316051AbSFUXK3>; Fri, 21 Jun 2002 19:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSFUXK2>; Fri, 21 Jun 2002 19:10:28 -0400
Received: from holomorphy.com ([66.224.33.161]:28612 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316051AbSFUXKV>;
	Fri, 21 Jun 2002 19:10:21 -0400
Date: Fri, 21 Jun 2002 16:09:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] floppy requests
Message-ID: <20020621230953.GE22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20020621230417.GA25360@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020621230417.GA25360@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 04:04:17PM -0700, William Lee Irwin III wrote:
> So I ran grub to try to install it on a disk to boot elsewhere. Lo
> and behold, the legendary robustness of floppy handling bursts forth:
> On 2.5.24

Argh! Wrong file! ksymoopsed version:

Cheers,
Bill

ksymoops 2.4.5 on i686 2.4.17lse04-rc3.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.5.24-wli-2 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 000000a0
c023e39d
*pde = 0d6d1001
Oops: 0000
CPU:    1
EIP:    0010:[<c023e39d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: c95f9e58   ecx: c95f8000   edx: c95f9e60
esi: 00000000   edi: c1175358   ebp: e650fd40   esp: c95f9e2c
ds: 0018   es: 0018   ss: 0018
Stack: c95f9e58 c95f9e74 c0246ce3 00000000 e650fd40 00000000 c95f9e74 e650fd40
       00000200 00000001 f7570200 00000001 00000001 c95f9e60 c95f9e60 c1175358
       00000400 00000000 00000000 00000000 e650fd40 00000000 00000000 00000001
Call Trace: [<c0246ce3>] [<c0246c20>] [<c0246d62>] [<c0246eb2>] [<c0142d77>]
   [<c0246ae6>] [<c0142f0d>] [<c0143196>] [<c013be51>] [<c013bd66>] [<c013c18b>]
   [<c01089e7>]
Code: 8b 86 a0 00 00 00 f0 fe 08 0f 88 d0 18 00 00 8d 9e 94 00 00


>>EIP; c023e39d <generic_unplug_device+11/a8>   <=====

>>ebx; c95f9e58 <END_OF_CODE+915ecf4/????>
>>ecx; c95f8000 <END_OF_CODE+915ce9c/????>
>>edx; c95f9e60 <END_OF_CODE+915ecfc/????>
>>edi; c1175358 <END_OF_CODE+cda1f4/????>
>>ebp; e650fd40 <END_OF_CODE+26074bdc/????>
>>esp; c95f9e2c <END_OF_CODE+915ecc8/????>

Trace; c0246ce3 <__floppy_read_block_0+b3/e8>
Trace; c0246c20 <floppy_rb0_complete+0/10>
Trace; c0246d62 <floppy_read_block_0+4a/54>
Trace; c0246eb2 <floppy_revalidate+146/168>
Trace; c0142d77 <check_disk_change+7b/88>
Trace; c0246ae6 <floppy_open+33a/390>
Trace; c0142f0d <do_open+141/330>
Trace; c0143196 <blkdev_open+22/28>
Trace; c013be51 <dentry_open+e1/184>
Trace; c013bd66 <filp_open+52/5c>
Trace; c013c18b <sys_open+37/70>
Trace; c01089e7 <syscall_call+7/b>

Code;  c023e39d <generic_unplug_device+11/a8>
00000000 <_EIP>:
Code;  c023e39d <generic_unplug_device+11/a8>   <=====
   0:   8b 86 a0 00 00 00         mov    0xa0(%esi),%eax   <=====
Code;  c023e3a3 <generic_unplug_device+17/a8>
   6:   f0 fe 08                  lock decb (%eax)
Code;  c023e3a6 <generic_unplug_device+1a/a8>
   9:   0f 88 d0 18 00 00         js     18df <_EIP+0x18df> c023fc7c <.text.lock.ll_rw_blk+10/a4>
Code;  c023e3ac <generic_unplug_device+20/a8>
   f:   8d 9e 94 00 00 00         lea    0x94(%esi),%ebx

