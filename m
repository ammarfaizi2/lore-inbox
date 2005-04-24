Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVDXH0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVDXH0I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 03:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVDXH0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 03:26:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:166 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262278AbVDXH0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 03:26:01 -0400
Date: Sun, 24 Apr 2005 09:25:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Petr Baudis <pasky@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050424072518.GB1908@elf.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz> <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz> <20050423232303.GK13222@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423232303.GK13222@pasky.ji.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Ne 24-04-05 01:23:03, Petr Baudis wrote:
> Dear diary, on Sat, Apr 23, 2005 at 01:18:39AM CEST, I got a letter
> where Pavel Machek <pavel@ucw.cz> told me that...
> > git patch origin:
> > 
> > will list my patches, plus any merges I done... Is there any
> > reasonable way to get only "my" changes? When I do not have to resolve
> > anything during merge, it should be usable... but that is starting to
> > look ugly.
> 
> I told you the semantics is peculiar.
> 
> We could add a flag to rev-tree to always follow only the first parent;
> that would be useful even for a flag for git log to "flatten" the
> history, if you aren't interested in what was going on in the trees you
> just merged.
> 
> Another flag to avoid showing patches for merges might be possible, but
> actually a little scary since you don't have consistency assured that
> way; your post-merge patches might generate rejects when applied on top
> of the pre-merge patches, or your pre-merge patches might not apply
> cleanly on the tree you merged with.
> 
> So if you want to ignore merges, it sounds that you are probably
> actually doing something wrong. We might still let you do it
> assuming

Right. Actually right thing might be to "only show human-made part of
each merge" or something like that. Ignoring merges altogether is not
quite right. OTOH really only small part of merge is going to
matter...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
