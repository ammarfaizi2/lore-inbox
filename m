Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbTFQUd3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTFQUd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:33:29 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:35327 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264927AbTFQUdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:33:08 -0400
Subject: Re: [PATCH] O_DIRECT for ext3 (2.4.21)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: roy@karlsbakk.net, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030617131927.2ac04150.akpm@digeo.com>
References: <20030615110106.GA8404@karlsbakk.net>
	 <1055861357.4240.11.camel@sisko.scot.redhat.com>
	 <20030617130142.50775749.akpm@digeo.com>
	 <20030617131927.2ac04150.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055882819.16608.4.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jun 2003 21:46:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2003-06-17 at 21:19, Andrew Morton wrote:

> It works out OK in 2.5, and we should do it this way in 2.4 too:
> 
> - dentry_open() checks for inode->i_mapping->a_ops->direct_IO
> 
> - setfl() checks for inode->i_mapping->a_ops->direct_IO
> 
> - the a_ops for data-journalled inodes have a null ->direct_IO.

That's what the -aa patches do, and I've got those queued in my local
O_DIRECT stuff already.  ext3 will just expose a different a_ops for
data-journaled files.

Cheers,
 Stephen

