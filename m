Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264898AbUELA2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUELA2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUELAZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:25:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:14976 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265081AbUELAMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:12:50 -0400
Date: Tue, 11 May 2004 17:12:15 -0700
From: Greg KH <greg@kroah.com>
To: Valdis.Kletnieks@vt.edu, Dave Airlie <airlied@linux.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: From Eric Anholt:
Message-ID: <20040512001215.GA27789@kroah.com>
References: <200405112211.i4BMBQDZ006167@hera.kernel.org> <20040511222245.GA25644@kroah.com> <Pine.LNX.4.58.0405120018360.3826@skynet> <200405112334.i4BNYdjO018918@turing-police.cc.vt.edu> <20040511234329.GA27242@kroah.com> <20040512000709.GA10233@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512000709.GA10233@nevyn.them.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 08:07:09PM -0400, Daniel Jacobowitz wrote:
> On Tue, May 11, 2004 at 04:43:29PM -0700, Greg KH wrote:
> > On Tue, May 11, 2004 at 07:34:39PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > > On Wed, 12 May 2004 00:20:51 BST, Dave Airlie said:
> > > 
> > > > I just looked at drm.h and nearly all the ioctls use int, this file is
> > > > included in user-space applications also at the moment, I'm worried
> > > > changing all ints to __u32 will break some of these, anyone on DRI list
> > > > care to comment?
> > > 
> > > Is this a case where somebody is *really* including kernel headers in userspace
> > > and we need to smack them, or are they using a copy that's been sanitized
> > > (and possibly fixed)?
> > 
> > Don't know, but how are you dealing with the issue that an "int" is
> > different for different kernel sizes (64 vs 32) and userspace too.
> > That's why you can't use it in an ioctl and expect things to work
> > properly.
> 
> I'm not disagreeing that it ought to use __u32, but are there any Linux
> supported targets that don't have a 32-bit int?  It's long that tends
> to change size.

I don't think so, but I am not sure.  That's why you should use __u32 to
keep people from guessing :)

thanks,

greg k-h
