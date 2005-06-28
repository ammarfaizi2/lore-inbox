Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVF1Dqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVF1Dqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 23:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVF1Dqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 23:46:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:43956 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262499AbVF1Dqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 23:46:36 -0400
Date: Mon, 27 Jun 2005 20:46:14 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628034614.GA306@kroah.com>
References: <20050624081808.GA26174@kroah.com> <200506270819.20108.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506270819.20108.arnd@arndb.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 08:19:19AM +0200, Arnd Bergmann wrote:
> On Freedag 24 Juni 2005 10:18, Greg KH wrote:
> > +
> > +??????????????list_for_each_entry(entry, &entries, node) {
> > +??????????????????????????????if (strcmp(name, &entry->name[0]) == 0) {
> > +??????????????????????????????????????????????dentry = entry->dentry;
> > +??????????????????????????????????????????????break;
> > +??????????????????????????????}
> > +??????????????}
> 
> This list search looks like it is missing a mutex around it,

Yes.

> and the elements of the list never get freed properly.

Yeah, I noticed that after I posted it.

I was at the end of my self-imposed, "I'm only giving myself 3 hours for
this", and didn't want to touch it anymore :)

> Is it possible to use lookup_one_len() instead? That should
> make it possible not to use an extra list of entries at all.

Yeah, I originally tried a different function from namei.c, but getting
the mount point was a bit messy at the moment.

I'll take some time later this week and fix this up and post it one more
time for anyone else to use.

But remember, I'll be posting it, and not asking for it to be accepted,
as I was wrong.  devfs is not needed, it's wrong, and will be removed
from the kernel.  But more about that later...

thanks,

greg k-h
