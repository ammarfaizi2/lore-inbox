Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422913AbWJQKxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422913AbWJQKxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 06:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422907AbWJQKxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 06:53:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:31152 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422899AbWJQKxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 06:53:18 -0400
From: Andi Kleen <ak@suse.de>
To: Ian Kent <raven@themaw.net>
Subject: Re: BUG dcache.c:613 during autofs unmounting in 2.6.19rc2
Date: Tue, 17 Oct 2006 12:50:56 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <200610161658.58288.ak@suse.de> <1161058535.11489.6.camel@localhost>
In-Reply-To: <1161058535.11489.6.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610171250.56522.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 06:15, Ian Kent wrote:
> On Mon, 2006-10-16 at 16:58 +0200, Andi Kleen wrote:
> > While unmounting autofs on shutdown my workstation got a dcache.c:613 BUG 
> > with 2.6.19rc2.
> > 
> > Only jpegs available unfortunately:
> > 
> > http://one.firstfloor.org/~andi/autofs-oops1.jpg
> > http://one.firstfloor.org/~andi/autofs-oops2.jpg
> > 
> > I think it was autofs3 instead of autofs4 - at least I got both compiled in.
> > The autofs user land was autofs-4.1.4 (-6 suse rpm) 
> 
> Don't think compiling both in is a good idea.
> They both register as "autofs" so you really should choose one and
> disable the other.
> 
> For my part I have to recommend autofs4 (personally I'd like to see the
> autofs v3 module deprecated) and autofs4 is really needed if your using
> autofs version 4 or above.

Well it always worked this way in earlier kernels and even if the
wrong module was suddenly used for some reason it shouldn't BUG.
So something is broken.

-Andi
