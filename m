Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRAZKhR>; Fri, 26 Jan 2001 05:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130758AbRAZKhN>; Fri, 26 Jan 2001 05:37:13 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:41488 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S129184AbRAZKhD>; Fri, 26 Jan 2001 05:37:03 -0500
Message-ID: <E7D21F6C2128D41199B600508BCF8D54A9AD69@nosexc01.nwo.cpqcorp.net>
From: "Wahlman, Petter" <Petter.Wahlman@compaq.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'Andre Hedrick'" <andre@linux-ide.org>,
        "'Mark Hahn'" <hahn@coffee.psychology.mcmaster.ca>,
        "'Andreas Dilger'" <adilger@turbolinux.com>
Subject: RE: Marking sectors on IDE drives as bad
Date: Fri, 26 Jan 2001 10:36:41 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem still persist, even after marking the respective block with:
badblocks -n -o /var/log/badblocks,
and e2fsck -l /var/log/badblocks

the corrupted block is:
dumpe2fs -b /dev/hda5
dumpe2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
655573

fsck is forced at boot, with the previously mentioned error: 

Jan 26 10:32:37 evil kernel: hda: read_intr: error=0x01 { AddrMarkNotFound
}, LBAsect=10262250, sector=1311147
Jan 26 10:32:37 evil kernel: ide0: reset: success
Jan 26 10:32:37 evil kernel: hda: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jan 26 10:32:37 evil kernel: hda: read_intr: error=0x01 { AddrMarkNotFound
}, LBAsect=10262250, sector=1311147
Jan 26 10:32:37 evil kernel: end_request: I/O error, dev 03:05 (hda), sector
1311147



Petter Wahlman


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
