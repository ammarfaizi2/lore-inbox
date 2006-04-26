Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWDZFNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWDZFNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 01:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWDZFNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 01:13:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29011 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932369AbWDZFNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 01:13:13 -0400
Date: Wed, 26 Apr 2006 07:13:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Greg KH <greg@kroah.com>
Subject: Re: [patch 3/3] use kref for bio
Message-ID: <20060426051344.GT4102@suse.de>
References: <20060426021059.235216000@localhost.localdomain> <20060426021122.069267000@localhost.localdomain> <20060426022635.GF27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426022635.GF27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26 2006, Al Viro wrote:
> On Wed, Apr 26, 2006 at 10:11:02AM +0800, Akinobu Mita wrote:
> > Use kref for reference counter of bio.
> > This patch also removes BUG_ON() for freeing unreferenced bio.
> > But kref can detect it if CONFIG_DEBUG_SLAB is enabled.
>  
> *Ugh*
> 
> Let's _not_.  It's extra overhead for no good reason.

Completely agree. That goes for the other block layer kref patches as
well.

-- 
Jens Axboe

