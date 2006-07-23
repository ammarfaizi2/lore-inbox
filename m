Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWGWR6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWGWR6m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 13:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWGWR6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 13:58:42 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:23994 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750783AbWGWR6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 13:58:41 -0400
Date: Sun, 23 Jul 2006 19:58:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: Milton Miller <miltonm@bga.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Use target filename in BUG_ON and friends
Message-ID: <20060723175815.GC16218@mars.ravnborg.org>
References: <20060708084713.GA8020@mars.ravnborg.org> <b2ab6d298877aff62aa61e0430a16d3d@bga.com> <20060708205707.GB13124@mars.ravnborg.org> <200607100203.07206.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607100203.07206.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 02:03:07AM +0200, Andi Kleen wrote:
> On Saturday 08 July 2006 22:57, Sam Ravnborg wrote:
> > On Sat, Jul 08, 2006 at 11:45:49AM -0500, Milton Miller wrote:
> > > 			
> > > On Jul 8, 2006, at 04:45:54 EST, Sam Ravnborg wrote:
> > > > When building the kernel using make O=.. all uses of __FILE__ becomes
> > > > filenames with absolute path resulting in increased text size.
> > > > Following patch supply the target filename as a commandline define
> > > > KBUILD_TARGET_FILE="mmslab.o"
> > > 
> > > Unfortunately this ignores the fact that __LINE__ is meaningless
> > > without __FILE__ because there are way too many BUGs in header
> > > files.
> > 
> > __LINE__ gives a very precise hint of the offending .h file.
> > For x86_64 there are only one line-number clash in include/ for uses of
> > __FILE__.
> 
> 
> It's a nasty encoding. Maybe you could add a script to resolve them?
The patch was dropped. The benefit was too small compared to less
readable bug's.

	Sam
