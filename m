Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbRAWLe6>; Tue, 23 Jan 2001 06:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbRAWLes>; Tue, 23 Jan 2001 06:34:48 -0500
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:54281 "HELO
	zmamail04.zma.compaq.com") by vger.kernel.org with SMTP
	id <S129944AbRAWLe3>; Tue, 23 Jan 2001 06:34:29 -0500
Message-ID: <E7D21F6C2128D41199B600508BCF8D54A9AD67@nosexc01.nwo.cpqcorp.net>
From: "Wahlman, Petter" <Petter.Wahlman@compaq.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Marking sectors on IDE drives as bad
Date: Tue, 23 Jan 2001 11:34:11 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm experiencing some fscking problems due to a defective IDE drive.

exerpt from /var/log/messages:
Jan 22 09:31:29 evil kernel: hda: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jan 22 09:31:29 evil kernel: hda: read_intr: error=0x01 { AddrMarkNotFound
}, LBAsect=10262250, sector=1311147
Jan 22 09:31:29 evil kernel: ide0: reset: success
Jan 22 09:31:29 evil kernel: hda: read_intr: status=0x59 { DriveReady
SeekComplete DataRequest Error }
Jan 22 09:31:29 evil kernel: hda: read_intr: error=0x40 { UncorrectableError
}, LBAsect=10262250, sector=1311147
Jan 22 09:31:29 evil kernel: end_request: I/O error, dev 03:05 (hda), sector
1311147

Is it possible to somehow mark the above sector as bad (in ll_rw_block.c or
similar) to circumvent the problem?


please CC to me, because i'm not on this list.


thanks


Petter Wahlman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
