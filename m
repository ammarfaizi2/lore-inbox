Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbSLJUMW>; Tue, 10 Dec 2002 15:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbSLJUMW>; Tue, 10 Dec 2002 15:12:22 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:32265 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S265727AbSLJUMR> convert rfc822-to-8bit;
	Tue, 10 Dec 2002 15:12:17 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.51, APM, USB] APM not sleeping
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Tue, 10 Dec 2002 20:54:31 +0100
Message-ID: <8765u1vedk.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running "apm -s" I get:

bad: scheduling while atomic!
Call Trace: [<c0119e81>]  [<c012379e>]  [<c0123714>]  [<c6a6d043>]  [<c6a6d3cb>]  [<c6a6f3b7>]  [<c6a5cfca>]  [<c0147491>]  [<c018391d>]  [<c0173a6a>]  [<c01233e0>]  [<c024c7b5>]  [<c01234f9>]  [<c024c790>]  [<c018391d>]  [<c017f063>]  [<c017f7ce>]  [<c01720bb>]  [<c011a1f0>]  [<c017fc7c>]  [<c0173054>]  [<c017b5ed>]  [<c0159e0b>]  [<c015ac10>]  [<c015ad36>]  [<c015adac>]  [<c0159536>]  [<c015853f>]  [<c01523fc>]  [<c01bd7a5>]  [<c015463f>]  [<c0108cd7>]
apm: suspend: Unable to enter requested state

Decoded:
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0119e81 <schedule+3d/2c8>
Trace; c012379e <schedule_timeout+7a/a0>
Trace; c0123714 <process_timeout+0/10>
Trace; c6a6d043 <END_OF_CODE+66768c3/????>
Trace; c6a6d3cb <END_OF_CODE+6676c4b/????>
Trace; c6a6f3b7 <END_OF_CODE+6678c37/????>
Trace; c6a5cfca <END_OF_CODE+666684a/????>
Trace; c0147491 <bh_lru_install+d9/e4>
Trace; c018391d <journal_cancel_revoke+101/178>
Trace; c0173a6a <ext3_get_block_handle+be/310>
Trace; c01233e0 <update_process_times+2c/38>
Trace; c024c7b5 <cursor_timer_handler+25/2c>
Trace; c01234f9 <run_timer_softirq+f1/144>
Trace; c024c790 <cursor_timer_handler+0/2c>
Trace; c018391d <journal_cancel_revoke+101/178>
Trace; c017f063 <do_get_write_access+50f/530>
Trace; c017f7ce <journal_dirty_metadata+1ba/1f0>
Trace; c01720bb <ext3_free_inode+397/3c8>
Trace; c011a1f0 <__wake_up+20/40>
Trace; c017fc7c <journal_stop+258/268>
Trace; c0173054 <ext3_delete_inode+0/194>
Trace; c017b5ed <ext3_destroy_inode+15/1c>
Trace; c0159e0b <destroy_inode+3f/58>
Trace; c015ac10 <generic_delete_inode+c4/d0>
Trace; c015ad36 <generic_drop_inode+12/20>
Trace; c015adac <iput+68/70>
Trace; c0159536 <d_delete+6a/c4>
Trace; c015853f <dput+1b/158>
Trace; c01523fc <sys_unlink+dc/11c>
Trace; c01bd7a5 <capable+1d/38>
Trace; c015463f <sys_ioctl+21f/270>
Trace; c0108cd7 <syscall_call+7/b>

Loaded modules are:

root@gswi1164:/var/log# lsmod
Module                  Size  Used by
neofb                  10861  0
pcnet_cs               11048  1 [unsafe]
8390                    6272  1 pcnet_cs
ds                      6460  3 pcnet_cs
yenta_socket           10301  2 [unsafe]
pcmcia_core            37598  3 pcnet_cs ds yenta_socket
ppp_async               6573  0
ppp_generic            18147  1 ppp_async
slhc                    4896  1 ppp_generic
rxrpc                  51733  0
vfat                    8945  0
fat                    33837  1 vfat

I suspect pcnet_cs or yenta_socket, because:
Module yenta_socket cannot be unloaded due to unsafe usage in drivers/pcmcia/yenta.c:940
Module pcnet_cs cannot be unloaded due to unsafe usage in drivers/net/pcmcia/pcnet_cs.c:1033

On a related note, I removed the USB driver uhci-hcd for
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
because going to sleep stopped with 

Dec  9 00:33:52 gswi1164 kernel: drivers/usb/core/hcd-pci.c: suspend 00:07.2 to state 3
Dec  9 00:33:52 gswi1164 kernel: drivers/usb/host/uhci-hcd.c: 8400: suspend_hc
Dec  9 00:33:52 gswi1164 kernel: atkbd.c: Unknown key (set 2, scancode 0x9c, on isa0060/serio0) pressed.
Dec  9 00:33:52 gswi1164 kernel: apm: suspend: Unable to enter requested state
Dec  9 00:33:52 gswi1164 kernel: drivers/usb/core/hcd-pci.c: resume 00:07.2

Any ideas?

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
