Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUGXRd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUGXRd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 13:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUGXRd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 13:33:58 -0400
Received: from mail.autoweb.net ([198.172.237.26]:22290 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261638AbUGXRd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 13:33:56 -0400
Date: Sat, 24 Jul 2004 13:33:50 -0400
From: Ryan Anderson <ryan@michonline.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040724173350.GA24303@michonline.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1090604517.13415.0.camel@lucy> <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost> <20040724150838.GA24765@plexity.net> <1090683953.2296.78.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090683953.2296.78.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2004 at 11:45:53AM -0400, Robert Love wrote:
> On Sat, 2004-07-24 at 08:08 -0700, Deepak Saxena wrote:
> > > The easiest way to avoid that is simply to use a name similar to the
> > > path name.
> > 
> > What is the path name of a device from the kernels point of view?
> > Since device naming in /dev is left up to userland now, it has to
> > be something else that the kernel is aware of.
> 
> I might not of been clear - path name of the file in the kernel source
> tree.  So if you add an event to fs/open.c the path is
> "/org/kernel/fs/open".  This is a pretty generic naming scheme that
> ensures names will be unique within the kernel and will not conflict
> with names outside the kernel (e.g. the global URI space of whatever is
> used in user-space).

So, when I do something like
	mv kernel/fs/x.c kernel/fs/y.c

I also have to do:
	sed -i -e s/kernel\/fs\/x.c/kernel\/fs\/y.c/g kernel/fs/y.c

Won't that, in effect, be breaking a defacto userspace API by changing
message paths, even if the semantic meaning, cause and possible
resolutions are all unchanged?

-- 

Ryan Anderson
