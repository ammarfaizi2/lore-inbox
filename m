Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbVJYEcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVJYEcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 00:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVJYEcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 00:32:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:27527 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751452AbVJYEcu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 00:32:50 -0400
Date: Tue, 25 Oct 2005 05:32:46 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bfields@fieldses.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/8] FUSE: per inode statfs
Message-ID: <20051025043246.GL7992@ftp.linux.org.uk>
References: <E1EU5vx-0005yb-00@dorka.pomaz.szeredi.hu> <20051024172546.GA30782@fieldses.org> <E1EU7dX-00066t-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EU7dX-00066t-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 09:05:35PM +0200, Miklos Szeredi wrote:
> > > This patch makes FUSE based filesystems able to return filesystem
> > > statistics based on path.  While breaks with the tradition of
> > > homogeneous statistics per _local_ filesystem, however adds useful
> > > ability to user to differentiate statistics from different _remote_
> > > filesystem served by the same userspace server.
> > 
> > Wouldn't it make more sense to create more mountpoints (on demand, if
> > necessary) to handle this case?
> 
> Only if
> 
>  a) it's possible to find out about remote mountpoints
> 
>  b) not prohibitively expensive to do so on each lookup

And finding the pathnames to call statfs() on is by some magic cheaper?
