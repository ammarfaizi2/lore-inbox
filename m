Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWE1OFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWE1OFE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 10:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWE1OFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 10:05:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54711 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750756AbWE1OFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 10:05:02 -0400
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Christer Weinigel <christer@weinigel.se>, Nathan Laredo <laredo@gnu.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
In-Reply-To: <44799D24.7050301@gmail.com>
References: <m3wtc6ib0v.fsf@zoo.weinigel.se>  <44799D24.7050301@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 28 May 2006 11:04:47 -0300
Message-Id: <1148825088.1170.45.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1-2mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2006-05-28 às 14:52 +0159, Jiri Slaby escreveu:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 

> > For anyone submitting a new SAA7146 driver to the kernel in the
> > future, please be aware that your card isn't the only one that uses
> > that chip, so always add a subvendor/subdevice to your drivers.
The better is to use the existent driver instead of creating newer
ones. 
> The only difference is in order of searching for devices. Stradis now gets
> control before your "real" driver. Kick stradis from your config or blacklist
> it. 
This sucks. Distros should compile all drivers to support as much
hardware as possible. For now, it is better to implement Christer
suggestions.
> Or, why you ever load module, you don't want to use?
There's no safe way to make a driver to get control after the others, if
both are modules, so the option is to use the saa7146 driver instead of
stradis.
> There is no change in searching devices, it didn't check for subvendors before
> not even now. If Nathan knows, there are some subvendor/subdevices ids, which we
> should compare to, then yes, we can change the behaviour, otherwise, I am
> afraid, we can't. It's vendors' problem, that they don't use this pci registers
> (and it's evil) -- i think, that stradis cards have that two zeroed.
This is, in fact, a trouble on several video capture boards. A real
merge work should be done by migrating stradis to use the generic
support for SAA7146. Then, having just one board, those conflicts won't
happen.
> 
> regards,
> - --
> Jiri Slaby         www.fi.muni.cz/~xslaby

Cheers, 
Mauro.

