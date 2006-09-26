Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWIZVCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWIZVCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWIZVCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:02:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:23520 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932315AbWIZVCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:02:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Date: Tue, 26 Sep 2006 23:04:45 +0200
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609231158.00147.rjw@sisk.pl> <200609262213.26274.rjw@sisk.pl> <20060926134901.18fad0db.akpm@osdl.org>
In-Reply-To: <20060926134901.18fad0db.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262304.46101.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 September 2006 22:49, Andrew Morton wrote:
> On Tue, 26 Sep 2006 22:13:25 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Tuesday, 26 September 2006 21:39, Andrew Morton wrote:
> > > On Sat, 23 Sep 2006 12:10:54 +0200
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > In order to use a swap file with swsusp we need to know the offset at which
> > > > its swap header is located.  However, the swap header is always located in the
> > > > first page block of the swap file and it's quite easy to make sys_swapon() print
> > > > the offset of the swap file's (or swap partition's) first page block.
> > > 
> > > Why is this needed?  The swapfile's pathname is present in /proc/swaps, so
> > > an application can read that, do the FIBMAP and rewrite grub.conf without
> > > needing to parse dmesg?
> > 
> > Well, this is not needed, but it's useful if you have no such application and
> > want to set up things manually. ;-)
> 
> ick.  We need such an application (probably doable in a python script?). 
> Methinks that telling people to go poking in dmesg will simply delay the
> development and propagation of that application..

Okay, let's drop the patch, then.

I'll redo the documentation ...
