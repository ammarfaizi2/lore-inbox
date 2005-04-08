Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262936AbVDHTRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbVDHTRA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbVDHTRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:17:00 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:45253 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262936AbVDHTQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:16:53 -0400
Date: Fri, 8 Apr 2005 12:16:38 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408191638.GA5792@taniwha.stupidest.org>
References: <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <20050408171518.GA4201@taniwha.stupidest.org> <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org> <20050408180540.GA4522@taniwha.stupidest.org> <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 12:03:49PM -0700, Linus Torvalds wrote:

> Yes, doing the stat just on the directory (on leaf directories only, of
> course, but nlink==2 does say that on most filesystems) is indeed a huge
> potential speedup.

Here I measure about 6ms for cache --- essentially below the noise
threshold for something that does real work.

> It doesn't matter so much for the cached case, but it _does_ matter
> for the uncached one.

Doing the minimal stat cold-cache here is about 6s for local disk.
I'm somewhat surprised it's that bad actually.
