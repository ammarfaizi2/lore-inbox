Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbUCLX2d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbUCLX2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:28:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:27371 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263035AbUCLX0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:26:01 -0500
Date: Fri, 12 Mar 2004 15:20:44 -0800
From: Greg KH <greg@kroah.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] cdev 1/2: Eliminate /sys/cdev
Message-ID: <20040312232043.GA16623@kroah.com>
References: <20040312183256.1331.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312183256.1331.qmail@lwn.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 11:32:56AM -0700, Jonathan Corbet wrote:
> This is the first of two patches designed to make life easier for authors
> of device driver books - and, with luck, driver authors too.
> 
> /sys/cdev is, according to Al, a mistake which was never really meant to
> exist.  I believe nothing uses it currently - there isn't a whole lot there
> to use.  Its existence takes up system resources, and also requires drivers
> to deal with the cdev's embedded kobject in their failure paths.  The
> following patch (against 2.6.4) makes it all go away.

Yeah!  I've been wanting this change for a while too.  I've applied it
and added it to my driver-2.6 tree to have it show up in the next -mm
release.  If it looks sane there I'll send it to Linus.

> OK, almost all.  We have to keep (but not register) cdev_subsys because
> it's rwsem is needed to control access to cdev_map.

That's fine and is ok.

thanks again.

greg k-h
