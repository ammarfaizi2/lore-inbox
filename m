Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135617AbRD1Tvl>; Sat, 28 Apr 2001 15:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135618AbRD1Tvc>; Sat, 28 Apr 2001 15:51:32 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:39075 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S135617AbRD1TvU>; Sat, 28 Apr 2001 15:51:20 -0400
From: "Ronald Bultje" <rbultje@ronald.bitfreak.net>
To: "Byeong-ryeol Kim" <jinbo21@hananet.net>, <linux-kernel@vger.kernel.org>
Subject: RE: buz.c of 2.4.4
Date: Sat, 28 Apr 2001 21:56:32 +0200
Message-ID: <CDEJIPDFCLGDNEHGCAJPGEGFCAAA.rbultje@ronald.bitfreak.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.33.0104290210480.581-100000@progress.plw.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>I met follwing erros which was workarounded by put
>define KMALLOC_MAXSIZE	131072
>borrowed from af_unix.c of 2.4.3-ac14. But I'm convinced of
>this.
>below lines were wrapped by me for readabilities' sake.

my fix in an earlier e-mail to the list explained that the
proper way of fixing it is indeed to add the line.
#define KMALLOC_MAXSIZE (1024*128)

But in case you're actually going to _use_ this module, i.e.
you have a buz card, then please use the unified zoran driver
by Serguei Miridonov instead.
You can find more information about this driver on:
http://www.cicese.mx/~mirsev/Linux/DC10plus or
http://mjpeg.sourceforge.net/ (also for our mailinglists)
The old driver is (doh!) old and unmaintained. Might have
some bugs slipped into it since there is no maintainance done
anymore. The new driver is actively being maintained and
capturing software from our project is optimized for the new
driver (though the old one should still work).

--
Ronald Bultje
