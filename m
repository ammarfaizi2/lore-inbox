Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132406AbRCZKYc>; Mon, 26 Mar 2001 05:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132405AbRCZKYM>; Mon, 26 Mar 2001 05:24:12 -0500
Received: from [210.220.245.88] ([210.220.245.88]:3456 "HELO kernel.pe.kr")
	by vger.kernel.org with SMTP id <S132400AbRCZKYJ> convert rfc822-to-8bit;
	Mon, 26 Mar 2001 05:24:09 -0500
Date: Mon, 26 Mar 2001 19:22:07 +0900 (KST)
From: Chung Won-young <suni00@kernel.pe.kr>
To: <ankry@green.mif.pg.gda.pl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Can't compile 2.4.2-ac25
In-Reply-To: <200103260931.LAA10016@sunrise.pg.gda.pl>
Message-ID: <Pine.LNX.4.31.0103261920460.907-100000@pain.kernel.pe.kr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=euc-kr
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry...

Try this:

--- es1370.orig	Mon Mar 26 18:15:06 2001
+++ es1370.c	Mon Mar 26 17:47:54 2001
@@ -170,6 +170,8 @@
 struct gameport {
 	int io;
 	int size;
+	void (*trigger)(struct gameport *);
+	unsigned char (*read)(struct gameport *);
 };

 extern inline void gameport_register_port(struct gameport *gameport)


- ÆóÀÎ -

ICQ : 36602496
E - Mail : suni00@kernel.pe.kr, suni00@kldp.org
Homepage : http://kernel.pe.kr, http://pain.kernel.pe.kr

On Mon, 26 Mar 2001, Andrzej Krzysztofowicz wrote:

> "Chung Won-young wrote:"
> > Try this:
> >
> > --- es1370.orig Mon Mar 26 18:15:06 2001
> > +++ es1370.c    Mon Mar 26 17:47:54 2001
> > @@ -170,6 +170,8 @@
> >  struct gameport {
> >          int io;
> >                  int size;
> >                  +       void (*trigger)(struct gameport *);
> >                  +       unsigned char (*read)(struct gameport *);
> >                   };
> >
> >                     extern inline void gameport_register_port(struct gameport *gameport)
>
>
> Looks strange...
> gpm's copy & paste + joe ?
> :)
>
>

