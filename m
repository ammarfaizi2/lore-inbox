Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTARUVZ>; Sat, 18 Jan 2003 15:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbTARUVZ>; Sat, 18 Jan 2003 15:21:25 -0500
Received: from smtp.laposte.net ([213.30.181.7]:8947 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S265065AbTARUVY>;
	Sat, 18 Jan 2003 15:21:24 -0500
Message-ID: <002401c2bf30$6809bfc0$0100a8c0@vaio>
From: "Florent CHANTRET" <florent@chantret.com>
To: <linux-kernel@vger.kernel.org>
Subject: [INTEL PII BUG] Still SMBALERT# spontaneous shutdown on VAIO Serie F
Date: Sat, 18 Jan 2003 21:30:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Still having the problem of the spontaneous shutdown on a VAIO serie F
laptop due to a bug in the thermal sensor of the PII celeron. There is no
ACPI, nor APM, nor I2C / SMBus builded in the kernel.

In fact, I have build a really minimal kernel with only this :

- No prompt for development / incomplete code / drivers
- No loadable module support
- Processor PIII / Coppermine
- ISA bus without plug and play
- ELF (kernel core) and a.out / ELF binaries support
- ram disk of 32000 ko + initrd support
- Enhanced ATA / IDE / ATAPI support with IDE/ATA-2 disk support, multi-mode
and CMD640 bugfix
- Virtual terminal + support for console
- ext3, virtual memory, /proc and ext2 file system
- VGA text console

I don't know the kernel internals not the UNIX / Linux programming scheme at
the moment but I don't see the problem anywhere else than for the piece of
code managing the processor (or the kernel core, interrupts perhaps ?). I
doubt that there is the functionnality to shutdown the machine in ISA bus,
binaries support, ramdisk, IDE, filesystems or virtual terminal. Am I right
?

I'm sure that the bug is caused by SMBALERT# in the SMBus specification
refering to this Intel spec :

http://www.intel.com/design/mobile/applnots/24372401.pdf

and
http://cipsa.physik.uni-freiburg.de/~zwerger/Vaio/Intel_Mobile_Temp-Prob.pdf

I would like to create a kernel patch for this bug in order for all VAIO
Serie F customers (and some others mobo that have too the SMBALERT# bug) to
run without spontaneous shutdown and I'm sure there is a solution cause lilo
prompt / MS-DOS don't shutdown and disabling Intel 8271EB power controller
in
Windows 98 solve the problem on this crappy OS ;o).

I'll try to look at the kernel source but no idea if I'll find the few lines
of code that drive it (I'm really surprising that disabling all the power
managment features don't solve this annoying problem at all) so if someone
has some tricks, advices, better knowledges about the kernel and where
could be the solution for this bug... thanks in advance.

Regards,
Florent CHANTRET



---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.443 / Virus Database: 248 - Release Date: 10/01/03

