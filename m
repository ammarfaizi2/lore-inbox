Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbTJUJZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 05:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTJUJZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 05:25:19 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:29420 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262804AbTJUJZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 05:25:13 -0400
X-Sender-Authentication: net64
Date: Tue, 21 Oct 2003 11:25:11 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: andrea@suse.de, marcelo.tosatti@cyclades.com, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre VM regression?
Message-Id: <20031021112511.523254fb.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.58.0310200014330.17168@ppg_penguin>
References: <20031016132412.GB1348@velociraptor.random>
	<Pine.LNX.4.44.0310161028080.2388-100000@logos.cnet>
	<20031016133552.GD1348@velociraptor.random>
	<Pine.LNX.4.58.0310200014330.17168@ppg_penguin>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Oct 2003 00:21:55 +0100 (BST)
Ken Moffat <ken@kenmoffat.uklinux.net> wrote:

> On Thu, 16 Oct 2003, Andrea Arcangeli wrote:
> 
> >
> > sure. I think I already explained there are downsides in disabling the
> > oom killer for desktops where the offender task is normally the biggest
> > one too, but those downsides aren't something I care about given the
> > cases it gets right w/o it (i.e. huge-shm-SGA/mlock/oomdeadlocks). the
> > oom killer can do the wrong decision too sometime, and more
> > systematically as well.
> >
> 
>  Any chance of getting the oom killer back as an option ?  On
> 2.4.23-pre7 I made the mistake of trying to print a high-resolution
> photo (300ppi, A4 size) using ghostscript while I was in X.  I've only
> got 128MB memory and about 256MB swap on that box, which obviously
> wasn't enough (gs typically uses up to 300MB for a 200ppi A4 picture).
> Only problem was that X got killed instead of gs, which left the box
> unuseable.  Last time I saw the oom killer in action it actually saved
> me from having to reboot.

After having read numerous arcticles regarding oom
killer/conditions/bugs/features I believe the lack of the oom killer is
possibly the best scenario _without_ any user configuration. If you really want
an oom killer it seems obvious that what you really want is a _configurable_
oom killer. The simple approach in configuration is handing it a list of
processes it should _not_ kill. This means of course you need a user-space tool
to mark processes as not oom-killable, possibly implemented as a kind of
priority. Not set means "kill-at-will", set means top-priority gets killed as
last.
Did we already have this kind of proposal? :-)
-- 
Regards,
Stephan
