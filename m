Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWF1Weg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWF1Weg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWF1Weg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:34:36 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:17113 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751623AbWF1Weg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:34:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigel@suspend2.net
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Thu, 29 Jun 2006 00:35:12 +0200
User-Agent: KMail/1.9.3
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606280019.32045.rjw@sisk.pl> <200606280947.58916.nigel@suspend2.net>
In-Reply-To: <200606280947.58916.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606290035.12177.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 28 June 2006 01:47, Nigel Cunningham wrote:
> On Wednesday 28 June 2006 08:19, Rafael J. Wysocki wrote:
> > On Tuesday 27 June 2006 11:35, Nigel Cunningham wrote:
> > > On Tuesday 27 June 2006 19:26, Rafael J. Wysocki wrote:
> > > > > > Now I haven't followed the suspend2 vs swsusp debate very closely,
> > > > > > but it seems to me that your biggest problem with getting this
> > > > > > merged is getting consensus on where exactly this is going. Nobody
> > > > > > wants two different suspend modules in the kernel. So there are two
> > > > > > options - suspend2 is deemed the way to go, and it gets merged and
> > > > > > replaces swsusp. Or the other way around - people like swsusp more,
> > > > > > and you are doomed to maintain suspend2 outside the tree.
> > > > >
> > > > > Generally, I agree, although my understanding of Rafael and Pavel's
> > > > > mindset is that swsusp is a dead dog and uswsusp is the way they want
> > > > > to see things go. swsusp is only staying for backwards compatability.
> > > > > If that's the case, perhaps we can just replace swsusp with Suspend2
> > > > > and let them have their existing interface for uswsusp. Still not
> > > > > ideal, I agree, but it would be progress.
> > > >
> > > > Well, ususpend needs some core functionality to be provided by the
> > > > kernel, like freezing/thawing processes (this is also used by the STR),
> > > > snapshotting the system memory.  These should be shared with the
> > > > in-kernel suspend, be it swsusp or suspend2.
> > >
> > > If I modify suspend2 so that from now on it replaces swsusp, using
> > > noresume, resume= and echo disk > /sys/power/state in a way that's
> > > backward compatible with swsusp and doesn't interfere with uswsusp
> > > support, would you be happy? IIRC, Pavel has said in the past he wishes
> > > I'd just do that, but he's not you of course.
> >
> > That depends on how it's done.  For sure, I wouldn't like it to be done in
> > the "everything at once" manner.
> 
> I'm not sure I get what you're saying. Do you mean you'd prefer them to 
> coexist for a time in mainline? If so, I'd point out that suspend2 uses 
> different parameters at the moment precisely so they can coexist, so that 
> wouldn't be any change.

No, I'd like it to be done in small steps.  Actually as small as possible, so
that it's always clear what we are going to do and why.

If you want to start right now, please submit a bdevs freezing patch without
any non-essential additions.

Greetings,
Rafael
