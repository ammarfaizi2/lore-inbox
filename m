Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUIMNsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUIMNsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUIMNsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:48:46 -0400
Received: from aun.it.uu.se ([130.238.12.36]:12941 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266758AbUIMNso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:48:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16709.42267.116818.668199@alkaid.it.uu.se>
Date: Mon, 13 Sep 2004 15:48:11 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, drivers@neukum.org, marcelo.tosatti@cyclades.com,
       sailer@ife.ee.ethz.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.28-pre3] USB drivers gcc-3.4 fixes
In-Reply-To: <20040912204924.4a2cd872@lembas.zaitcev.lan>
References: <200409121129.i8CBT5Bo015222@harpo.it.uu.se>
	<20040912204924.4a2cd872@lembas.zaitcev.lan>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev writes:
 > How about this now?
 > 
 > -- Pete
 > 
 > diff -urp -X dontdiff linux-2.4.28-pre3/drivers/usb/audio.c linux-2.4.28-pre3-usb/drivers/usb/audio.c
 > --- linux-2.4.28-pre3/drivers/usb/audio.c	2004-08-24 12:38:50.000000000 -0700
 > +++ linux-2.4.28-pre3-usb/drivers/usb/audio.c	2004-09-12 17:49:35.000000000 -0700
 > @@ -593,9 +593,10 @@ static int dmabuf_mmap(struct dmabuf *db
 >  	return 0;
 >  }
 >  
 > -static void dmabuf_copyin(struct dmabuf *db, const void *buffer, unsigned int size)
 > +static void dmabuf_copyin(struct dmabuf *db, const void *_buffer, unsigned int size)
 >  {
 >  	unsigned int pgrem, rem;
 > +	const char *buffer = _buffer;

and more on the same theme.

Yeah, that's much nicer. Thanks.

Marcelo, please consider this patch instead of the one I sent.

/Mikael
