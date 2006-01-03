Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWACU3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWACU3v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWACU3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:29:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:43140 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964778AbWACU3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:29:49 -0500
Date: Tue, 3 Jan 2006 12:28:00 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: userspace breakage
Message-ID: <20060103202800.GE12617@kroah.com>
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 02:56:16PM -0800, Linus Torvalds wrote:
> 
> On Thu, 29 Dec 2005, Dave Jones wrote:
> > At some point in time it became defacto that certain things like udev, hotplug,
> > alsa-lib, wireless-tools and a bunch of others have to have kept in lockstep
> > with the kernel, and if it breaks, it's your fault for not upgrading
> > your userspace.
> 
> Hmm.. Time for some re-indoctrination?
> 
> We really shouldn't allow that. I know who to blame for udev, who else 
> should I complain to?

Yes, blame me for udev.  Again, a kernel change caused a udev bug to
surface.  This is the problem with 2.6.15 and input devices that are not
the aggregated mice or keyboards.  A one-line fix to udev solved this.

Again, the fault was in udev, not the kernel, I'm not going to prevent
kernel changes from going in, when it is stupid userspace bugs, not the
kernel's fault.

And yes, this is the second time this has happened, it seems that I suck
at userspace programming :)

sorry,

greg k-h
