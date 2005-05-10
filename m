Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVEJVwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVEJVwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVEJVwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:52:15 -0400
Received: from 1-1-2-5a.f.sth.bostream.se ([81.26.255.57]:55937 "EHLO
	1-1-2-5a.f.sth.bostream.se") by vger.kernel.org with ESMTP
	id S261768AbVEJVvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:51:41 -0400
Date: Tue, 10 May 2005 23:51:04 +0200 (CEST)
From: Per Liden <per@fukt.bth.se>
X-X-Sender: per@1-1-2-5a.f.sth.bostream.se
To: Greg KH <gregkh@suse.de>
cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
In-Reply-To: <20050509232207.GB24238@suse.de>
Message-ID: <Pine.LNX.4.63.0505101843050.2271@1-1-2-5a.f.sth.bostream.se>
References: <20050506212227.GA24066@kroah.com>
 <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se>
 <20050509232207.GB24238@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, Greg KH wrote:

> On Mon, May 09, 2005 at 12:52:02AM +0200, Per Liden wrote:
> > On Fri, 6 May 2005, Greg KH wrote:
> > 
> > [...]
> > > Now, with the 2.6.12-rc3 kernel, and a patch for module-init-tools, the
> > > USB hotplug program can be written with a simple one line shell script:
> > > 	modprobe $MODALIAS
> > 
> > Nice, but why not just convert all this to a call to 
> > request_module($MODALIAS)? Seems to me like the natural thing to do.
> 
> Because that's not the only thing that the hotplug event causes to
> happen. It's easier to have userspace decide what to do with this 
> instead.

Sure, the hotplug event could still be issued so that userspace could do 
magic things when it wants to (load firmware or whatever), but since the 
kernel already has all the infrastructure in place to load modules on 
demand, and it's used all over the place, it doesn't make sense to use a 
completely different approach here.

Also, since most people never need to do anything except modprobe, they 
can still have a working system without any scripts what so ever... again 
just like normal on demand module loading.

/Per
