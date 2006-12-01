Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031744AbWLATZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031744AbWLATZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031749AbWLATZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:25:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:9641 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1031744AbWLATZ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:25:57 -0500
Date: Fri, 1 Dec 2006 19:25:55 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: Steven Whitehouse <swhiteho@redhat.com>, cluster-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [GFS2] Change argument of gfs2_dinode_out [17/70]
Message-ID: <20061201192555.GD3078@ftp.linux.org.uk>
References: <1164888933.3752.338.camel@quoit.chygwyn.com> <1165000744.1194.89.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165000744.1194.89.camel@xenon.msp.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 01:19:04PM -0600, Russell Cattelan wrote:
> On Thu, 2006-11-30 at 12:15 +0000, Steven Whitehouse wrote:
> > >From 539e5d6b7ae8612c0393fe940d2da5b591318d3d Mon Sep 17 00:00:00 2001
> > From: Steven Whitehouse <swhiteho@redhat.com>
> > Date: Tue, 31 Oct 2006 15:07:05 -0500
> > Subject: [PATCH] [GFS2] Change argument of gfs2_dinode_out
> > 
> > Everywhere this was called, a struct gfs2_inode was available,
> > but despite that, it was always called with a struct gfs2_dinode
> > as an argument. By making this change it paves the way to start
> > eliminating fields duplicated between the kernel's struct inode
> > and the struct gfs2_dinode.
> More pointless code churn.
> 
> This only makes sense once the file system is working 
> and we have time to do this type of cleanup on against
> a stable and TESTED code base.

Bzzert.  Cleaner code is easier to _get_ stable.  "Keep it ucking fugly
until everyone stops looking at it out of sheer disgust" is a bad idea.
