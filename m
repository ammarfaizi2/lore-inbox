Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129973AbRCERaS>; Mon, 5 Mar 2001 12:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbRCER36>; Mon, 5 Mar 2001 12:29:58 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:31000 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129998AbRCER3z>;
	Mon, 5 Mar 2001 12:29:55 -0500
Message-ID: <3AA3CC99.5549C6B2@sgi.com>
Date: Mon, 05 Mar 2001 09:27:53 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Annoying CD-rom driver error messages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a music play program (freeamp) playing MP3's running.  It has the
feature in that it scans to see if a CD is in the drive and tries to look it up
in CDDB.  Well, I don't have a CD in the drive -- I have a DVD-ROM with UDF file
system on it.  Freeamp doesn't complain, but in my syslog/warnings file, every 5 seconds
I get:

Mar  5 09:17:00 xena kernel: hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
Mar  5 09:17:00 xena kernel: hdc: packet command error: error=0x50
Mar  5 09:17:00 xena kernel: ATAPI device hdc:
Mar  5 09:17:00 xena kernel:   Error: Illegal request -- (Sense key=0x05)
Mar  5 09:17:00 xena kernel:   Cannot read medium - incompatible format -- (asc=0x30, ascq=0x02)
Mar  5 09:17:00 xena kernel:   The failed "Read Subchannel" packet command was:
Mar  5 09:17:00 xena kernel:   "42 02 40 01 00 00 00 00 10 00 00 00 "
----
Needless to say, this fills up messages/warnings fairly quickly.  If there's no
DVD in the drive or if there is a CD in the drive, I don't notice this problem.

Seems like a undesirable feature for the kernel to write out 7-line error messages
everytime a program polls for a CD and fails.  Is there a way to disable this when I
have a DVD ROM disk in the drive? (vanilla 2.4.2 kernel).

Thanks...
-l


-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
