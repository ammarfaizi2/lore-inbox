Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288923AbSATS7T>; Sun, 20 Jan 2002 13:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288930AbSATS7K>; Sun, 20 Jan 2002 13:59:10 -0500
Received: from sente.pl ([195.117.126.124]:23307 "EHLO sente.pl")
	by vger.kernel.org with ESMTP id <S288923AbSATS64> convert rfc822-to-8bit;
	Sun, 20 Jan 2002 13:58:56 -0500
Subject: Re: 2.4.18-pre3 ReiserFS crashes not for the first time...
From: Grzegorz Prokopski <greg@sente.pl>
To: linux-kernel@vger.kernel.org
Cc: greg@sente.pl
In-Reply-To: <1011542953.695.0.camel@greg>
In-Reply-To: <1011542953.695.0.camel@greg>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 20 Jan 2002 17:59:42 +0100
Message-Id: <1011545986.1352.0.camel@greg>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W li¶cie z nie, 20-01-2002, godz. 17:09, Grzegorz Prokopski pisze: 
> Hi!
> 
> First I must say I have not sent anythink like that to LKML yet,
> but gonna do my best to give as much and as good information as
> I can.
Thanks to Mark Hahn for pointing me out that I should use ksymoops
(I was thinking about it, but didn't really knew what to do with it)

Here it goes:

greg:~# ksymoops ./reiserfs.oops 
ksymoops 2.4.3 on i586 2.4.18-p3lvmpe.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-p3lvmpe/ (default)
     -m /boot/System.map-2.4.18-p3lvmpe (default)
>>>> those are right for my system I think

Warning (expand_objects): object
/lib/modules/2.4.18-p3lvmpe/kernel/fs/reiserfs/reiserfs.o for module
reiserfs has changed since load
>>>> this is the right module IMO - I use cramfs with modules to boot
>>>> the machine - above modules dir was used to create the image
>>>> from which reiserfs module was loaded

invalid operand: 0000
CPU:    0
EIP:    0010:[<d081c239>]             Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
 eax: 0000002f  ebx: d082bea0  ecx: ffffe061  edx: c4aea000
 esi: sffe8000  edi: ffffffef  ebp: c4aebf0c  esp: c4aebcec
 ds: 0018  es: 0018  ss: 0018
 Stack: d082d79a d0831b20 d082bea0 c4aebd10 c4a129a0 caebdd8 d0812299
 cffe8000
 d082bea0 c4a12a1c c4a12a1c c4a129a0 c49ac060 00000000 00000000 00000000
 00000000 00000000 00000000 00000000 d08301cf 00000000 00000039 00013850
  [<d08301cf>] [<d0828baf>] [<c013cd99>] [<c013cf96>] [<c0106f43>]
 Code: 0f 0b 68 20 1b 83 d0 85 f6 74 0f 0f b7 46 08 50 e8 ba 4d 91

>>EIP; d081c238 <[reiserfs]reiserfs_panic+28/54>   <=====
Code;  d081c238 <[reiserfs]reiserfs_panic+28/54>
00000000 <_EIP>:
Code;  d081c238 <[reiserfs]reiserfs_panic+28/54>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  d081c23a <[reiserfs]reiserfs_panic+2a/54>
   2:   68 20 1b 83 d0            push   $0xd0831b20
Code;  d081c23e <[reiserfs]reiserfs_panic+2e/54>
   7:   85 f6                     test   %esi,%esi
Code;  d081c240 <[reiserfs]reiserfs_panic+30/54>
   9:   74 0f                     je     1a <_EIP+0x1a> d081c252
<[reiserfs]reiserfs_panic+42/54>
Code;  d081c242 <[reiserfs]reiserfs_panic+32/54>
   b:   0f b7 46 08               movzwl 0x8(%esi),%eax
Code;  d081c246 <[reiserfs]reiserfs_panic+36/54>
   f:   50                        push   %eax
Code;  d081c248 <[reiserfs]reiserfs_panic+38/54>
  10:   e8 ba 4d 91 00            call   914dcf <_EIP+0x914dcf> d1131006
<END_OF_CODE+15c928/????>

2 warnings issued.  Results may not be reliable.
greg:~# 


HTH
					Grzegorz Prokopski

