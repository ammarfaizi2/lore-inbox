Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbVLFDTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbVLFDTm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 22:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbVLFDTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 22:19:42 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32930
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751556AbVLFDTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 22:19:41 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Mon, 5 Dec 2005 21:19:28 -0600
User-Agent: KMail/1.8
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20051203152339.GK31395@stusta.de> <200512051647.55395.rob@landley.net> <20051205230502.GB12955@kvack.org>
In-Reply-To: <20051205230502.GB12955@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512052119.28706.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 17:05, Benjamin LaHaise wrote:
> On Mon, Dec 05, 2005 at 04:47:55PM -0600, Rob Landley wrote:
> > So no in-kernel filesystem can get this right without help from userspace
> > (even devfs had devfsd), and as soon as you've got a userspace daemon to
> > tell the kernel who is who you might as well do the whole thing there,
> > now that the kernel is exporting everyting _else_ we need to know via
> > /sys and /sbin/hotplug.
>
> /sbin/hotplug is suboptimal.  Even a pretty fast machine is slowed down
> pretty significantly by the ~thousand fork and exec that take place during
> startup.

Why do you need hotplug events on startup?  Can't you just scan /sys for "dev" 
entries do the initial populate of /dev from that?

> For the most common devices -- common tty, pty, floppy, etc that 
> every system has, this is a plain waste of resources -- otherwise known as
> bloat.

I get those from a scan of /sys, and only care about hotplug events that come 
in after that.  (Could just be me...)

>   -ben

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
