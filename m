Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVAPWbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVAPWbP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVAPW1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:27:43 -0500
Received: from verein.lst.de ([213.95.11.210]:9196 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262631AbVAPW1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:27:01 -0500
Date: Sun, 16 Jan 2005 23:26:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas Viehmann <tv@beamnet.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: permissions of /proc/tty/driver
Message-ID: <20050116222658.GA22364@lst.de>
References: <41E80535.1060309@beamnet.de> <20050116120436.GA13906@lst.de> <1105908524.12196.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105908524.12196.13.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 09:11:03PM +0000, Alan Cox wrote:
> On Sul, 2005-01-16 at 12:04, Christoph Hellwig wrote:
> > > (where /proc/tty/driver/serial is mentioned as leaking sensitive 
> > > information), to me the contents of usbserial look innocent enough.
> > > Do you have any hints on what might be a good solution?
> > 
> > The permissions on the directory look indeed too strict to me.  It might
> > be better to just use strict permissions on /proc/tty/driver/serial
> > indeed.
> 
> The file containts transmit and receive byte counts, which means you can
> both measure intercharacter delay and character count. Thats a big help
> to password guessers

I know.  But that doesn't explain why we don't keep strict permissions
only on that file but on the directory.

