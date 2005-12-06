Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVLFFtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVLFFtq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 00:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVLFFtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 00:49:46 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:5796 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S964866AbVLFFtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 00:49:45 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Mon, 5 Dec 2005 23:49:32 -0600
User-Agent: KMail/1.8
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20051203152339.GK31395@stusta.de> <200512052119.28706.rob@landley.net> <20051206033236.GC15428@kvack.org>
In-Reply-To: <20051206033236.GC15428@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512052349.33446.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 21:32, Benjamin LaHaise wrote:
> On Mon, Dec 05, 2005 at 09:19:28PM -0600, Rob Landley wrote:
> > > /sbin/hotplug is suboptimal.  Even a pretty fast machine is slowed down
> > > pretty significantly by the ~thousand fork and exec that take place
> > > during startup.
> >
> > Why do you need hotplug events on startup?  Can't you just scan /sys for
> > "dev" entries do the initial populate of /dev from that?
>
> That's my point: I don't.  Yet the kernel tries to exec /sbin/hotplug on
> startup around 1000 times.
>
>   -ben

At what stage?  If it's initramfs, then don't have one on initramfs.  (Not by 
default anyway, add a symlink when you're ready to start caring, or write the 
correct path to /proc/sys/heeeeeeere's_hotplog.)

Failure to exec 1000 times shouldn't take too long.  I have shell scripts that 
fork and exec 1000 times in under a second, and they're actually doing 
something.

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
