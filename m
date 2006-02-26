Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWBZLrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWBZLrT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 06:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWBZLrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 06:47:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:20616 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750836AbWBZLrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 06:47:19 -0500
Date: Sun, 26 Feb 2006 11:47:00 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
Message-ID: <20060226114700.GP27946@ftp.linux.org.uk>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de> <20060225021009.GV3883@sorel.sous-sol.org> <4400E34B.1000400@s5r6.in-berlin.de> <Pine.LNX.4.64.0602251600480.22647@g5.osdl.org> <20060226001716.GL27946@ftp.linux.org.uk> <Pine.LNX.4.64.0602251626280.22647@g5.osdl.org> <44016956.2030609@pobox.com> <20060226090024.GO27946@ftp.linux.org.uk> <440186AE.2@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440186AE.2@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 05:45:02AM -0500, Jeff Garzik wrote:
> AFAICS 'git clone $rsync_url' pulls down the heads and tags just fine... 
>  I just tried it again to be certain.  refs/heads and refs/tags is 
> fully populated, and HEAD links to refs/master as it should.

Why should it?  Note that this is _not_ what happens with e.g. git://
URLs.  And while we are at it, who said that refs/master even exists?
AFAICS, it's a convention and no more - it doesn't have to be there.

Even if it does exist, I'd say that behaviour of git:// makes more sense -
it sets HEAD to the same thing we have in remote; if it's refs/master,
so be it, if it's set to a different branch, we start on the same branch.
