Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318327AbSIIRy5>; Mon, 9 Sep 2002 13:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318734AbSIIRy5>; Mon, 9 Sep 2002 13:54:57 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:41733 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S318722AbSIIRyy>; Mon, 9 Sep 2002 13:54:54 -0400
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel & entropy: introducing video-entropyd
Date: Mon, 9 Sep 2002 20:02:16 +0200
Message-ID: <000901c2582b$09100cc0$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copy & paste from its webpage ( http://www.vanheusden.com/ved/ ):

video-entropyd
For security reasons (when doing network traffic or generating secure keys
for example) one wants as much entropy-data in the kernel random-driver as
possible. The random-driver takes partially care for this itself. But in
situations in where there's a lot of demand for entropy-data, it might not
be able to gather enough entropy-data by itself.
That's where this program is for: adding entropy-data to the kernel-driver.
It does that by fetching 2 images from a video4linux-device (with a random
delay in between), calculating the difference between those two and then
calculating the number of information-bits in that data. After that, the
data with the number-of-entropy-bits is submitted to the
kernel-random-driver.
After that, the program exits. That is because I am assuming you also want
to use your video4linux-device for other things. So run this program every
minute (or so) from crontab.
I tested this program with a Philips webcam.
http://www.vanheusden.com/ved/

You also might want to take a look at audio-entropyd:
http://www.mindrot.org/audio-entropyd.html


Folkert.

------------------------------------------------------------
Folkert van Heusden
Mobile phone: +31-6-41278122
Work e-mail address: f.v.heusden@ftr.nl
ICQ number: 105675015
PGP-key available on request
------------------------------------------------------------


