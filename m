Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286338AbSACMG2>; Thu, 3 Jan 2002 07:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286708AbSACMGV>; Thu, 3 Jan 2002 07:06:21 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:54231 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S286334AbSACMGK>; Thu, 3 Jan 2002 07:06:10 -0500
Message-ID: <XFMail.20020103130541.R.Oehler@GDImbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Thu, 03 Jan 2002 13:05:41 +0100 (MET)
From: R.Oehler@GDImbH.com
To: Scsi <linux-scsi@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: kernel 2.4.17 crashes on SCSI-errors
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, List

right now I tried the new kernel 2.4.17, hoping, that
the SCSI-system is now useable again. 
But NO! It immediately crashed, like the few kernels before.

In the meantime I'm really getting into problems with
our product, because I expect SuSE to launch their next 
release soon with an instable "stable" kernel.

Isn't anybody recognizing, that this bug is serious?
3.5" MO-drives report blank sectors as "SCSI-Hardware-Error"
This kind of sense code also appears for errors, that
are much more common than blanked sectors.
Any flaw in SCSI-disks will crash the kernel.
Please don't rely on modern hardware to be so perfect, that
errors will never occure. Then you could likewise remove
the complete error-handling-code. 
This would at least prevent the crashes...


Here is a simple procedure to reliably trigger the BUG:

1) I compiled the SCSI-stuff as modules.
2) I put an erased MO-Medium in a MO-SCSI-drive.
3) I connected the drive to the computer.
4) I typed "modprobe sd_mod"
5) Crash! Serial console said:

Welcome to SuSE Linux 7.3 (i386) - Kernel 2.4.17 (ttyS0).

tick login: invalid operand: 0000
CPU:    0
EIP:    0010:[<d0851735>]    Not tainted
EFLAGS: 00010082
eax: 00000042   ebx: ce3dc070   ecx: c0224080   edx: 0000270d
esi: c009e018   edi: 00000018   ebp: c009e000   esp: c0237dd4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0237000)
Stack: d0867340 00000093 cf95b9ac cfb6de00 c0237e2c 00000000 66656400 00000006 
       cfb6de10 00000002 00000003 00000282 41000031 c0220002 ce434a00 d0851346 
       cfb6de00 ce468ecc 00000293 ce434ab8 ce434a00 cf4f416c 00000092 d083466a 
Call Trace: [<d0867340>] [<d0851346>] [<d083466a>] [<d0834df8>] [<d083baaf>] 
   [<d084e880>] [<d083b10e>] [<d083b2b3>] [<d083b318>] [<d083b7a0>] [<d084cce8>] 
   [<d08351f7>] [<d0835099>] [<c01176a2>] [<c01175d9>] [<c01173ca>] [<c0107f8d>] 
   [<c0105150>] [<c0105150>] [<c0105173>] [<c01051d7>] [<c0105000>] [<c0105027>] 

Code: 0f 0b 83 c4 08 83 3e 00 74 13 8b 06 05 00 00 00 40 89 46 0c 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing



Again I offer my time and my hardware for testing purposes.
I cannot fix the bug in the kernel myself, but I can test patches
and provide resulting stack traces.

Regards,
        Ralf

 -----------------------------------------------------------------
|  Ralf Oehler
|  GDI - Gesellschaft fuer Digitale Informationstechnik mbH
|
|  E-Mail:      R.Oehler@GDImbH.com
|  Tel.:        +49 6182-9271-23 
|  Fax.:        +49 6182-25035           
|  Mail:        GDI, Bensbruchstraﬂe 11, D-63533 Mainhausen
|  HTTP:        www.GDImbH.com
 -----------------------------------------------------------------

time is a funny concept

