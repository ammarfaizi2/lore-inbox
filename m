Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWBXHnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWBXHnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWBXHnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:43:18 -0500
Received: from pc1.pod.cz ([213.155.227.146]:3286 "EHLO pc11.op.pod.cz")
	by vger.kernel.org with ESMTP id S1750863AbWBXHnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:43:16 -0500
Date: Fri, 24 Feb 2006 08:43:10 +0100
From: Vitezslav Samel <samel@mail.cz>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [libata] CD on PATA: "ReadCD MMC 12"  command fails
Message-ID: <20060224074310.GA1311@pc11.op.pod.cz>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

        Hi!

  I'm trying to rip some music CD with cdda2wav, but that fails. I have "LG
GSA-4165B" (PATA drive) connected on 8086:24db (Intel ICH5 IDE controller)
using ata_piix.

cdda2wav first fails with ENOMEM (16 times) and then with EDOM till the end of
the track in response to the "ReadCD MMC 12" (code 0xbe) SG_IO command (see
attached output and strace). Ripping on plain SCSI CD drive works OK.

Tested on 2.6.16-rc4 and alans 2.6.16-rc4-ide2. I also applied your fix
mailed to LKML on Tue, 21 Feb 2006 00:17:14 -0500.

	Cheers,
		Vita

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cdda2wav.output"

Type: ROM, Vendor 'HL-DT-ST' Model 'DVDRAM GSA-4165B' Revision 'DL03' MMC+CDDA
765952 bytes buffer memory requested, 4 buffers, 75 sectors
#Cdda2wav version 2.01.01a03_linux_2.6.14_i686_i686, real time sched., soundcard, libparanoia support
AUDIOtrack pre-emphasis  copy-permitted tracktype channels
      1-14           no              no     audio    2
Table of Contents: total tracks:14, (total time 75:33.20)
  1.( 6:12.48),  2.( 3:55.12),  3.( 4:19.62),  4.( 4:44.05),  5.( 4:31.63),
  6.( 3:50.56),  7.( 4:14.27),  8.( 3:55.12),  9.( 4:10.37), 10.(10:21.66),
 11.( 5:50.68), 12.( 3:22.60), 13.( 5:41.38), 14.(10:21.66)

Table of Contents: starting sectors
  1.(       0),  2.(   27948),  3.(   45585),  4.(   65072),  5.(   86377),
  6.(  106765),  7.(  124071),  8.(  143148),  9.(  160785), 10.(  179572),
 11.(  226213), 12.(  252531), 13.(  267741), 14.(  293354), lead-out(  339995)
CDINDEX discid: 2DQPE0G9jQbLKfbFRubDU3b9tuM-
CDDB discid: 0xca11b50e
CD-Text: detected
CD-Extra: not detected
Album title: 'Century Child'	[from Nightwish]
Track  1: 'Bless The Child'
Track  2: 'End Of All Hope'
Track  3: 'Dead To The World'
Track  4: 'Ever Dream'
Track  5: 'Slaying The Dreamer'
Track  6: 'Forever Yours'
Track  7: 'Ocean Soul'
Track  8: 'Feel For You'
Track  9: 'The Phantom Of The Opera'
Track 10: 'Beauty Of The Beast'
Track 11: 'Nightwish'
Track 12: 'The Wayfahrer (Japanese Bonus)'
Track 13: 'The Forever Moments'
Track 14: 'Beauty Of The Beast'
samplefile size will be 65733740 bytes.
recording 372.6400 seconds stereo with 16 bits @ 44100.0 Hz ->'audio'...
percent_done:
  0%cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 00 00 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 00 4B 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.086s timeout 60s
cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 00 96 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 00 E1 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
  0%cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 01 2C 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 01 77 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 01 C2 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
  1%cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 02 0D 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 02 58 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 02 A3 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 02 EE 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
  2%cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 03 39 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 03 84 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 03 CF 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
cdda2wav: Cannot allocate memory. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 04 1A 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
  3%cdda2wav: Numerical argument out of domain. ReadCD MMC 12: scsi sendcmd: no error
CDB:  BE 04 00 00 04 65 00 00 4B 10 00 00
status: 0x0 (GOOD STATUS)
cmd finished after 0.000s timeout 60s
[...]

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cdda2wav.strace"

[...]
write(2, "percent_done:\n  0%", 18)     = 18
gettimeofday({1140762269, 285276}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57b0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 285366}, NULL) = 0
gettimeofday({1140762269, 285410}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 285485}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
gettimeofday({1140762269, 285933}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 372763}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
gettimeofday({1140762269, 398177}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 398272}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
gettimeofday({1140762269, 398804}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 398920}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 595419}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 595551}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 596617}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 596746}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 597824}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 597950}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 599269}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 599390}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 600362}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 600479}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 601387}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 601504}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 602397}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 602514}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 603652}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 603770}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 604701}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 604817}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 605771}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 605888}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 606842}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 ENOMEM (Cannot allocate memory)
gettimeofday({1140762269, 606958}, NULL) = 0
write(2, "cdda2wav: Cannot allocate memory"..., 178) = 178
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 608146}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 EDOM (Numerical argument out of domain)
gettimeofday({1140762269, 608215}, NULL) = 0
write(2, "cdda2wav: Numerical argument out"..., 188) = 188
read(5, "1", 1)                  = 1
gettimeofday({1140762269, 609475}, NULL) = 0
ioctl(3, SG_IO, 0xbf9c57e0)             = -1 EDOM (Numerical argument out of domain)
gettimeofday({1140762269, 609544}, NULL) = 0
write(2, "cdda2wav: Numerical argument out"..., 188) = 188
read(5, "1", 1)                  = 1
[...]

--Qxx1br4bt0+wmkIi--
