Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261491AbSKBXBo>; Sat, 2 Nov 2002 18:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSKBXBn>; Sat, 2 Nov 2002 18:01:43 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:28340 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP
	id <S261491AbSKBXBm>; Sat, 2 Nov 2002 18:01:42 -0500
Date: Sat, 2 Nov 2002 16:36:20 -0700
From: Matt Porter <porter@cox.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matt Porter <porter@cox.net>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>, viro@math.psu.edu
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
Message-ID: <20021102163620.A10451@home.com>
References: <3DC38939.90001@pobox.com> <20021102101239.A9442@home.com> <3DC3C1AA.7060602@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DC3C1AA.7060602@zytor.com>; from hpa@zytor.com on Sat, Nov 02, 2002 at 04:14:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 04:14:34AM -0800, H. Peter Anvin wrote:
> Matt Porter wrote:
> > On Sat, Nov 02, 2002 at 03:13:45AM -0500, Jeff Garzik wrote:
> > 
> >>#4 - move mounting root to userspace
> >>
> >>People probably breathed a sigh of relief at patch #3, they will heave a 
> >>bigger sigh for this patch :)   This moves mounting of the root 
> >>filesystem to early userspace, including getting rid of 
> >>NFSroot/bootp/dhcp code in the kernel.
> > 
> > 
> > For those of us who only develop on nfsroot-based systems, does this
> > step include adding userspace network interface configuration and
> > bootp/dhcp client functionality to kinit?  I want to assume that
> > "getting rid of NFSroot/bootp/dhcp" means moving that particular
> > functionality as part of this step.  Just wondering what the
> > short-term impact will be on the poor embedded guys. :)
> > 
> 
> Probably not to kinit, but to early userspace, yes.  There is no real 
> reason to put everything into kinit, and a lot of these things we have 
> already written up as part of the klibc bundle.

Ok, sounds good.  I only mentioned kinit since Jeff's roadmap seemed
to be hazy on whether there was consensus on the single binary approach
versus several binaries.  For maintenance sake, it seems that optional
separate binaries is the only way to go.  Glad to hear that this is the
plan.

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
