Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWGKJ0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWGKJ0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWGKJ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:26:55 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:37333 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750817AbWGKJ0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:26:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 1/2] swsusp: clean up browsing of pfns
Date: Tue, 11 Jul 2006 11:27:11 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200607102240.45365.rjw@sisk.pl> <20060711015941.d35f0b7d.akpm@osdl.org> <20060711090525.GE1787@elf.ucw.cz>
In-Reply-To: <20060711090525.GE1787@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607111127.11511.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 July 2006 11:05, Pavel Machek wrote:
> On Tue 2006-07-11 01:59:41, Andrew Morton wrote:
> > On Tue, 11 Jul 2006 10:34:15 +0200
> > Pavel Machek <pavel@ucw.cz> wrote:
> > 
> > > Hi!
> > > 
> > > > Clean up some loops over pfns for each zone in snapshot.c: reduce the number
> > > > of additions to perform, rework detection of saveable pages and make the code
> > > > a bit less difficult to understand, hopefully.
> > > 
> > > Also remove the BUG_ON() so that you can solve Andrew's monster
> > > machine problem.
> > 
> > I don't understand your comment.  I assume you're adding an explanation for
> > the removal of:
> > 
> > -	BUG_ON(PageReserved(page) && PageNosave(page));
> > 
> > from saveable_page().
> 
> Yes.
> 
> > But my emt64 test box is oopsing when touching a hole in the memory-map; it
> > isn't going BUG() (any more than usual ;))
> 
> Well, it would go BUG() with patch Rafael has somewhere on the
> disk. Next step is having pages both reserved and nosave, I believe.

Yes.

Rafael
