Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVIJXC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVIJXC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVIJXC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:02:27 -0400
Received: from nome.ca ([65.61.200.81]:60839 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S932347AbVIJXC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:02:26 -0400
Date: Sat, 10 Sep 2005 16:03:12 -0700
From: Mike Bell <mike@mikebell.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050910230310.GS13742@mikebell.org>
Mail-Followup-To: Mike Bell <mike@mikebell.org>, Greg KH <gregkh@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050909214542.GA29200@kroah.com> <20050910082732.GR13742@mikebell.org> <20050910215254.GA15645@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910215254.GA15645@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 02:52:54PM -0700, Greg KH wrote:
> I didn't say it was a "nice" solution, fully LSB compliant and all.  All
> it is is a solution that can work for some people, if they just want a
> small, in-kernel devfs-like solution.

It's not a solution if it doesn't /work/. If you think this works for
anyone who likes devfs, you clearly still don't understand what said
people like about devfs in the first place.

> And it works just fine for alsa and input devices for me, just no
> subdirs :)

What version of alsa libraries are you using that can deal with the
device nodes in the root of /dev? I'm grepping the latest source code
right now and I don't see it. Or is this yet another one of those facts
you just made up? In what sense can alsa be said to work if zero alsa
programs work?

> Anyway, I'm not offering it up for inclusion in the kernel tree at
> all, but for a proof-of-concept for those who were insisting that it
> was impossible to keep a devfs-like patchset out of the main kernel
> tree easily.

You can use ndevfs, if you don't care about your device nodes working.
However that kind of defeats the purpose. To have a /working/ devfs-like
solution you need the names, and currently the only way to get those is
the devfs hooks.

Nobody is obligating you to provide a working ndevfs, but don't claim
it's a solution when it's not. A devfs-like solution whose device nodes
have random names which break programs is copying the form of devfs
(exporting nodes from kernel space) and ignoring the point of devfs.
