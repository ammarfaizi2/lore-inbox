Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbUANTHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbUANTHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:07:05 -0500
Received: from unthought.net ([212.97.129.88]:52675 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263453AbUANTHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:07:03 -0500
Date: Wed, 14 Jan 2004 20:07:02 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040114190701.GD22216@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org
References: <40033D02.8000207@adaptec.com> <20040113162636.GT346@unthought.net> <20040113201058.GD1594@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113201058.GD1594@srv-lnx2600.matchmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 12:10:58PM -0800, Mike Fedyk wrote:
> On Tue, Jan 13, 2004 at 05:26:36PM +0100, Jakob Oestergaard wrote:
> > The RAID conversion/resize code for userspace exists already, and it
> 
> That's news to me!
> 
> Where is the project that does this?

http://unthought.net/raidreconf/index.shtml

I know of one bug in it which will thoroughly smash user data beyond
recognition - it happens when you resize RAID-5 arrays on disks that are
not of equal size.  Should be easy to fix, if one tried  :)

If you want it in the kernel doing hot-resizing, you probably want to
add some sort of 'progress log' so that one can resume the
reconfiguration after a reboot - that should be doable, just isn't done
yet.

Right now it's entirely a user-space tool and it is not integrated with
the MD code to make it do hot-reconfiguration - integrating it with DM
and MD would make it truely useful.


 / jakob

