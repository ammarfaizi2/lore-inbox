Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVLDAgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVLDAgX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVLDAgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:36:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36248 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932188AbVLDAgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:36:22 -0500
Date: Sun, 4 Dec 2005 01:35:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Isaacson <adi@hexapodia.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][mm][Fix] swsusp: fix counting of highmem pages
Message-ID: <20051204003546.GF5198@elf.ucw.cz>
References: <200512032140.15192.rjw@sisk.pl> <200512040102.24668.rjw@sisk.pl> <20051204001055.GE5198@elf.ucw.cz> <200512040126.14048.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512040126.14048.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  		}
> > > +	if (n > 0)
> > > +		n += (n * KMALLOC_SIZE + PAGE_SIZE - 1) / PAGE_SIZE + 1;
> > >  	return n;
> > >  }
> > 
> > Can't you just n += n/50 here? Playing with KMALLOC_SIZE knows way too
> > much about memory allocation details.
> 
> I do the "n + n/50" later on, so I can just drop all of the above changes
> if they are too complicated.

Yes, that would be nice.
								Pavel
-- 
Thanks, Sharp!
