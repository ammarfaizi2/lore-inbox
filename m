Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266739AbUG1AMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266739AbUG1AMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 20:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUG1AMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 20:12:25 -0400
Received: from click.bur.st ([203.34.17.217]:25118 "EHLO click.bur.st")
	by vger.kernel.org with ESMTP id S266739AbUG1AMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 20:12:22 -0400
Date: Wed, 28 Jul 2004 08:12:18 +0800
From: Trent Lloyd <lathiat@bur.st>
To: mru@kth.se, linux-kernel@vger.kernel.org
Subject: Re: Future devfs plans (sorry for previous incomplete message)
Message-ID: <20040728001217.GC31618@thump.bur.st>
References: <200407261737.i6QHbff04878@freya.yggdrasil.com> <20040726062435.GA22559@thump.bur.st> <yw1xzn5nrv6o.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xzn5nrv6o.fsf@kth.se>
User-Agent: Mutt/1.3.28i
X-Random-Number: 8.96272388128626e+197
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see your point, but I wonder how it differs from the current devfs
implementation (i don't know how it works in these cases)

> Trent Lloyd <lathiat@bur.st> writes:
> 
> > Wouldn't a possible solution to do this to develop an extension to tmpfs to
> > catch files accessed that don't exist etc and use that in conjuction
> > with udev?
> 
> There is a problem with that scheme.  Imagine that a program attempts
> to access a non-existing device.  The special fs would call modprobe
> or similar which would load the correct module.  Loading this module
> would cause hotplug events upon which udev would create the device
> node.  However, all this is asynchronous.  The special fs could wait
> for a while for the device to appear, but this doesn't quite look like
> a nice solution.  The exit status of modprobe can't be used, since
> even if the module loads perfectly it might not cause the requested
> device to be created.  Even if it does, there will be some delay from
> the module being loaded to udev creating the device node, so how long
> should the kernel wait for the device to appear?  I haven't thought
> about it further, but I smell races here.
> 
> -- 
> M?ns Rullg?rd
> mru@kth.se
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Trent Lloyd <lathiat@bur.st>
Bur.st Networking Inc.
