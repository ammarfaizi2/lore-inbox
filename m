Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRABQxH>; Tue, 2 Jan 2001 11:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRABQw6>; Tue, 2 Jan 2001 11:52:58 -0500
Received: from bretweir.total.net ([154.11.89.176]:58367 "HELO
	smtp.interlog.com") by vger.kernel.org with SMTP id <S129431AbRABQwq>;
	Tue, 2 Jan 2001 11:52:46 -0500
Message-ID: <3A51FF83.E8B5151A@interlog.com>
Date: Tue, 02 Jan 2001 11:19:15 -0500
From: Douglas Gilbert <dgilbert@interlog.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test13-pre7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: devices.txt inconsistency
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While on this subject, the description of raw devices
(char 162) in lk 2.4 is not consistent with current 
usage.

devices.txt contains this:
162 char        Raw block device interface
                  0 = /dev/raw          Raw I/O control device
                  1 = /dev/raw1         First raw I/O device
                  2 = /dev/raw2         Second raw I/O device
                    ...

but something like this would be more accurate:
162 char        Raw block device interface
                  0 = /dev/rawctl       Raw I/O control device
                  1 = /dev/raw/raw1     First raw I/O device
                  2 = /dev/raw/raw2     Second raw I/O device
                    ...

The raw(8) command supplied in RH 6.2 and 7.0 assumes the
latter structure. I have already alerted sct and this 
change may be coming through in one of his patches.

Doug Gilbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
