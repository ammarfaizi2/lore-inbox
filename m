Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLYK64>; Mon, 25 Dec 2000 05:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLYK6r>; Mon, 25 Dec 2000 05:58:47 -0500
Received: from f1j.dsl.xmission.com ([166.70.20.140]:43322 "EHLO
	f1j.dsl.xmission.com") by vger.kernel.org with ESMTP
	id <S129228AbQLYK6e>; Mon, 25 Dec 2000 05:58:34 -0500
Message-ID: <3A47212D.F9F119C3@xmission.com>
Date: Mon, 25 Dec 2000 03:27:57 -0700
From: Frank Jacobberger <f1j@xmission.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: test13-pre4... udf problem with dvd access vs test12
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Odd happening here. Been running good as gold through test12 with
accessing my dvd to using oms. Now updating to test13-pre4
I get a complete lock up of my whole system when executing oms.

I can access the drive via mounting it... with no trouble what ever.

Here is a snip from my message file.... No clue what to test for here...

Perhaps udf.c is the problem?

Any ideas?

Merry Christmas

Frank





Dec 25 02:02:13 f1j kernel: hdf: packet command error: status=0x51 {
DriveReady SeekComplete Error }
Dec 25 02:02:13 f1j kernel: hdf: packet command error: error=0x00
Dec 25 02:02:13 f1j kernel: ATAPI device hdf:
Dec 25 02:02:13 f1j kernel:   Error: No sense data -- (Sense key=0x00)
Dec 25 02:02:13 f1j kernel:   No additional sense information --
(asc=0x00, ascq=0x00)
Dec 25 02:02:13 f1j kernel:   The failed "Report Key" packet command
was:
Dec 25 02:02:13 f1j kernel:   "a4 00 00 00 00 00 00 00 00 0c c4 00 "
Dec 25 02:02:14 f1j kernel: hdf: command error: status=0x51 { DriveReady
SeekComplete Error }
Dec 25 02:02:14 f1j kernel: hdf: command error: error=0x50
Dec 25 02:02:14 f1j kernel: end_request: I/O error, dev 21:40 (hdf),
sector 1148
Dec 25 02:02:14 f1j kernel: ATAPI device hdf:
Dec 25 02:02:14 f1j kernel:   Error: Illegal request -- (Sense key=0x05)

Dec 25 02:02:14 f1j kernel:   Read of scrambled sector without
authentication -- (asc=0x6f, ascq=0x03)
Dec 25 02:02:14 f1j kernel: hdf: command error: status=0x51 { DriveReady
SeekComplete Error }
Dec 25 02:02:14 f1j kernel: hdf: command error: error=0x50
Dec 25 02:02:14 f1j kernel: ATAPI device hdf:
Dec 25 02:02:14 f1j kernel:   Error: Illegal request -- (Sense key=0x05)

Dec 25 02:02:14 f1j kernel:   Read of scrambled sector without
authentication -- (asc=0x6f, ascq=0x03)
Dec 25 02:02:14 f1j kernel: hdf: command error: status=0x51 { DriveReady
SeekComplete Error }
Dec 25 02:02:14 f1j kernel: hdf: command error: error=0x50
Dec 25 02:02:14 f1j kernel: end_request: I/O error, dev 21:40 (hdf),
sector 1152
Dec 25 02:02:14 f1j kernel: ATAPI device hdf:
Dec 25 02:02:14 f1j kernel:   Error: Illegal request -- (Sense key=0x05)

Dec 25 02:02:14 f1j kernel:   Read of scrambled sector without
authentication -- (asc=0x6f, ascq=0x03)
Dec 25 02:02:14 f1j kernel: hdf: command error: status=0x51 { DriveReady
SeekComplete Error }
Dec 25 02:02:14 f1j kernel: hdf: command error: error=0x50
Dec 25 02:02:14 f1j kernel: end_request: I/O error, dev 21:40 (hdf),
sector 1153
Dec 25 02:02:14 f1j kernel: ATAPI device hdf:
Dec 25 02:02:14 f1j kernel:   Error: Illegal request -- (Sense key=0x05)

Dec 25 02:02:14 f1j kernel:   Read of scrambled sector without
authentication -- (asc=0x6f, ascq=0x03)
Dec 25 02:02:14 f1j kernel: hdf: command error: status=0x51 { DriveReady
SeekComplete Error }
Dec 25 02:02:14 f1j kernel: hdf: command error: error=0x50
Dec 25 02:02:14 f1j kernel: end_request: I/O error, dev 21:40 (hdf),
sector 1154
Dec 25 02:02:14 f1j kernel: ATAPI device hdf:
Dec 25 02:02:14 f1j kernel:   Error: Illegal request -- (Sense key=0x05)

Dec 25 02:02:14 f1j kernel:   Read of scrambled sector without
authentication -- (asc=0x6f, ascq=0x03)
Dec 25 02:02:14 f1j kernel: hdf: command error: status=0x51 { DriveReady
SeekComplete Error }
Dec 25 02:02:14 f1j kernel: hdf: command error: error=0x50
Dec 25 02:02:14 f1j kernel: end_request: I/O error, dev 21:40 (hdf),
sector 1155
Dec 25 02:02:14 f1j kernel: ATAPI device hdf:
Dec 25 02:02:14 f1j kernel:   Error: Illegal request -- (Sense key=0x05)

Dec 25 02:02:14 f1j kernel:   Read of scrambled sector without
authentication -- (asc=0x6f, ascq=0x03)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
