Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272675AbRILEgk>; Wed, 12 Sep 2001 00:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272672AbRILEga>; Wed, 12 Sep 2001 00:36:30 -0400
Received: from mailhost.iitb.ac.in ([203.197.74.142]:5124 "HELO
	mailhost.iitb.ac.in") by vger.kernel.org with SMTP
	id <S272673AbRILEgS>; Wed, 12 Sep 2001 00:36:18 -0400
Date: Wed, 12 Sep 2001 10:05:17 +0530 (IST)
From: ajit k jena <ajit@indica.iitb.ac.in>
To: <linux-kernel@vger.kernel.org>
Subject: Problems with Quantum DLT 4000 + HP C5173-4000
Message-ID: <Pine.LNX.4.33.0109121004380.7146-100000@indica.iitb.ac.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I hope the problem I am posting is appropriate for this forum.

We have a Quantum DLT 4000 SCSI-2 tape device connected to a
RedHat Linux 7.1 box using BusLogic BT-950 card.

When the system boots, we get the following messages on the
screen:

	Vendor: HP Model: C5173-4000 Media Changer Rev: 3.02
	Vendor: Quantum Model: DLT4000 Rev: CD3C

The /var/log/messages file shows the following message:

	st0: Block limits 1-16777215 bytes.

When I use the mtx utility on /dev/sg0, things are OK. I am
able to do 'inquiry', 'status', 'load', 'unload' operations
properly.

I put a tape cartridge into the drive by using the command

	mtx -f /dev/sg0 load 1

Then I use the mt command as below:

	mt -f /dev/st0 status

	the output is:

	SCSI 2 tape drive:

	File number = 0, block number=0, partition=0
	Tape block size 0 bytes, Density code 0x1a
				(unknown to this mt)
	Soft error count since last status=0
	General status bits on (41010000):
		BOT ONLINE IM_REP_EN

I am using HP 1/2" DLTtape IV Data cartridge.

When I try to do a tar onto the tape, I get the message:

	Wrote only 0 of 10240 bytes
	Error is not recoverable: exiting now

The tape unit was attached to an HP9000 system before. The
HP DLTtape IV cartridges are recommended for this drive.
I thought there may something wrong with the particular
cartridge and so I even tried brand new cartridges. The
results are the same every time.

Can someone please help me understand the problem here ?
I hope to benefit from someone else's experience in this
regard.

Thanks for your time.

--ajit

|-----------------------------------------------------------------|
| Ajit K. Jena                      Phone :                       |
|                                     Office +91-22-5767751       |
| Computer Centre                            +91-22-5722545 x8750 |
| Indian Institute of Technology      Home   +91-22-5722545 x8068 |
| POWAI, Bombay                     Fax   :        +91-22-5723894 |
| PIN 400076, India                 Email :    ajit@cc.iitb.ac.in |
|-----------------------------------------------------------------|



