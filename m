Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264744AbTFEQ0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264755AbTFEQ0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:26:08 -0400
Received: from uldns1.unil.ch ([130.223.8.20]:37262 "EHLO uldns1.unil.ch")
	by vger.kernel.org with ESMTP id S264744AbTFEQ0D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:26:03 -0400
Date: Thu, 5 Jun 2003 18:39:32 +0200
From: Gregoire Favre <greg@magma.unil.ch>
To: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org
Subject: Re: [linux-dvb] Can't boot since 2.4.21-rc2-ac3 with dvb-kernel
Message-ID: <20030605163932.GA17573@magma.unil.ch>
References: <20030602171613.GA1609@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030602171613.GA1609@magma.unil.ch>
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

as already repported with older ac and older CVS of dvb-kernel, same
Oops with 2.4.21-rc7-ac1:

ksymoops -v /usr/src/linux/vmlinux -l /lib/modules/2.4.21-rc7-ac1 -m /usr/src/linux-2.4.21-rc7-ac1/System.map OOps 
ksymoops 2.4.8 on i686 2.4.21-rc7-ac1.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /lib/modules/2.4.21-rc7-ac1 (specified)
     -o /lib/modules/2.4.21-rc7-ac1/ (default)
     -m /usr/src/linux-2.4.21-rc7-ac1/System.map (specified)

Error (regular_file): read_lsmod /lib/modules/2.4.21-rc7-ac1 is not a regular file, ignored
Unable to handle kernel NULL pointer dereference at virtual address 00000001
00000001
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000001>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: f6e03980   ebx: e2658dac   ecx: f1466b00   edx: f7302180
esi: fab4b320   edi: fab4b300   ebp: 00000000   esp: d8c5fed8
ds: 0018   es: 0018   ss: 0018
Process v4l-conf (pid: 7132, stackpage=d8c5f000)
Stack: fab4a2bb f6e03980 f1466b00 c0144dce ef295b00 ef295a80 d9d2200f c0145626 
       ef295b00 d8c5ff10 00000000 00000001 c0168164 f6b81e00 f6e03980 f6e03980 
       f1466b00 c0168d88 f6e03980 f1466b00 00000003 c0144c65 00000003 ffffffeb 
Call Trace:    [<fab4a2bb>] [<c0144dce>] [<c0145626>] [<c0168164>] [<c0168d88>]
  [<c0144c65>] [<c013a076>] [<c0139ebd>] [<c013a28e>] [<c01071b7>]
Code:  Bad EIP value.


>>EIP; 00000001 Before first symbol   <=====

>>eax; f6e03980 <_end+36a19a00/3a7520e0>
>>ebx; e2658dac <_end+2226ee2c/3a7520e0>
>>ecx; f1466b00 <_end+3107cb80/3a7520e0>
>>edx; f7302180 <_end+36f18200/3a7520e0>
>>esi; fab4b320 <[videodev]video_fops+0/47>
>>edi; fab4b300 <[videodev]videodev_lock+0/0>
>>esp; d8c5fed8 <_end+18875f58/3a7520e0>

Trace; fab4a2bb <[videodev]video_open+182/1d2>
Trace; c0144dce <cached_lookup+18/5b>
Trace; c0145626 <link_path_walk+616/6b8>
Trace; c0168164 <devfs_get_ops+82/b0>
Trace; c0168d88 <devfs_open+147/1ca>
Trace; c0144c65 <vfs_permission+8a/12b>
Trace; c013a076 <dentry_open+1b4/1f3>
Trace; c0139ebd <filp_open+5c/61>
Trace; c013a28e <sys_open+53/a6>
Trace; c01071b7 <system_call+33/38>


1 error issued.  Results may not be reliable.
Exit 1

Is there anything I could do to make it works?

	Grégoire
__________________________________________________________________
http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch
