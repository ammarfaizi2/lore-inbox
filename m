Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTLJGNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 01:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTLJGNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 01:13:21 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:47376 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262051AbTLJGNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 01:13:20 -0500
Date: Wed, 10 Dec 2003 07:12:13 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Lincoln Dale <ltd@cisco.com>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
Message-ID: <20031210061213.GA4368@alpha.home.local>
References: <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet> <20031209134551.GG472@reti> <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet> <5.1.0.14.2.20031210143503.0330f270@171.71.163.14>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20031210143503.0330f270@171.71.163.14>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 02:38:02PM +1100, Lincoln Dale wrote:
 
> i concur with this.
> Marcello: try to migrate from a root-on-LVM1/2.4 to LVM2/2.6; it is very 
> painful.  major/minor # changes, more stuff required in initrd, "dm" 
> doesn't appear in 2.6's /proc/partitions . . .
> 
> it is a painful upgrade - probably partly due to lack of 
> tools/documentation on DMs part, but also equally because 2.4->2.6 is a bug 
> jump in a kernel and its exacerbated by LVM1->LVM2 changes...

And what next ? people will ask "marcelo, please include initramfs support,
it will help us migrating", "marcelo, it's annoying to support both
module-init-tools and modutils, please accept this patch to change all modules
to 2.6 format", "marcelo, my usb memory stick is only supported in 2.6, please
include it in 2.4 so that I can use it to backup my system in case 2.6 crashes",
"marcelo, please include preempt, it's already in 2.6 and my desktop feels
smoother with it"...

If 2.6 breaks some backwards compatibility, which kernel do you think should
be changed ? Did anybody submit a patch to include netfilter support in 2.2
in case people would finally switch their firewall back to 2.2 when 2.4 was
unstable ? no.

I agree it's important to be able to upgrade and downgrade with a maximum
safety. But frankly, when you know that your data are so much important when
migrating to the new stable kernel, don't you believe you will backup them
first instead something weird happens ? Then they can be restored into a
common format. That's what I did when I used reiserfs 3.5 on raid5 in 2.2
when I switched to 2.4. Converting everything to ext2 was safer than risking
to rely on a not wide tested compatibility glue between the kernels.

It was the same for XFS imho. All XFS users once had the ability to patch
and install it themselves, and should still have the ability to continue
this way. OK this is annoying, and I too am happy that Marcelo makes it
easier now for them. There also are good reasons in case of DM. But we
should also consider that including any patch regularly breaks other
patches and makes it worse for many other people to include external
patches. So the question remains : what next ? 2.4 is definitely not what
I consider a "stable kernel", it's rather the "most stable actively
developped branch". Getting only bugfixes in it would be fairly simpler
for all people using it in production.

Cheers,
Willy

