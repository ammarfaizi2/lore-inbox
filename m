Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbSL3PtZ>; Mon, 30 Dec 2002 10:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbSL3PtZ>; Mon, 30 Dec 2002 10:49:25 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:39616 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S266981AbSL3PtY>; Mon, 30 Dec 2002 10:49:24 -0500
Message-ID: <20021230155739.76748.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Luca z" <luca22@mail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 30 Dec 2002 10:57:39 -0500
Subject: 2-4-18 crash trying to blank a CD
X-Originating-Ip: 151.29.249.112
X-Originating-Server: ws1-11.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have this CD burner: Vendor: ARTEC Model: WRR-4848,
ide-scsi is loaded and it burns CDs fine, but it can't blank
them.

I do cdrecord -blank=<foo> dev=x,y,z
and i got this in the log, it repeats every second:

Dec 30 16:19:46 koala kernel: scsi : aborting command due to timeout : pid 5233
8, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 13 80 dd 00 00 01 00 
Dec 30 16:19:46 koala kernel: SCSI host 0 abort (pid 52338) timed out - resetti
ng

after a while:
Dec 30 16:32:47 koala kernel: SCSI bus is being reset for host 0 channel 0.
Dec 30 16:32:48 koala kernel: scsi : aborting command due to timeout : pid 5234
0, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
Dec 30 16:32:48 koala kernel: SCSI host 0 abort (pid 52340) timed out - resetti
ng

and after some time it hard freezes, nothing responds, i can't switch numlock
off and i can't change to console (i am in XWindow).

I can reproduce it every time, the kernel is from the kernel-image-2.4.18-686 debian package (sid).

I can provide more informations if you want. 

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Meet Singles
http://corp.mail.com/lavalife

