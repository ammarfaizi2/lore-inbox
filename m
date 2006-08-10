Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161391AbWHJQIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161391AbWHJQIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161405AbWHJQHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:07:41 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:59468 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161392AbWHJQHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:07:31 -0400
Subject: Re: + r-o-bind-mount-clean-up-ocfs2-nlink-handling.patch added to
	-mm tree
From: Daniel Walker <dwalker@mvista.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, mark.fasheh@oracle.com,
       viro@zeniv.linux.org.uk
In-Reply-To: <1155225757.19249.232.camel@localhost.localdomain>
References: <200608091912.k79JCnGh027465@shell0.pdx.osdl.net>
	 <1155218195.16579.3.camel@c-67-188-28-158.hsd1.ca.comcast.net>
	 <1155225757.19249.232.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 09:07:26 -0700
Message-Id: <1155226047.16579.15.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 09:02 -0700, Dave Hansen wrote:

> > There's one too many drop_nlink()'s in this block, unless I'm not
> > reading this right.
> 
> It needs to be double-dropped for any directory inodes.  Some of the
> older code just did i_nlink-=2, and I chose to just call drop_nlink()
> twice instead of making another helper to do arbitrary arithmetic on
> i_nlink.
> 
> I believe this made up for the 
> 
>         if (S_ISDIR(inode->i_mode))
>                 inode->i_nlink = 0;
> 
> in the old code.


Ok, I had a feeling it was something like that .. A comment around there
might be helpful though, so people don't query you on in the future.

Daniel

