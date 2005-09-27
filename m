Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVI0NAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVI0NAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVI0NAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:00:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25021 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964920AbVI0NAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:00:01 -0400
Date: Tue, 27 Sep 2005 13:59:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, Harald Welte <laforge@gnumonks.org>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       vendor-sec@lst.de, security@linux.kernel.org
Subject: Re: [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050927125956.GA29861@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Harald Welte <laforge@gnumonks.org>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	vendor-sec@lst.de, security@linux.kernel.org
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <20050927080413.GA13149@kroah.com> <20050927124846.GA29649@infradead.org> <20050927125755.GA10738@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927125755.GA10738@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 05:57:55AM -0700, Greg KH wrote:
> Earlier in this thread, on these mailing lists.
> 
> I've included it below too.

Ah, it was last week and I missed it.  sorry.

This is more than messy.  usbfs is the only user of SI_ASYNCIO, and the
way it uses it is more than messy.  Why can't USB simply use the proper
AIO infrastructure?
