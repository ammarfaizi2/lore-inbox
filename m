Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263127AbREWPb5>; Wed, 23 May 2001 11:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263128AbREWPbh>; Wed, 23 May 2001 11:31:37 -0400
Received: from at18.tphys.uni-linz.ac.at ([140.78.103.18]:36869 "EHLO
	at18.tphys.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S263127AbREWPbg>; Wed, 23 May 2001 11:31:36 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Alexander Puchmayr <alexander.puchmayr@jk.uni-linz.ac.at>
Reply-To: alexander.puchmayr@jk.uni-linz.ac.at
Organization: University Linz, Austria
To: linux-kernel@vger.kernel.org
Subject: EFS problems?
Date: Wed, 23 May 2001 17:31:14 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01052317311403.01265@at18>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List!

I have a IRIX installation CD, which I want to export to some SGI workstation 
via NFS, using an SCSI-CDrom drive.

When I try to access the data, i get several SCSI errors, IO-Errors and so 
on, regardless if via NFS or locally. 
Errors are:

sym53c8xx_reset: pid=0 reset_flags=1 serial_number=0 
serial_number_at_timeout=0
scsi0: device driver called scsi_done() for a synchronous reset.
sym53c810a-0: restart (scsi reset).
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=1 serial_number=0 
serial_number_at_timeout=0
scsi0: device driver called scsi_done() for a synchronous reset.
sym53c810a-0: restart (scsi reset).
sym53c810a-0-<6,0>: sync msgout: 1-3-1-19-8.
SCSI cdrom error : host 0 channel 0 id 6 lun 0 return code = 27070000
 I/O error: dev 0b:00, sector 719
sym53c810a-0-<6,0>: sync msg in: 1-3-1-19-8.
sym53c810a-0-<6,0>: sync: per=25 scntl3=0x10 scntl4=0x0 ofs=8 fak=0 chg=0.
sym53c810a-0-<6,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
sym53c810a-0:6: message 6 sent on bad reselection.
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 6, lun 0 
Read (10) 00 00 00 00 d3 00 00 13 00 
sym53c8xx_abort: pid=0 serial_number=13299 serial_number_at_timeout=13299
sym53c810a-0-<6,*>: control msgout: 80 6.

But when i dd the whole media, ie. "dd if=/dev/sr0 of=/dev/null" I get no 
error at all.

The system is a K6/400, 128 MB Ram, symbios-compatible (sym53c8xx-driver) 
scsi card, 3c905 NW card; Software: SuSE 7.1, Kernel 2.4.2 (with Suse 
patches).

So I assume the CD and the drive are OK, and there's a bug in the EFS 
filesystem.

What can I do for further investigation?

	Alexander Puchmayr

-- 
---
Alexander Puchmayr 
Institut für Theoretische Physik     Altenbergerstr. 69, A-4040 Linz
Johannes-Kepler Universitaet         Phone: ++43 732/2468-8633
A-4040 Linz, Austria                 Fax:   ++43 732/2468-8585
E-Mail: alexander.puchmayr@jk.uni-linz.ac.at
