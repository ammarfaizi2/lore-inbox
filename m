Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269257AbRHLOqd>; Sun, 12 Aug 2001 10:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269261AbRHLOqX>; Sun, 12 Aug 2001 10:46:23 -0400
Received: from ns.skjellin.no ([193.69.71.66]:3266 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id <S269257AbRHLOqL>;
	Sun, 12 Aug 2001 10:46:11 -0400
Message-ID: <000f01c1233d$8bbb2700$8405000a@slurv>
From: "Andre Tomt" <andre@tomt.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Max Schattauer" <smax@smaximum.de>
In-Reply-To: <3B769CA4.11035.A9DFE2@localhost>
Subject: Re: tun device: File descriptor in bad state(77)
Date: Sun, 12 Aug 2001 16:46:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2526.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2526.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi there!
>
> I graded up from kernel 2.4.5 to 2.4.8 and now have trouble with
> vtund 2.5b1 and tun 1.1.
>
> vtund[532]: Session st_sm[217.230.44.100:1577] opened
> vtund[532]: Can't allocate tun device. File descriptor in bad state(77)
> vtund[532]: Session st_sm closed

Try using the included tun 1.4 thats in the kernel source. Vtund might need
a small patch to work, I'm not sure about your version. Look at this patch:
http://www.sannes.org/secnet/secnet-1.0d-linux-2.4.diff

It should apply on vtund 2.4 at least (secnetd is just a different "version"
of vtund with stronger encryption and some bugfixes). If it does not apply,
try readning it and see what it does (it's nothing big, two additions of
#includes.)

--
Regards,
André Tomt
andre@tomt.net

