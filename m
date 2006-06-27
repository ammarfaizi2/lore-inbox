Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWF0WTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWF0WTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWF0WTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:19:03 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:9165 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422650AbWF0WSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:18:40 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigel@suspend2.net
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Wed, 28 Jun 2006 00:19:31 +0200
User-Agent: KMail/1.9.3
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271126.28898.rjw@sisk.pl> <200606271935.13261.nigel@suspend2.net>
In-Reply-To: <200606271935.13261.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606280019.32045.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 27 June 2006 11:35, Nigel Cunningham wrote:
> On Tuesday 27 June 2006 19:26, Rafael J. Wysocki wrote:
> > > > Now I haven't followed the suspend2 vs swsusp debate very closely, but
> > > > it seems to me that your biggest problem with getting this merged is
> > > > getting consensus on where exactly this is going. Nobody wants two
> > > > different suspend modules in the kernel. So there are two options -
> > > > suspend2 is deemed the way to go, and it gets merged and replaces
> > > > swsusp. Or the other way around - people like swsusp more, and you are
> > > > doomed to maintain suspend2 outside the tree.
> > >
> > > Generally, I agree, although my understanding of Rafael and Pavel's
> > > mindset is that swsusp is a dead dog and uswsusp is the way they want to
> > > see things go. swsusp is only staying for backwards compatability. If
> > > that's the case, perhaps we can just replace swsusp with Suspend2 and let
> > > them have their existing interface for uswsusp. Still not ideal, I agree,
> > > but it would be progress.
> >
> > Well, ususpend needs some core functionality to be provided by the kernel,
> > like freezing/thawing processes (this is also used by the STR),
> > snapshotting the system memory.  These should be shared with the in-kernel
> > suspend, be it swsusp or suspend2.
> 
> If I modify suspend2 so that from now on it replaces swsusp, using noresume, 
> resume= and echo disk > /sys/power/state in a way that's backward compatible 
> with swsusp and doesn't interfere with uswsusp support, would you be happy? 
> IIRC, Pavel has said in the past he wishes I'd just do that, but he's not you 
> of course.

That depends on how it's done.  For sure, I wouldn't like it to be done in the
"everything at once" manner.

Greetings,
Rafael
