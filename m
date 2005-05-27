Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVE0Owx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVE0Owx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVE0Owx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:52:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:28544 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261781AbVE0Ows (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:52:48 -0400
Date: Fri, 27 May 2005 07:54:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Resend: PATCH: Stop 2.6.12rc rmmod from being able to destroy
 CD hardware
In-Reply-To: <1117196287.5743.186.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0505270751420.17402@ppc970.osdl.org>
References: <1117196287.5743.186.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 May 2005, Alan Cox wrote:
> 
> The simple fix is attached, making the driver start from ~0 and mask
> bits the other direction would longer term be safer.

As per Bartlomiej, I've not applied this, since the "don't do it unless
you've written to it" fix from Jens went in. I assume CD-RW's know how to
cache flush..

That said, it does sound like the capabilities bitmap should be changed
around to be the other way (either by starting at ~0, or, if the changes
aren't too invasive, just change the semantics of it to be the sane way
around ("drive can do this" rather than "drive can _not_ do this").

		Linus
