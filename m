Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVJXTGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVJXTGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 15:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVJXTGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 15:06:55 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:27914 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751129AbVJXTGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 15:06:54 -0400
To: bfields@fieldses.org
CC: akpm@osdl.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20051024172546.GA30782@fieldses.org> (bfields@fieldses.org)
Subject: Re: [PATCH 8/8] FUSE: per inode statfs
References: <E1EU5vx-0005yb-00@dorka.pomaz.szeredi.hu> <20051024172546.GA30782@fieldses.org>
Message-Id: <E1EU7dX-00066t-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 21:05:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch makes FUSE based filesystems able to return filesystem
> > statistics based on path.  While breaks with the tradition of
> > homogeneous statistics per _local_ filesystem, however adds useful
> > ability to user to differentiate statistics from different _remote_
> > filesystem served by the same userspace server.
> 
> Wouldn't it make more sense to create more mountpoints (on demand, if
> necessary) to handle this case?

Only if

 a) it's possible to find out about remote mountpoints

 b) not prohibitively expensive to do so on each lookup

Miklos
