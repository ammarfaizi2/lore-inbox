Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWBGOXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWBGOXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWBGOXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:23:41 -0500
Received: from ns2.suse.de ([195.135.220.15]:46280 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965092AbWBGOXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:23:40 -0500
From: Andi Kleen <ak@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: radix-tree.c:378 BUG NFS client bug on 2.6.15-git7
Date: Tue, 7 Feb 2006 15:04:18 +0100
User-Agent: KMail/1.8.2
Cc: okir@suse.de, linux-kernel@vger.kernel.org
References: <200602071146.19881.ak@suse.de> <1139320822.7864.3.camel@lade.trondhjem.org>
In-Reply-To: <1139320822.7864.3.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071504.18997.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 15:00, Trond Myklebust wrote:
> On Tue, 2006-02-07 at 11:46 +0100, Andi Kleen wrote:
> > Found this on a box still running 2.6.15-git7 (I know it's a bit old).
> > It was under relatively heavy NFS client traffic. Perhaps it's of interest 
> > for someone.
> > 
> > -Andi
> > 
> > 
> > nfs_update_inode: inode 961647 mode changed, 0040755 to 0100644
> 
> This is weird. The server appears to have magically changed a directory
> into a regular file...
> 
> Would this be the userland server or is it knfsd?

Could be either. The machine is in a complex automount setup
which includes both types of servers. And both should be regularly
accessed.

-Andi

