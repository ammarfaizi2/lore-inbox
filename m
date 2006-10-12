Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWJLOOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWJLOOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWJLOOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:14:14 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:2726 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030419AbWJLOON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:14:13 -0400
Date: Thu, 12 Oct 2006 16:13:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: roland <devzero@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The Future of ReiserFS development
Message-ID: <20061012141335.GB16202@wohnheim.fh-wedel.de>
References: <005a01c6edd9$7cfb7be0$962e8d52@aldipc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <005a01c6edd9$7cfb7be0$962e8d52@aldipc>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 October 2006 10:36:11 +0200, roland wrote:
> >
> >Of course: Simply backup, mkfs and restore!
> 
> not that simple if you have hundreds of thousands or even millions of small 
> files !
> reiserfs is quite efficient in storing small files.
> don`t know if there is anyfilesystem which is as efficient with this.....

Just millions?  What's your problem then?

Per file you can estimate 4KiB + 128 bytes for the inode.  That's
about 4.2GB for a million files.  The "wasted" size is still lower, as
small files still require some storage even with tail packing.

And in-memory reiserfs is just as inefficient as any other filesystem,
as it shares the same page cache.

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf
