Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVAMHzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVAMHzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 02:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVAMHzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 02:55:54 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:49935 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261191AbVAMHzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 02:55:49 -0500
Date: Thu, 13 Jan 2005 08:42:34 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113074234.GJ7048@alpha.home.local>
References: <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113072851.GN2995@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113072851.GN2995@waste.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 11:28:51PM -0800, Matt Mackall wrote:
> On Wed, Jan 12, 2005 at 08:48:57PM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Wed, 12 Jan 2005, Dave Jones wrote:
> > > 
> > > For us thankfully, exec-shield has trapped quite a few remotely
> > > exploitable holes, preventing the above.
> > 
> > One thing worth considering, but may be abit _too_ draconian, is a
> > capability that says "can execute ELF binaries that you can write to".
> > 
> > Without that capability set, you can only execute binaries that you cannot
> > write to, and that you cannot _get_ write permission to (ie you can't be
> > the owner of them either - possibly only binaries where the owner is
> > root).
> 
> We can do that now with a combination of read-only and no-exec mounts.

That's why some hardened distros ship with everything R/O (except var) and
/var non-exec.

Willy

