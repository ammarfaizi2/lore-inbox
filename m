Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSEGErP>; Tue, 7 May 2002 00:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSEGErO>; Tue, 7 May 2002 00:47:14 -0400
Received: from mail-infomine.ucr.edu ([138.23.89.48]:52962 "EHLO
	mail-infomine.ucr.edu") by vger.kernel.org with ESMTP
	id <S315334AbSEGErN>; Tue, 7 May 2002 00:47:13 -0400
Date: Mon, 6 May 2002 21:47:08 -0700
To: linux-kernel@vger.kernel.org
Subject: Can't Burn CDR's On 2.4.19pre8
Message-ID: <20020507044708.GA31888@mail-infomine.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
From: ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know whether I have a hardware problem or a kernel problem.  Here's
what I get when I try to dummy burn a data CDR on 2.4.19pre8:

Track 01: data  586 MB
Total size:     674 MB (66:46.85) = 300514 sectors
Lout start:     674 MB (66:48/64) = 300514 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 4
  Is not unrestricted
  Is not erasable
  ATIP start of lead in:  233100 (151:50/00)
  ATIP start of lead out: 523425 (116:21/00)
Disk type:    unknown
Manuf. index: -1
Manufacturer: unknown (not in table)
Blocks total: 333975 Blocks current: 333975 Blocks remaining: 33461
Starting to write CD/DVD at speed 1 in dummy mode for single session.
Last chance to quit, starting dummy write in 0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
Starting new track at sector: 0
Track 01:   9 of 586 MB written (fifo 100%).cdrecord: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 13 03 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: F0 00 03 00 00 10 6C 0C 00 00 00 00 0C 00 00 00
Sense Key: 0x3 Medium Error, Segment 0
Sense Code: 0x0C Qual 0x00 (write error) Fru 0x0
Sense flags: Blk 4204 (valid)
cmd finished after 1.013s timeout 40s

write track data: error after 9967616 bytes
Sense Bytes: 70 00 00 00 00 00 00 0C 00 00 00 00 00 00 00 00 00 00
cdrecord: Input/output error. flush cache: scsi sendcmd: no error
CDB:  35 00 00 00 00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: F0 00 03 00 00 10 6C 0C 00 00 00 00 0C 00 00 00
Sense Key: 0x3 Medium Error, Segment 0
Sense Code: 0x0C Qual 0x00 (write error) Fru 0x0
Sense flags: Blk 4204 (valid)
cmd finished after 3.387s timeout 120s
Trouble flushing the cache
Writing  time:   69.828s
Fixating...
WARNING: Some drives don't like fixation in dummy mode.
Fixating time:    0.008s
cdrecord: fifo had 221 puts and 158 gets.
cdrecord: fifo was 0 times empty and 141 times full, min fill was 90%.

This was at speed=1 my writer is supposed to handle up to speed=4.  When I
retry I get errors after various amounts have been written.  The command
I issued was "cdrecord -v dev=0,0,0 -dummy -data speed=1 /home/xxxxx/backup.img"
Do I have a bad writer or is this a kernel bug?  I'll gladly provide any 
additional config or hardware info as requested.
-- 
TIA,
Johannes
--
Dr. Johannes Ruscheinski
EMail:    ruschein_AT_infomine.ucr.edu ***          Linux                  ***
Location: science library, room G40    *** The Choice Of A GNU Generation! ***
Phone:    (909) 787-2279

"He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?"
                            -- Montgomery C. Burns
