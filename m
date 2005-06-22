Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVFVXNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVFVXNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVFVXMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:12:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:60300 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262572AbVFVXJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:09:18 -0400
Date: Wed, 22 Jun 2005 16:09:05 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
Message-ID: <20050622230905.GA7873@kroah.com>
References: <42B9E536.60704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9E536.60704@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 06:24:54PM -0400, Jeff Garzik wrote:
> 10) don't forget to download tags from time to time.
> 
> git-pull-script only downloads sha1-indexed object data, and the 
> requested remote head.  This misses updates to the .git/refs/tags/ and 
> .git/refs/heads directories.  It is advisable to update your kernel .git 
> directories periodically with a full rsync command, to make sure you got 
> everything:
> 
> $ cd linux-2.6
> $ rsync -a --delete --verbose --stats --progress \
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> \          <- word-wrapped backslash; sigh
>     .git/

Ok, this is annoying.  Is there some reason why git doesn't pull the
tags in properly when doing a merge?  Chris and I just hit this when I
pulled his 2.6.12.1 tree and and was wondering where the tag went.

thanks,

greg k-h
