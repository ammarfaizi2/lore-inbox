Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269911AbRHEDzj>; Sat, 4 Aug 2001 23:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269912AbRHEDz3>; Sat, 4 Aug 2001 23:55:29 -0400
Received: from ns.skjellin.no ([193.69.71.66]:63121 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id <S269911AbRHEDzN>;
	Sat, 4 Aug 2001 23:55:13 -0400
Message-ID: <002b01c11d62$73e65540$8405000a@slurv>
From: "Andre Tomt" <andre@tomt.net>
To: <linux-kernel@vger.kernel.org>
Subject: SMP Support for AMD Athlon MP motherboards
Date: Sun, 5 Aug 2001 05:55:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2526.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2526.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently got my hands on a unreleased evaluation AthlonMP motherboard with
two 1.1Ghz Athlon CPU's. First thing I tried was of course Linux. I ran into
some problems, however.

1. the SCSI subsystem hung during loading. Before anything card-specefic
driver loaded. SMP og non-SMP kernels, same thing. Modular loading of
scsi-drivers did the same thing upon loading. Full lockup. Got it partly
working on an IDE drive after a while.

2. Linux did only see one CPU.

3. It were highly unstable, even in non-SMP mode.

Whats the degree of support in Linux for such an AMD mobo? Is the Athlon MP
architecture supported at all yet?

I managed to get FreeBSD running on it, and use the SCSI-controller
(Adaptec, not sure about what board since I do not have physical access as I
write this. Uses the aic7xxx driver, u160scsi). However, FreeBSD would not
boot in SMP mode (scsi lockup like Linux did in both SMP and non-SMP
kernels, it did see both CPU's however...).

Now, shed some light on this. I tried kernels fram 2.0.3x to 2.4.7, 2.0 and
2.2 did alot of really strange stuff, like making user space apps saying
"You do not exist"(?).

How is the support for AMD Athlon MP, really :-)

--
Regards,
André Tomt

