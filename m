Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbTJVC4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 22:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTJVC4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 22:56:10 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:17164 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263442AbTJVC4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 22:56:07 -0400
Date: Tue, 21 Oct 2003 19:56:02 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031022025602.GH17713@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <3F8E552B.3010507@users.sf.net> <bn40oa$i4q$1@gatekeeper.tmr.com> <bn46q9$1rv$1@cesium.transmeta.com> <bn4aov$jf7$1@gatekeeper.tmr.com> <bn4l5q$v73$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bn4l5q$v73$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Vulnerable email reader detected!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 06:06:02PM -0700, H. Peter Anvin wrote:
> Followup to:  <bn4aov$jf7$1@gatekeeper.tmr.com>
> By author:    davidsen@tmr.com (bill davidsen)
> In newsgroup: linux.dev.kernel
> > | 
> > | Bullshit.  "myrng 36 | foo" works just fine.
> > 
> > myrng?? That doesn't seem to be part of the bash I have, or any
> > distribution I could check, and google shows a bunch of visual basic
> > results rather than anything useful.
> > 
> > If you're suggesting that every user write their own program to
> > generate random numbers, then write a script to call it, that kind of
> > defeats the purpose of doing shell instead of writing a program, doesn't
> > it? Not to mention that to get entropy the user program will have to
> > call the devices anyway.
> > 
> > I think this could also fail the objective of returning unique results
> > in an SMP system, but that's clearly imprementation dependent.
> > 
> 
> No, I mean that putting a piece of code in the kernel "so it can be
> accessed from shell scripts" is idiotic.  Make a binary of it and put
> it in the filesystem.

Not to mention that some (bash the most common) shells have
a PRNG built-in.  As does perl and i'm sure python and any
other higher-than-shell scripting language.

I'm convinced we don't need another device.  This might
still be an alternative (build time selected) for the PRNG
in the existing /dev/urandom if someone is that concerned
with PRNG overhead.

I am curious how someone is going to use random data from a
device in a shell with the possible exception of "dd
if=/dev/urandom of=/some/file" given that they emit a binary
stream not numerals.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
