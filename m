Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVB1B6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVB1B6e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 20:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVB1B6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 20:58:33 -0500
Received: from orb.pobox.com ([207.8.226.5]:24026 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261376AbVB1B6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 20:58:31 -0500
Date: Sun, 27 Feb 2005 17:58:26 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp logic error?
Message-ID: <20050228015826.GF7524@ip68-4-98-123.oc.oc.cox.net>
References: <20050208203950.GA21623@cirrus.madduck.net> <20050227174309.GA27265@piper.madduck.net> <20050227175039.GL1441@elf.ucw.cz> <200502271927.39982.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502271927.39982.rjw@sisk.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 07:27:39PM +0100, Rafael J. Wysocki wrote:
> On Sunday, 27 of February 2005 18:50, Pavel Machek wrote:
[snip]
> > Ok, this one.
> > 
> > I do not know what is going wrong. swsusp seems to work for
> > people... or at least it works for me. Here's my .config, perhaps you
> > have something unusual?
> > 
> > I do have CONFIG_PM_STD_PARTITION="/dev/hda1", perhaps that's
> > neccessary?
> 
> I don't set CONFIG_PM_STD_PARTITION, but I pass the "resume" parameter
> to the kernel and it works (no fuss, on x86-64 and i386).

I have the same setup as Rafael, on i386 boxes. swsusp was very
messed-up for me in earlier 2.6.11-rc, but with -rc4 (or maybe it's one
of the -bk snapshots between -rc4 and -rc5) it works for me again.
Specifically, in the failing releases, swsusp would never succeed in
suspending the machine.

Since the problem is gone now, I think I have better uses for my time
than figuring out when the problem started and when it was fixed, but I
just wanted to mention that in fact there are problems in earlier
2.6.11-rc releases that seem to be fixed later on.

-Barry K. Nathan <barryn@pobox.com>

