Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWCUO7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWCUO7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWCUO7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:59:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8090 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751758AbWCUO7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:59:49 -0500
Subject: Re: [linux-usb-devel] RE: [usb-storage] Re: [v4l-dvb-maintainer]
	2.6.16-rc: saa7134 + u sb-storage = freeze
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: t.schorpp@gmx.de
Cc: Alan Stern <stern@rowland.harvard.edu>,
       "Ballentine, Casey" <crballentine@essvote.com>,
       video4linux-list@redhat.com, linux-usb-devel@lists.sourceforge.net,
       usb-storage@lists.one-eyed-alien.net, v4l-dvb-maintainer@linuxtv.org,
       mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <441F281E.5060405@gmx.de>
References: <Pine.LNX.4.44L0.0603161039410.5253-100000@iolanthe.rowland.org>
	 <441F281E.5060405@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 21 Mar 2006 11:59:09 -0300
Message-Id: <1142953149.4749.21.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
Em Seg, 2006-03-20 às 23:09 +0100, thomas schorpp escreveu:
> Alan Stern wrote:
> > On Wed, 15 Mar 2006, Ballentine, Casey wrote:

> what DMA problem? ive always used via chipsets with usb. now the 8237. 

> the via pci-busmaster dma hangs the system?
No. it is PCI to PCI transfers ocurring while you have DMA transfers.

Video capture boards allow you to transfer information from his capture
memory to video memory without CPU. The problem is that some chipsets
(or BIOS) can't handle concurrency between such transfers and normal PCI
busmaster transfers.
> 
>  try setting pci latency to 64.
> most bioses initialize with 32. this had been a known problem, for me too.
> this has been left out of the discussion at via forums.
> 
> and what knows a usb controller about MPEG? thats another layer.
> 
> so a bios fixes this and other os have no problem with this, 
> so its fixable by software. then do it now, pls.
If you have such a fix, great, but while we don't have it, it is better
to blacklist pci2pci transfers (there are other supported methods that
are a little slow, but works as well as), than to offer a risk of mass
corruption at their disks.

Btw, are you sure that other OS offers pci2pci transfers for those
devices/chipsets?

> and stop this "blacklisting habit", all these nowadays chips are designed-to-cost 
> "consumer crap" somewhow.
> or do you want linux-usb to be blacklisted as "broken" by the manufacturers blacklists? ;)
> 
> 
> y
> tom
> 
Cheers, 
Mauro.

