Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279912AbRKNA4A>; Tue, 13 Nov 2001 19:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279907AbRKNAzu>; Tue, 13 Nov 2001 19:55:50 -0500
Received: from 24-168-215-96.he.cox.rr.com ([24.168.215.96]:27781 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S279904AbRKNAze>;
	Tue, 13 Nov 2001 19:55:34 -0500
Date: Tue, 13 Nov 2001 19:55:34 -0500
Mime-Version: 1.0 (Apple Message framework v472)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: IDE tape problems
From: Anthony DeRobertis <asd@suespammers.org>
To: Linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4F289B8D-D89A-11D5-9181-00039355CFA6@suespammers.org>
X-Mailer: Apple Mail (2.472)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an interesting issue with the ide-tape driver. It manages 
to truncate anything read from tape[0]. From a very limited data 
set, it appears that the longer the data on the tape, the more 
blocks are truncated.

I've tried 2.4.6 and 2.4.14. Tape drive is a Seagate STT20000A, 
MB is a KT7-RAID w/ 768MB mem and an Athlon 1200. Drive is slave 
on the second channel (on the VIA controller, not the highpoint 
one). Other device is a BCD E520C CD-ROM. The tape is a 10G TR-5 
from Imation.

This setup does work with SCSI emulation, though the console 
gets spammed with messages like:
	st0: Error with sense data: Current st09:00: sense key Illegal Request
	Additional sense indicates Invalid command operation code

Amanda works with the SCSI setup; with the IDE setup, amlabel 
fails. I've tried re-tensioning the tape; no help.

I'm willing to try patches, incantations, etc.

[0] I assume it is truncating on the read side, but it could 
very well be doing it on the write side.

