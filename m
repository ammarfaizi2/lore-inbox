Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWFUMZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWFUMZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 08:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWFUMZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 08:25:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43752 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751523AbWFUMZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 08:25:36 -0400
Date: Wed, 21 Jun 2006 13:25:23 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: akpm@osdl.org, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs4 needs to force fail return revalidate
Message-ID: <20060621122523.GX27946@ftp.linux.org.uk>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606210618.k5L6IFDr008176@raven.themaw.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 02:18:15PM +0800, Ian Kent wrote:
> While this problem has been present for a long time I've avoided resolving 
> it because it was not very visible. But now that autofs v5 has "mount and 
> expire on demand" of nested multiple mounts, such as is found when 
> mounting an export list from a server, solving the problem cannot be 
> avoided any longer.
> 
> I've tried very hard to find a way to do this entirely within the 
> autofs4 module but have not been able to find a satisfactory way to 
> achieve it.
> 
> So, I need to propose a change to the VFS.

NAK in that form.  Care to explain what should happen to mount tree
when you do that to mountpoint?
