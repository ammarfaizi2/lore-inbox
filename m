Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbTL2Tko (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTL2Tko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:40:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:62630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263903AbTL2Tkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:40:36 -0500
Date: Mon, 29 Dec 2003 11:40:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
In-Reply-To: <3FF07BF3.2090500@pobox.com>
Message-ID: <Pine.LNX.4.58.0312291137021.2113@home.osdl.org>
References: <20031229183846.GI13481@actcom.co.il> <Pine.LNX.4.58.0312291049020.2113@home.osdl.org>
 <20031229185627.GJ13481@actcom.co.il> <3FF07BF3.2090500@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Jeff Garzik wrote:
> 
> Thirty separate patches is OK.
> 
> We have scripts to handle "patchbombs".

Yes and no.

Thirty separate patches make sense if they are independent and really do 
conceptually different things. Then it makes sense to have them as 
separate checkins, and be able to tell people "ok, try undoing that one, 
maybe that's the problem".

However, if they are all just "fix silly bugs in xxx", then I'd much 
rather see it as one big patch. Having it split up into "fix bug on line 
50" and "fix bug on line 75" just doesn't make any sense - it only makes 
the patch history harder to follow.

So "many small patches" aren't automatically any better than one big one. 
The thing that matters is to keep things _conceptually_ separated. If one 
patch fixes whitespace, and another one fixes bugs, then that's good.

		Linus
