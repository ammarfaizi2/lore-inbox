Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132545AbRCZSkX>; Mon, 26 Mar 2001 13:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132544AbRCZSkF>; Mon, 26 Mar 2001 13:40:05 -0500
Received: from [166.70.28.69] ([166.70.28.69]:2879 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S132525AbRCZSjv>;
	Mon, 26 Mar 2001 13:39:51 -0500
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andreas Dilger <adilger@turbolinux.com>, LA Walsh <law@sgi.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
In-Reply-To: <20010326181803.F31126@parcelfarce.linux.theplanet.co.uk> <200103261747.f2QHlEX19564@webber.adilger.int> <20010326190945.I31126@parcelfarce.linux.theplanet.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Mar 2001 11:37:52 -0700
In-Reply-To: Matthew Wilcox's message of "Mon, 26 Mar 2001 19:09:45 +0100"
Message-ID: <m17l1cz88v.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> writes:

> On Mon, Mar 26, 2001 at 10:47:13AM -0700, Andreas Dilger wrote:
> > What do you mean by problems 5 years down the road?  The real issue is that
> > this 32-bit block count limit affects composite devices like MD RAID and
> > LVM today, not just individual disks.  There have been several postings
> > I have seen with people having a problem _today_ with a 2TB limit on
> > devices.
> 
> people who can afford 2TB of disc can afford to buy a 64-bit processor.

Currently that doesn't solve the problem as block_nr is held in an int.
And as gcc compiles an int to a 32bit number on a 64bit processor, the
problem still isn't solved.

That at least we need to address.

Eric
