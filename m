Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVAQIQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVAQIQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 03:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVAQIPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 03:15:07 -0500
Received: from canuck.infradead.org ([205.233.218.70]:21260 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262730AbVAQIOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 03:14:50 -0500
Subject: Re: permissions of /proc/tty/driver
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Viehmann <tv@beamnet.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050116222658.GA22364@lst.de>
References: <41E80535.1060309@beamnet.de> <20050116120436.GA13906@lst.de>
	 <1105908524.12196.13.camel@localhost.localdomain>
	 <20050116222658.GA22364@lst.de>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 09:14:36 +0100
Message-Id: <1105949676.6304.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 23:26 +0100, Christoph Hellwig wrote:
> On Sun, Jan 16, 2005 at 09:11:03PM +0000, Alan Cox wrote:
> > On Sul, 2005-01-16 at 12:04, Christoph Hellwig wrote:
> > > > (where /proc/tty/driver/serial is mentioned as leaking sensitive 
> > > > information), to me the contents of usbserial look innocent enough.
> > > > Do you have any hints on what might be a good solution?
> > > 
> > > The permissions on the directory look indeed too strict to me.  It might
> > > be better to just use strict permissions on /proc/tty/driver/serial
> > > indeed.
> > 
> > The file containts transmit and receive byte counts, which means you can
> > both measure intercharacter delay and character count. Thats a big help
> > to password guessers
> 
> I know.  But that doesn't explain why we don't keep strict permissions
> only on that file but on the directory.

ls -la on the file gives you the size maybe ?



