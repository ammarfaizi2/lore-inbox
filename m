Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129555AbRCAIyj>; Thu, 1 Mar 2001 03:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129554AbRCAIya>; Thu, 1 Mar 2001 03:54:30 -0500
Received: from smtp.kpnqwest.com ([193.242.92.8]:6660 "EHLO ntexgswp02.DMZ")
	by vger.kernel.org with ESMTP id <S129552AbRCAIyP>;
	Thu, 1 Mar 2001 03:54:15 -0500
Message-ID: <5F6171E541C8D311B9F200508B63D3280111CAAA@ntexgvie01>
From: "Bene, Martin" <Martin.Bene@KPNQwest.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Performance Problem w/fragmented packets on load-balanced link
Date: Thu, 1 Mar 2001 09:54:10 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

Hi, 

I'm running into performance problems with big (=fragmented) packets;
both endpoints are running kernel 2.2.18+Andreas VM patch. The
systems involved are each connected to the internet using 128kBit
leased lines. Network throughput drops from about 12/13kBytes/sec
using smaller packets to something like 5kByte if fragmentation is
needed.

There's one unusual aspect to the connection: on one side, the
128kbit link is actually two seperate 64kbit links with load
balancing over them. Load balancing is done using cisco routers. This
in turn gives funnies with packets/fragments arriving NOT in the
order they were sent.

                      /--- line 1 ---\
Inet---Cisco-provider                 cisco cust.--- linux box
                      \--- line 2 ---/

Has anyone seen such effects under similar conditions? any idea if
something can be done?

Thanks, Martin Bene
PS: Sorry for the previous empty message - tripped over the send
button.

-----BEGIN PGP SIGNATURE-----
Version: PGP Personal Privacy 6.5.8

iQCVAwUBOp3/cR+NBGYktXFhAQGQrAP8D5UmwHzoR6ITeYmsuLgY3igZj5qZ7Tnp
qU498XlF0q5hr3ThBPsO7uxrccyOOGGpvG8OXluTVZZCeROb0SKirNC5Nk4zI+bm
4eKzf7HnSgrKLeqAxj1K9m96uevSZefVbVLlhtAo2XAPWNQ4Uvt6a/+F3PGCyCS+
kzdcIi93DRM=
=nkw9
-----END PGP SIGNATURE-----
