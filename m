Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbTGAHWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 03:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbTGAHWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 03:22:05 -0400
Received: from mail3.netbeat.de ([62.208.140.20]:2500 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S266023AbTGAHV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 03:21:58 -0400
Message-ID: <3F0139D5.1080602@gmx.de>
Date: Tue, 01 Jul 2003 09:35:49 +0200
From: =?ISO-8859-1?Q?Cornelius_K=F6lbel?= <cornelius.koelbel@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030601
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Bug in Kernel 2.4.20-8]
Content-Type: multipart/mixed;
 boundary="------------040600070603000308000200"
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040600070603000308000200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

=2E..Hello, here is the promised attachment :-(

Hello,

I am using Kernel 2.4.20. I admit, it is the kernel of RedHat 9.
I hope this is not, because RedHat did so much changes to the Kernel

I was just typing a mail, when the caps lock light and the scroll lock li=
ght went on.
Nothing happend anymore. No mouse, no keyboard.
I resetted the computer.

After that, I found the attached output in the /var/log/messages.
I am running cyurs-imapd, I am not sure, if it is due to cyrus.

If the buffer.c might have something to do with the filesystem:
I am using the ext3 filesystem, I have ide and scsi-drives in my system.
Here is an extract of lsmod:
ext3                   69984   4
jbd                    51220   4  [ext3]
sym53c8xx              67376   1
sd_mod                 13324   2
scsi_mod              106168   2  [sym53c8xx sd_mod]

If you need any furhter information I will provide it.

Regards
Corneius




--=20
Cornelius K=F6lbel
Landgraf-Karl-Str. 19
34131 Kassel

0561 / 816 75 34


--------------040600070603000308000200
Content-Type: text/plain;
 name="kernelBUG.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernelBUG.txt"

Jul  1 08:47:59 schnuck ctl_cyrusdb[2341]: checkpointing cyrus databases
Jul  1 08:47:59 schnuck ctl_cyrusdb[2341]: done checkpointing cyrus databases
Jul  1 08:54:41 schnuck su(pam_unix)[2667]: session opened for user cyrus by (uid=0)
Jul  1 08:54:41 schnuck su(pam_unix)[2667]: session closed for user cyrus
Jul  1 08:55:36 schnuck kernel: ------------[ cut here ]------------
Jul  1 08:55:36 schnuck kernel: kernel BUG at buffer.c:2568!
Jul  1 08:55:36 schnuck kernel: invalid operand: 0000
Jul  1 08:55:36 schnuck kernel: es1371 ac97_codec gameport soundcore mga agpgart ppp_deflate zlib_deflate ppp_async
ppp_generic slhc parport_pc lp parport starfire 8139too mii ipt_owner ipt_
Jul  1 08:55:36 schnuck kernel: CPU:    0
Jul  1 08:55:36 schnuck kernel: EIP:    0060:[<c0147fd5>]    Not tainted
Jul  1 08:55:36 schnuck kernel: EFLAGS: 00010206
Jul  1 08:55:36 schnuck kernel:
Jul  1 08:55:36 schnuck kernel: EIP is at grow_buffers [kernel] 0x39 (2.4.20-8)
Jul  1 08:55:36 schnuck kernel: eax: 000001ff   ebx: 00000000   ecx: 00000200   edx: 00000000
Jul  1 08:55:36 schnuck kernel: esi: 0000131c   edi: 0000131b   ebp: 0000131c   esp: d45afdd4
Jul  1 08:55:36 schnuck kernel: ds: 0068   es: 0068   ss: 0068
Jul  1 08:55:36 schnuck kernel: Process updatedb (pid: 2912, stackpage=d45af000)
Jul  1 08:55:36 schnuck kernel: Stack: f7bb5400 00000293 f7bbb9c0 f7bb5400 00000000 0000131c 0000131b 10000000
Jul  1 08:55:36 schnuck kernel:        c0145ba6 0000131c 10000000 0000131b d45ae000 00000001 00000000 00000000
Jul  1 08:55:36 schnuck kernel:        00000000 f88556a8 0000131c 10000000 0000131b d45afe54 00000000 00000008
Jul  1 08:55:36 schnuck kernel: Call Trace:   [<c0145ba6>] getblk [kernel] 0x52 (0xd45afdf4))
Jul  1 08:55:36 schnuck kernel: [<f88556a8>] ext3_getblk [ext3] 0xa8 (0xd45afe18))
Jul  1 08:55:36 schnuck kernel: [<f882b360>] sd_template [sd_mod] 0x0 (0xd45afe3c))
Jul  1 08:55:36 schnuck kernel: [<c0144da2>] __wait_on_buffer [kernel] 0x7a (0xd45afe7c))
Jul  1 08:55:36 schnuck kernel: [<f885598e>] ext3_bread [ext3] 0xb6 (0xd45afea4))
Jul  1 08:55:36 schnuck kernel: [<f8852c65>] ext3_readdir [ext3] 0xf9 (0xd45afec4))
Jul  1 08:55:36 schnuck kernel: [<c014e8ab>] cached_lookup [kernel] 0x1b (0xd45afee0))
Jul  1 08:55:36 schnuck kernel: [<c01530bd>] vfs_readdir [kernel] 0x9d (0xd45aff54))
Jul  1 08:55:36 schnuck kernel: [<c01536e8>] filldir64 [kernel] 0x0 (0xd45aff60))
Jul  1 08:55:36 schnuck kernel: [<c0153853>] sys_getdents64 [kernel] 0x5b (0xd45aff74))
Jul  1 08:55:36 schnuck kernel: [<c01536e8>] filldir64 [kernel] 0x0 (0xd45aff7c))
Jul  1 08:55:36 schnuck kernel: [<c0142833>] sys_fchdir [kernel] 0x4b (0xd45affa0))
Jul  1 08:55:36 schnuck kernel: [<c01093b3>] system_call [kernel] 0x33 (0xd45affc0))
Jul  1 08:55:36 schnuck kernel:
Jul  1 08:55:36 schnuck kernel:
Jul  1 08:55:36 schnuck kernel: Code: 0f 0b 08 0a 57 70 25 c0 8d 87 00 fe ff ff 3d 00 0e 00 00 76
Jul  1 08:55:36 schnuck kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jul  1 08:55:36 schnuck kernel:  printing eip:
Jul  1 08:55:36 schnuck kernel: c01377c6
Jul  1 08:58:21 schnuck syslogd 1.4.1: restart.

--------------040600070603000308000200--

