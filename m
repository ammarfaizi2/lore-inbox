Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWIDMeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWIDMeA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWIDMd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:33:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44551 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964860AbWIDMdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:33:50 -0400
Date: Sun, 3 Sep 2006 12:51:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
Message-ID: <20060903125111.GG4884@ucw.cz>
References: <44EFBEFA.2010707@student.ltu.se> <44F3952B.5000500@yahoo.com.au> <Pine.LNX.4.61.0608290754550.952@yvahk01.tjqt.qr> <200608302350.17150.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608302350.17150.dtor@insightbb.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I like it for the annotation we get.
> > 
> > 	int fluff;
> > 	if(fluff == 0)
> > 
> > This does not tell if fluff is an integer or a boolean (that is, what the
> > programmer intended to do -- not the 'int' the compiler sees).
> > If it had been if(!fluff), it would give a hint, but a lot of places also have
> > !x where x really is intended to be an integer (and should have been x==0 or
> > y==NULL resp.)
> >
> 
> Bool would not help much either unless declaration is immediately follows
> use. I like Alan Sterns proposal ofencode return value in function name
> better - actions should always return < 0/0 and predicates should always
> be boolean equivalent.

Sounds very reasonable. Even today, 90% of code follows that
convention. Perhaps adding it to codingstyle would help?

-- 
Thanks for all the (sleeping) penguins.

-- 
VGER BF report: H 0.254977
