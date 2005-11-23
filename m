Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVKWUNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVKWUNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVKWUNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:13:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:13026 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932279AbVKWUNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:13:18 -0500
Date: Wed, 23 Nov 2005 12:12:38 -0800
From: Greg KH <greg@kroah.com>
To: Marc Koschewski <marc@osknowledge.org>
Cc: Ian McDonald <imcdnzl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2-mm1
Message-ID: <20051123201238.GC29402@kroah.com>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <20051123175045.GA6760@stiffy.osknowledge.org> <cbec11ac0511231133m63bec4ddi455fa769dd22906b@mail.gmail.com> <20051123195052.GA7446@stiffy.osknowledge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123195052.GA7446@stiffy.osknowledge.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 08:50:54PM +0100, Marc Koschewski wrote:
> * Ian McDonald <imcdnzl@gmail.com> [2005-11-24 08:33:36 +1300]:
> 
> > On 11/24/05, Marc Koschewski <marc@osknowledge.org> wrote:
> > > Just booted into 2.6.15-rc2-mm1. The 'mouse problem' (as reported earlier) still
> > > persists, moreover, some stuff's now really not gonna work anymore. I logged in
> > > via gdm once and rebooted.
> > >
> > > Ragards,
> > >         Marc
> > >
> > 
> > Mouse problem is userspace. See bug 340202 on the Debian site.
> > 
> > Ian
> 
> ===
> Package: udev
> Version: 0.074-3
> Severity: critical
> Justification: breaks the whole system
> 
> 
> When running Linux 2.6.15-rc1+, the new nested class devices used by the
> input class prevent /dev/input/ from being created, rendering X
> unusable.
> ===
> 
> The problem over here exists _only_ in the -mm series, not plain 2.6.15-rc1
> or 2.6.15-rc2. What's up then!? I use udev 0.74-3 as well. Mysterious...

It's a userspace issue as to how udev is creating the initial device
nodes in Debian.

Odd that this only shows up in the -mm releases, as it should also show
up for you in the -rc1 and -rc2 kernels.

thanks,

greg k-h
