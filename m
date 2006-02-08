Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWBHJmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWBHJmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWBHJmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:42:09 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:27323 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964858AbWBHJmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:42:06 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 8 Feb 2006 10:43:11 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <nigel@suspend2.net>, Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602080116.12992.rjw@sisk.pl> <20060208082810.GB10961@elf.ucw.cz>
In-Reply-To: <20060208082810.GB10961@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081043.12662.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 08 February 2006 09:28, Pavel Machek wrote:
> > > Suspend-to-disk HOWTO
> > > ~~~~~~~~~~~~~~~~~~~~
> > > Copyright (C) 2006 Pavel Machek <pavel@suse.cz>
> > > 
> > > 
> > > You'll need /dev/snapshot for these to work:
> > > 
> > > crw-r--r--  1 root root 10, 231 Jan 13 21:21 /dev/snapshot
> 
> 
> > > Then compile userspace tools in usual way. You'll need an -mm kernel
> > > for now. To suspend-to-disk, run
> 
> I actually added -mm warning here.

Oh, I didn't notice, sorry.

> > > ./suspend /dev/<your_swap_partition>
> > > 
> > > . (There should be just one, for now.) Suspend is easy, resume is
> > > slightly harder. Resume application has to be ran without any
> > > filesystems mounted rw, and without any journalling filesystems
> > > mounted at all, preferably from initrd (but read-only ext2 should do
> > > the trick, too). Resume is then as easy as running
> > > 
> > > ./resume /dev/<your_swap_partition>
> > > 
> > > . You probably want to create script that attempts to resume with
> > > above command, and if that fails, fall back to init.
> > 
> > If it's run fron an initrd, it'll fall back automatically.  Also you can set
> > the name of the resume partition in the header file swsusp.h and
> > you'll be able to use the tools without any command line
> > parameters (useful if you want to start resume from an initrd).
> 
> I know a little about initrd. I've just commited HOWTO file, can you
> edit it to describe that?

OK, I will, but when I have some time for that (today in the night, probably).

Greetings,
Rafael
