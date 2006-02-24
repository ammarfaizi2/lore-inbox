Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWBXQ4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWBXQ4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWBXQ4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:56:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63155 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750912AbWBXQ4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:56:53 -0500
Date: Fri, 24 Feb 2006 16:56:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: erich <erich@areca.com.tw>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, billion.wu@areca.com.tw, akpm@osdl.org,
       oliver@neukum.org
Subject: Re: Areca RAID driver remaining items?
Message-ID: <20060224165647.GA4176@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, erich <erich@areca.com.tw>,
	Arjan van de Ven <arjan@infradead.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, billion.wu@areca.com.tw,
	akpm@osdl.org, oliver@neukum.org
References: <1140458552.3495.26.camel@mentorng.gurulabs.com> <20060220182045.GA1634@infradead.org> <001401c63779$12e49aa0$b100a8c0@erich2003> <20060222145733.GC16269@infradead.org> <00dc01c63842$381f9a30$b100a8c0@erich2003> <1140683157.2972.6.camel@laptopd505.fenrus.org> <001901c6385e$9aee7d40$b100a8c0@erich2003> <1140695990.19361.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140695990.19361.8.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 11:59:50AM +0000, Alan Cox wrote:
> On Iau, 2006-02-23 at 17:50 +0800, erich wrote:
> > But unfortunately I found some mainboards will hang up if I always enable 
> > this function in my lab.
> > To avoid this issue, I do an option for this case.
> > 
> > But  Christoph Hellwig give me comment with it.
> 
> 
> Another thing you can also do for many of these cases is to use either
> the PCI or DMI interfaces to identify the problem board and
> automatically set the option as well.
> 
> There are two ways to do this. One is 

Please avoid that unless really nessecary.  I doubt there's boards where
MSI would only be broken with the areca card but not with other MSI-capable
ones.  If a board or chipset is generally broken vs MSI it should be
added to the global MSI blacklist.  It's probably be nice to have a global
nomsi boot option instead of one in every driver aswell..

