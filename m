Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbULJQFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbULJQFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbULJQEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:04:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:24298 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261750AbULJQCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:02:49 -0500
Date: Fri, 10 Dec 2004 08:02:24 -0800
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] debugfs - yet another in-kernel file system
Message-ID: <20041210160224.GA6714@kroah.com>
References: <20041210005055.GA17822@kroah.com> <Pine.LNX.4.53.0412100805440.8273@yvahk01.tjqt.qr> <20041210075429.GA30223@kroah.com> <Pine.LNX.4.53.0412100859210.15980@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0412100859210.15980@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 09:00:22AM +0100, Jan Engelhardt wrote:
> >> I have to admit that adding another filesystem that is very like procfs or
> >> sysfs make some kind of redundancy.
> >
> >Why?  The main issue is the discussion usually goes like this:
> >
> >Me:  Hey, the /proc/driver/foo/foo_value really shouldn't be in proc.
> >Developer:  Ok, but it has a lot of really good debug stuff in it.  Can
> >I put it in sysfs?
> >Me:  No, sysfs is for one-value-per-file whenever possible.  It needs to
> >go somewhere else.
> >Developer:  Well, if you don't have anywhere else to put it, why are you
> >even bringing this up at all.  Go away and leave me alone.
> 
> So how about adding seqfiles (or multi-value-per-file things) to sysfs?

No, that is not going to happen, as it is directly opposite to how sysfs
is supposed to work (one _single_ value per file).

thanks,

greg k-h
