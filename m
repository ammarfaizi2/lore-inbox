Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267317AbUHDPsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbUHDPsn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267316AbUHDPsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:48:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37799 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267314AbUHDPsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:48:37 -0400
Date: Wed, 4 Aug 2004 17:48:24 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-ID: <20040804154824.GV10340@suse.de>
References: <20040804085000.GH10340@suse.de> <20040804075215.155c06ac.davem@redhat.com> <20040804150403.GU10340@suse.de> <20040804084429.7de77cd7.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040804084429.7de77cd7.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04 2004, David S. Miller wrote:
> On Wed, 4 Aug 2004 17:04:04 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > On Wed, Aug 04 2004, David S. Miller wrote:
> > > 
> > > When you pass data structures in via {read,write}{,v}() system calls,
> > > you make it next to impossible for the CONFIG_COMPAT layer to cope
> > > with this.
> > > 
> > > Please consider another way to pass in those sg_io_* things.
> > 
> > Any suggestions?
> 
> ioctl() :-(

ioctls suck :-)

> Or use a more portable well-defined type which does not change
> size nor layout between 32-bit and 64-bit environments.

Yeah that's what I thought you meant... Problem is, to stay compatible
with sg v3 I cannot do much about the structure. It should have been
designed with this in mind from the beginning.

But I can certainly draft a new structure that works...

-- 
Jens Axboe

