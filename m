Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbUANVD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbUANVD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:03:26 -0500
Received: from unthought.net ([212.97.129.88]:46532 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S264472AbUANVC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:02:59 -0500
Date: Wed, 14 Jan 2004 22:02:58 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040114210258.GE22216@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org
References: <40033D02.8000207@adaptec.com> <20040113162636.GT346@unthought.net> <20040113201058.GD1594@srv-lnx2600.matchmail.com> <20040114190701.GD22216@unthought.net> <20040114194052.GK1594@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114194052.GK1594@srv-lnx2600.matchmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 11:40:52AM -0800, Mike Fedyk wrote:
> On Wed, Jan 14, 2004 at 08:07:02PM +0100, Jakob Oestergaard wrote:
> > http://unthought.net/raidreconf/index.shtml
> > 
> > I know of one bug in it which will thoroughly smash user data beyond
> > recognition - it happens when you resize RAID-5 arrays on disks that are
> > not of equal size.  Should be easy to fix, if one tried  :)
> > 
> 
> Hmm, that's if the underlying blockdevs are of differing sizes, right?  I
> usually do my best to make the partitions the same size, so hopefully that
> won't hit for me.  (though, I don't need to resize any arrays right now)

Make backups anyway  :)

> 
> > If you want it in the kernel doing hot-resizing, you probably want to
> > add some sort of 'progress log' so that one can resume the
> > reconfiguration after a reboot - that should be doable, just isn't done
> > yet.
> 
> IIRC, most filesystems don't support hot shrinking if they support
> hot-resizing, so that would only help with adding a disk to an array.

"only" adding disks... How many people actually shrink stuff nowadays?

I'd say having hot-growth would solve 99% of the problems out there.

And I think that's at least a good part of the reason why so few FSes
can actually shrink.  Shrinking can be a much harder problem too, though
- maybe that's part of the reason too.

> 
> > Right now it's entirely a user-space tool and it is not integrated with
> > the MD code to make it do hot-reconfiguration - integrating it with DM
> > and MD would make it truely useful.
> 
> True, but an intermediate step would be to call parted for resizing to the
> exact size needed for a raid0 -> raid5 conversion for example.

Yep.

 / jakob

