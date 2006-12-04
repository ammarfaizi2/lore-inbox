Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935381AbWLDJ6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935381AbWLDJ6m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 04:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935390AbWLDJ6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 04:58:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60847 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935381AbWLDJ6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 04:58:41 -0500
Subject: Re: [GFS2] Tidy up bmap & fix boundary bug [48/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164999936.1194.79.camel@xenon.msp.redhat.com>
References: <1164889259.3752.401.camel@quoit.chygwyn.com>
	 <1164999936.1194.79.camel@xenon.msp.redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Dec 2006 10:00:47 +0000
Message-Id: <1165226447.3752.605.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-12-01 at 13:05 -0600, Russell Cattelan wrote:
> On Thu, 2006-11-30 at 12:20 +0000, Steven Whitehouse wrote:
> > >From 4cf1ed8144e740de27c6146c25d5d7ea26679cc5 Mon Sep 17 00:00:00 2001
> > From: Steven Whitehouse <swhiteho@redhat.com>
> > Date: Wed, 15 Nov 2006 15:21:06 -0500
> > Subject: [PATCH] [GFS2] Tidy up bmap & fix boundary bug
> > 
> > This moves the locking for bmap into the bmap function itself
> > rather than using a wrapper function. It also fixes a bug where
> > the boundary flag was set on the wrong bh.
> does boundary buffers even make sense for gfs?
> 
Yes.

> They might increase cluster contention, and probably serve to
> just chop up io to the fiber-channel raids/disks that have really
> good caches and queuing algorithms.
> 
I've yet to hear of a device that can merge non-contiguous i/o. Read the
comment above fs/mpage.c: mpage_readpages() to see how this scheme
works,

Steve.


