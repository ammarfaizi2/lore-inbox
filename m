Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422703AbWCWVyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422703AbWCWVyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422704AbWCWVyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:54:20 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:43417 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422703AbWCWVyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:54:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [PATCH] swsusp: separate swap-writing/reading code
Date: Thu, 23 Mar 2006 22:53:00 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>
References: <200603231702.k2NH2OSC006774@hera.kernel.org> <200603240713.41566.ncunningham@cyclades.com>
In-Reply-To: <200603240713.41566.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603232253.01025.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 23 March 2006 22:13, Nigel Cunningham wrote:
> On Friday 24 March 2006 03:02, Linux Kernel Mailing List wrote:
> > commit 61159a314bca6408320c3173c1282c64f5cdaa76
> > tree 8e1b7627443da0fd52b2fac66366dde9f7871f1e
> > parent f577eb30afdc68233f25d4d82b04102129262365
> > author Rafael J. Wysocki <rjw@sisk.pl> Thu, 23 Mar 2006 19:00:00 -0800
> > committer Linus Torvalds <torvalds@g5.osdl.org> Thu, 23 Mar 2006 23:38:07
> > -0800
> >
> > [PATCH] swsusp: separate swap-writing/reading code
> >
> > Move the swap-writing/reading code of swsusp to a separate file.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> I guess I missed this one somehow. Using a bitmap for allocated swap is really 
> inefficient because the values are usually not fragmented much. Extents would 
> have been a far better choice.

I agree it probably may be improved.  Still it seems to be good enough.  Further,
it's more efficient than the previous solution, so I consider it as an improvement.
Also this code has been tested for quite some time in -mm and appears to
behave properly, at least we haven't got any bug reports related to it so far.

Currently I'm not working on any better solution.  If you can provide any
patches to implement one, please submit them, but I think they'll have to be
tested for as long as this code, in -mm.

Greetings,
Rafael
