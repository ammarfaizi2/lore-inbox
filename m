Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVEKKzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVEKKzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 06:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVEKKzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 06:55:53 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:60079 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261958AbVEKKzr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 06:55:47 -0400
Subject: Re: [PATCH] bluetooth: kill redundant NULL checks and casts before
	kfree
From: Marcel Holtmann <marcel@holtmann.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, bluez-devel@lists.sf.net,
       Maxim Krasnyansky <maxk@qualcomm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0505102147190.2386@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505102100150.2386@dragon.hyggekrogen.localhost>
	 <200505102328.15734.adobriyan@mail.ru>
	 <Pine.LNX.4.62.0505102147190.2386@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Date: Wed, 11 May 2005 12:55:47 +0200
Message-Id: <1115808947.11503.34.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,

> > > There's no need to check for NULL before calling kfree() on a pointer, and
> > > since kfree() takes a void* argument there's no need to cast pointers to
> > > other types before passing them to kfree().
> > 
> > > +	kfree(hdev->driver_data)	
> > 
> > This won't compile.
> > 
> Ouch. You are right.
> I usually compile test patches, but I have to admit I didn't this time. 
> Sorry about that. Fixed patch below.

the hci_vhci.c change is not needed, because I have a pending update for
that driver that already fixes this. The other two hunks are in my tree
now.

Regards

Marcel


