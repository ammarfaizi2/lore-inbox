Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282850AbRLMKCH>; Thu, 13 Dec 2001 05:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282841AbRLMKB4>; Thu, 13 Dec 2001 05:01:56 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:7176 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S282843AbRLMKBj>; Thu, 13 Dec 2001 05:01:39 -0500
Date: Thu, 13 Dec 2001 10:07:43 +0000
From: Matt <matt@bodgit-n-scarper.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] LVM and (I think) devfs
Message-ID: <20011213100743.A32449@mould.bodgit-n-scarper.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011212170921.A25596@mould.bodgit-n-scarper.com> <200112121726.fBCHQWu15088@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200112121726.fBCHQWu15088@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 10:26:32AM -0700, Richard Gooch wrote:
> matt@bodgit-n-scarper.com writes:
> > Just started playing with LVM, (with devfs), and I've found I can reproduce
> > the attached oops consistently doing the following:
> > 
> > # vgchange -a y
> > # vgchange -a n
> > # vgchange -a y
> > 
> > Once this happens, the lvm becomes unreponsive and requires a reboot to
> > activate it again.
> > 
> > It looks like the oops happens in devfs_open().
> > 
> > I'm using 2.4.17-pre8 with LVM 1.0.1, and the kernel driver from
> > that package.
> 
> Please try kernel 2.4.16 and see if the problem persists. There were
> devfs and minor LVM changes since then. Make sure you at least Cc: me.

I've tried just 2.4.17-pre8, without upgrading the LVM code, and the oops has
gone, I've tried a few repetitions of the above commands and it doesn't fall
over. There might be something iffy in the newer LVM code then...

Cheers

Matt
-- 
"Phase plasma rifle in a forty-watt range?"
"Only what you see on the shelves, buddy"
