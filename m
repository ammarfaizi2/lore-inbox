Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTLJGfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 01:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTLJGfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 01:35:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60811 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261758AbTLJGfr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 01:35:47 -0500
Date: Wed, 10 Dec 2003 06:35:45 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Willy Tarreau <willy@w.ods.org>
Cc: Lincoln Dale <ltd@cisco.com>,
       "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
Message-ID: <20031210063545.GD4176@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet> <20031209134551.GG472@reti> <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet> <5.1.0.14.2.20031210143503.0330f270@171.71.163.14> <20031210061213.GA4368@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210061213.GA4368@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 07:12:13AM +0100, Willy Tarreau wrote:
 
> And what next ? people will ask "marcelo, please include initramfs support,
> it will help us migrating", "marcelo, it's annoying to support both
> module-init-tools and modutils, please accept this patch to change all modules
> to 2.6 format", "marcelo, my usb memory stick is only supported in 2.6, please
> include it in 2.4 so that I can use it to backup my system in case 2.6 crashes",
> "marcelo, please include preempt, it's already in 2.6 and my desktop feels
> smoother with it"...

Heh.  Actually, 99% of initramfs support is there - the only piece missing
is unpack_to_rootfs().  IOW, rootfs is there in the same way as on 2.6,
but it isn't pre-populated.  By now it's too late, but a couple of months
ago it would be a trivial enough for backport - init/initramfs.c is
self-contained and it would be a matter of copying several kilobytes of
stuff in 2.4 + adding a section to ld script (same on all architectures)
+ adding one line in init/main.c.  It's nowhere near as intrusive as other
changes on the list (including dm), but it *is* too late for any of that
stuff in 2.4.
