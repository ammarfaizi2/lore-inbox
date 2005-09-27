Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbVI0Msw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVI0Msw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVI0Msw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:48:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11470 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964912AbVI0Msw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:48:52 -0400
Date: Tue, 27 Sep 2005 13:48:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Harald Welte <laforge@gnumonks.org>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, vendor-sec@lst.de
Subject: Re: [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050927124846.GA29649@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Harald Welte <laforge@gnumonks.org>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	vendor-sec@lst.de
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <20050927080413.GA13149@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927080413.GA13149@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 01:04:15AM -0700, Greg KH wrote:
> First off, thanks for providing a patch for this problem, it is real,
> and has been known for a while (thanks to your debugging :)
> 
> On Sun, Sep 25, 2005 at 05:13:30PM +0200, Harald Welte wrote:
> > 
> > I suggest this (or any other) fix to be applied to both 2.6.14 final and
> > the stable series.  I didn't yet investigate 2.4.x, but I think it is
> > likely to have the same problem.
> 
> I agree, but I think we need an EXPORT_SYMBOL_GPL() for your newly
> exported symbol, otherwise the kernel will not build if you have USB
> built as a module.

Where's the actual patch?  And no, we certainly shouldn't export anything
to put a task_struct.

