Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWAFBA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWAFBA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWAFBA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:00:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2189 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932362AbWAFBAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:00:25 -0500
Date: Thu, 5 Jan 2006 16:59:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davej@codemonkey.org.uk, airlied@linux.ie
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
Message-Id: <20060105165946.1768f3d5.akpm@osdl.org>
In-Reply-To: <9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com>
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
	<20060105162714.6ad6d374.akpm@osdl.org>
	<9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> > > Everything seems to be fine in console mode, but once I start X and
>  > > then login and KDE starts, the box locks up solid while loading KDE
>  > > (dies every time at the exact same spot, the "Initializing
>  > > peripherals" stage on the KDE splash screen).
>  >
>  > Various people have reported DRM/AGP oopses when starting X.  It's probably
>  > that.
>  >
>  > Could you try reverting git-agpgart.patch?
>  >
>  Just did.

Thanks.

>  Reverted that one patch, then rebuild/reinstalled the kernel
>  (with the same .config) and booted it - no change. It still locks up
>  in the exact same spot.
>  X starts & runs fine (sort of) since I can play around at the kdm
>  login screen all I want, it's only once I actually login and KDE
>  proper starts that it locks up.

Oh bugger.  No serial console/netconsole or such?

Or are you able log in and then quickly do the alt-ctrl-F1 thing, see if we
get an oops?

