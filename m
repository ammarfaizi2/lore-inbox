Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268155AbUH3QZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268155AbUH3QZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUH3QZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:25:42 -0400
Received: from the-village.bc.nu ([81.2.110.252]:26754 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268155AbUH3QZi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:25:38 -0400
Subject: Re: Problem accessing Sandisk CompactFlash Cards (Connected to the
	IDE bus)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc =?ISO-8859-1?Q?Str=E4mke?= <marcstraemke.work@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <cgvi5l$t0d$1@sea.gmane.org>
References: <cgs2c1$ccg$1@sea.gmane.org> <4131DC5D.8060408@redhat.com>
	 <cgsuq2$7cb$1@sea.gmane.org> <41326FE1.2050508@redhat.com>
	 <20040830010712.GC12313@logos.cnet> <cguj7n$gur$1@sea.gmane.org>
	 <41333879.2040902@redhat.com>  <cgvi5l$t0d$1@sea.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1093879414.30188.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 30 Aug 2004 16:23:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-30 at 16:49, Marc Strämke wrote:
> Both Cards, the old and the new on dont get to the ATAPI probing (which 
> seems correct to me, or is compactflash an ATAPI device???)

CF cards in IDE mode appear as ATA disk not ATAPI

> So the data the does return indeed marks it as an ATA harddisk, and not 
> as a compactflash card, the real question then is why doesnt it work as 
> a harddisk, which according to the specifications it should? Iam not 
> really experienced in the ide stuff, so iam not sure what the 
> CompactFlash detection in linux changes in behaviour.

It basically changes the removable drive behaviour. It could
also be useful for knowing when we need to be careful as
CF cards are both fragile and have some different commands.

What is the CF card connected to. One possibility is that
something after boot is powering the CF card off and on or
switching its mode before we see it.

