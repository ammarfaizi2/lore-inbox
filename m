Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVCYN5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVCYN5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 08:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCYN5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 08:57:25 -0500
Received: from mail.dif.dk ([193.138.115.101]:34947 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261320AbVCYN5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 08:57:21 -0500
Date: Fri, 25 Mar 2005 14:59:14 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
In-Reply-To: <424324E4.9000003@zytor.com>
Message-ID: <Pine.LNX.4.62.0503251444060.2498@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
 <20050323174925.GA3272@zero> <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
 <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com> <d1v67l$4dv$1@terminus.zytor.com>
 <3e74c9409b6e383b7b398fe919418d54@mac.com> <424324E4.9000003@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005, H. Peter Anvin wrote:

> Kyle Moffett wrote:
> > 
> > IMHO, this is one of those cases where "Be liberal in what you accept
> > and strict in what you emit" applies strongly.  New filesystems should
> > probably always emit "." and ".." in that order with sane behavior,
> > and new programs should probably be able to handle it if they don't. I
> > would add ".." and "." to squashfs, just so that it acts like the rest
> > of the filesystems on the planet, even if it has to emulate them
> > internally.  OTOH, I think that the default behavior of find is broken
> > and should probably be fixed, maybe by making the default use the full
> > readdir and optionally allowing a -fast option that optimizes the
> > search using such tricks.
> > 
> 
> Note that Linux always accepts . and .. so it's just a matter of making them
> appear in readdir.
> 
I'm working on that, but it's a learning experience for me, so it's going 
a bit slow - but I'll get there.

-- 
Jesper Juhl


