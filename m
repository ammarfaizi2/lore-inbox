Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbVBCKsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbVBCKsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbVBCKpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:45:33 -0500
Received: from sd291.sivit.org ([194.146.225.122]:43959 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262881AbVBCKna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:43:30 -0500
Date: Thu, 3 Feb 2005 11:45:02 +0100
From: Stelian Pop <stelian@popies.net>
To: Daniele Venzano <webvenza@libero.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050203104501.GC3144@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Daniele Venzano <webvenza@libero.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050202155403.GE3117@crusoe.alcove-fr> <51cfdfdc084037ae1e3f164b0c524abc@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51cfdfdc084037ae1e3f164b0c524abc@libero.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 10:47:58PM +0100, Daniele Venzano wrote:

> Il giorno 02/feb/05, alle 16:54, Stelian Pop ha scritto:
> 
> >Hi,
> >
> >I've played lately a bit with Subversion and used it for managing
> >the kernel sources, using Larry McVoy's bk2cvs bridge and Ben Collins'
> >bkcvs2svn conversion script.
> 
> Really useful, thanks !
> I'm using svn to manage a very small part of the kernel tree (2 files). 
> It is difficult to keep in sync with mainstream development without 
> having to fetch and keep huge amounts of data (this regardless of the 
> version control system used).

Indeed. As I put it in the howto, the SVN repository is about 900 MB
(but I think it can be less when using svn's fsfs storage backend,
I must test this...), plus 600 MB per working copy.

There is not much anybody can do about this.

> For now I'm keeping the latest stable 2.6 release of the files I need 
> in the svn repo, then when I need to sync with the rest of the world, I 
> get the latest -bk patch and see if there are some related changes. If 
> so, I create a new branch, apply the -bk patch (only the interesting 
> part) and then apply my modifications on top of that.

With the 'full' svn solution you lose some storage space but you
gain in time. The above steps are automatic and you don't have to
bother looking at the changes, decide if it matters or not, etc.

> That still means I have to download usually a >1MB compressed file for 
> ~60KB of interesting (uncompressed) data, but that is still much better 
> than the gigabytes of network traffic needed for a full kernel tree and 
> up to date working copies.

I think you end up with pretty much the same network traffic in both
cases (svn or linux.tar.gz + bk patches). The only difference is the
storage cost.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
