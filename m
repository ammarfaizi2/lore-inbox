Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUIPXPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUIPXPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268351AbUIPXI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:08:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:64441 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268329AbUIPXHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:07:51 -0400
Date: Thu, 16 Sep 2004 16:07:13 -0700
From: Greg KH <greg@kroah.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 2/2
Message-ID: <20040916230713.GA16403@kroah.com>
References: <1095332331.3855.161.camel@laptop.cunninghams> <20040916142847.GA32352@kroah.com> <1095373127.5897.23.camel@laptop.cunninghams> <20040916223539.GA16151@kroah.com> <1095374947.6537.34.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095374947.6537.34.camel@laptop.cunninghams>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 08:49:07AM +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2004-09-17 at 08:35, Greg KH wrote:
> > > > Ick, no.  I've been over this before with the fb people, and am not going
> > > > to accept this patch (nevermind that it's broken...)  See the lkml
> > > > archives for more info on why I don't like this.
> > > 
> > > Please excuse my ignorance but I don't see how it's broken
> > 
> > This function, as written is very broken.  I will not accept it.  Not to
> 
> What's broken? (I want to learn what I've done wrong that I'm not
> seeing).

 - No locking when traversing the list.
 - Reference count needs to be bumped before returning a pointer to the
   object you found.

> > mention the fact that the functionality this function proposes to offer
> > is not needed either.
> > 
> > > (their patch just fills in a field that was left blank previously),
> > 
> > What patch?
> 
> Attached. Sorry if I wrongly assumed this was the patch you're talking
> about.

Ah, no, I've never seen this one, thanks.  But it looks sane, I don't
have a problem with it (sysfs will like it, it's not a suspend specific
patch at all.)

thanks,

greg k-h
