Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292352AbSBUMVw>; Thu, 21 Feb 2002 07:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292353AbSBUMVe>; Thu, 21 Feb 2002 07:21:34 -0500
Received: from [200.210.136.3] ([200.210.136.3]:36370 "EHLO rf.com.br")
	by vger.kernel.org with ESMTP id <S292352AbSBUMVT>;
	Thu, 21 Feb 2002 07:21:19 -0500
Date: Thu, 21 Feb 2002 09:20:57 -0300 (BRT)
From: Joao Soares Veiga <jsveiga_lkml@rf.com.br>
X-X-Sender: <jsveiga_lkml@yankee.rfcom>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.17 ide-scsi errors
Message-ID: <Pine.LNX.4.33.0202210905130.10072-100000@yankee.rfcom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've seen some old posts (+yr) about this, with no conclusion, and I've 
seen that the changelogs on the latest(s) -18pre and development pre have 
addressed tape bug fixes and SCSI (including ide-scsi).

I'm having problems with a Seagate ATAPI STT220000A Travan Tapestor unit.

Has anyone had problems with that model at 2.4.17? Have these issues been 
addressed specifically on these latest -pres? 

I have the modules st, ide-scsi, scsi_mod, sg loaded.

Problems:

1. The diagnostic program from Seagate (and their technical support) say 
the unit is bad and need replacement):
zu /root/backup_scripts # diagsvlx rwtest -id:0

 Checking System Configuration.
 Wed Feb 20 08:35:13 2002
 ATAPI/IDE Logical Drive Id: 0
 Seagate STT20000A, Firmware: 8A51

 Issued Cmd: Test Read-Write.
 Issued Cmd: Test Unit Ready.
 Issued Cmd: Load Tape.
 Issued Cmd: Write 200 MB to tape.
 Write Command Complete.
 Issued Cmd: Write File Marks.
 Issued Cmd: Rewind Tape.
 Issued Cmd: Read and Compare 200 MB of data from tape.
 Test failed due to excessive errors.
 Retry the test with a different tape and/or clean the drive.
 Issued Final Cmd: Rewind Tape.

..although I can write/read anything without errors.

2. Although I can read/write without data corruption, /var/log/messages 
says:
Feb 21 09:10:14 zulu kernel: st0: Error with sense data: Current st09:00: 
sense key Illegal Request
Feb 21 09:10:14 zulu kernel: Additional sense indicates Invalid command 
operation code


Do I really need a new tape drive unit, or is this "normal" with 2.4.17?

Thanks,

Joao


