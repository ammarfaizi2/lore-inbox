Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUAVEZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 23:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUAVEZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 23:25:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:34572 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263653AbUAVEZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 23:25:42 -0500
Date: Thu, 22 Jan 2004 05:29:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: modular ide + fixed legacy/ppc doesn't work when non modular on ppc
Message-ID: <20040122042951.GB2210@mars.ravnborg.org>
Mail-Followup-To: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-kernel@vger.kernel.org
References: <200401212354.45957.arekm@pld-linux.org> <200401220015.21827.bzolnier@elka.pw.edu.pl> <200401220025.07135.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401220025.07135.arekm@pld-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 12:25:07AM +0100, Arkadiusz Miskiewicz wrote:
> Dnia czw 22. stycznia 2004 00:15, Bartlomiej Zolnierkiewicz napisa?:
> > Thanks, I have alternative fix.
> >
> > --- linux/drivers/ide/ppc/pmac.c.orig	2004-01-09 07:59:08.000000000 +0100
> > +++ linux/drivers/ide/ppc/pmac.c	2004-01-22 00:10:11.550746088 +0100
> > @@ -46,7 +46,7 @@
> >  #include <asm/sections.h>
> >  #include <asm/irq.h>
> >
> > -#include "ide-timing.h"
> > +#include "../ide-timing.h"

Please don't do that. It is much better to tell cc where to look,
instead of this.
So please use the solutin posted by Arkadiusz.

When using seperate output directory with kbuild the latter makes
life much easier.

	Sam
