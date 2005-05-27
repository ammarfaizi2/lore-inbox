Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVE0O5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVE0O5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVE0O5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:57:47 -0400
Received: from brick.kernel.dk ([62.242.22.158]:45201 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261785AbVE0O5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:57:42 -0400
Date: Fri, 27 May 2005 16:58:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Resend: PATCH: Stop 2.6.12rc rmmod from being able to destroy CD hardware
Message-ID: <20050527145849.GY1435@suse.de>
References: <1117196287.5743.186.camel@localhost.localdomain> <Pine.LNX.4.58.0505270751420.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505270751420.17402@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27 2005, Linus Torvalds wrote:
> 
> 
> On Fri, 27 May 2005, Alan Cox wrote:
> > 
> > The simple fix is attached, making the driver start from ~0 and mask
> > bits the other direction would longer term be safer.
> 
> As per Bartlomiej, I've not applied this, since the "don't do it unless
> you've written to it" fix from Jens went in. I assume CD-RW's know how to
> cache flush..
> 
> That said, it does sound like the capabilities bitmap should be changed
> around to be the other way (either by starting at ~0, or, if the changes
> aren't too invasive, just change the semantics of it to be the sane way
> around ("drive can do this" rather than "drive can _not_ do this").

They should, it's always annoyed me because it's counter intuitive.

-- 
Jens Axboe

