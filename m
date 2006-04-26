Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWDZFWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWDZFWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 01:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWDZFWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 01:22:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:18614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932374AbWDZFWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 01:22:49 -0400
Date: Tue, 25 Apr 2006 22:18:13 -0700
From: Greg KH <greg@kroah.com>
To: Jens Axboe <axboe@suse.de>
Cc: Al Viro <viro@ftp.linux.org.uk>, Akinobu Mita <mita@miraclelinux.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 3/3] use kref for bio
Message-ID: <20060426051813.GB332@kroah.com>
References: <20060426021059.235216000@localhost.localdomain> <20060426021122.069267000@localhost.localdomain> <20060426022635.GF27946@ftp.linux.org.uk> <20060426051344.GT4102@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426051344.GT4102@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 07:13:44AM +0200, Jens Axboe wrote:
> On Wed, Apr 26 2006, Al Viro wrote:
> > On Wed, Apr 26, 2006 at 10:11:02AM +0800, Akinobu Mita wrote:
> > > Use kref for reference counter of bio.
> > > This patch also removes BUG_ON() for freeing unreferenced bio.
> > > But kref can detect it if CONFIG_DEBUG_SLAB is enabled.
> >  
> > *Ugh*
> > 
> > Let's _not_.  It's extra overhead for no good reason.
> 
> Completely agree. That goes for the other block layer kref patches as
> well.

I also agree, there's a reason I never tried to convert them in the past
:)

thanks,

greg k-h
