Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVIEQDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVIEQDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVIEQDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:03:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:7098 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932300AbVIEQDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:03:15 -0400
Date: Mon, 5 Sep 2005 17:03:13 +0100
From: viro@ZenIV.linux.org.uk
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] 2.6.13-git3-bird1
Message-ID: <20050905160313.GH5155@ZenIV.linux.org.uk>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905155522.GA8057@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 07:55:22PM +0400, Alexey Dobriyan wrote:
> On Mon, Sep 05, 2005 at 04:58:48AM +0100, viro@ZenIV.linux.org.uk wrote:
> > 	While waaaaay overdue, "fixes and sparse annotations" tree is finally
> > going public.  This version is basically a starting point - there will be
> > much more stuff to merge.
> 
> > 	Current patchset is on ftp.linux.org.uk/pub/people/viro/ -
> > patch-2.6.13-git3-bird1.bz2 is combined patch, patchset/* is the splitup.
> > Long description of patches is in patchset/set*, short log is in the end of
> > this posting.  Current build and sparse logs are in logs/*/{log17b,S-log17b}.
> 
> Those who want to help with endian annotations (sparse -Wbitwise) are
> welcome at ftp://ftp.berlios.de/pub/linux-sparse/logs/
> 
> [allmodconfig + CONFIG_DEBUG_INFO=n] x [alpha, i386, parisc, ppc, ppc64,
> s390, sh, sh64, sparc, sparc64, x86_64]
> 
> -git5 is compiling right now.

-git5 has additional breakage:
	* s390 crypto is b0rken; removal of workqueue that doesn't exist
	* ppc44x missed s/u3/pm_message_t/
	* sparc64 Kconfig changes need to be compensated for in drivers/char
Plus m68k and uml stuff need updates.

I'll post the updated patchset in a few and start clean rebuild; then the
logs will go.
