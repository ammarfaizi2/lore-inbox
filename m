Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbTKNT1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 14:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTKNT1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 14:27:10 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:3853 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264443AbTKNT1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 14:27:07 -0500
Date: Fri, 14 Nov 2003 20:03:37 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Patrick Beard <patrick@scotcomms.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 VFAT problem
Message-ID: <20031114190337.GA18107@win.tue.nl>
References: <09A92EA4A9D2D51182170004AC96FE7A1216BB@mercury.scotcomms>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09A92EA4A9D2D51182170004AC96FE7A1216BB@mercury.scotcomms>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 11:51:57AM -0000, Patrick Beard wrote:
> > > My fstab entry is;
> > > /dev/sda    /mnt/smedia    vfat    rw,user,noauto    0,0
> > 
> > I would guess that you have to mount /dev/sda1 or perhaps /dev/sda4.
> > Isn't that what you do under 2.4?
> 
> Yes, with 2.4 I used sda1. When I first compiled 2.6 I used sda1 but I got
> the 'wrong fs..' error. This was a clean install of debian so I didn't have
> my original fstab. I checked the web and noticed people using sda. so I
> tried that - same error. In trying to get this to work I've used sda and
> sda1 at different times both gave the same errors.

Good.

Maybe you know already, but just to be sure:
You must use sda if the thing has no partition table.
You must use sda1 if the thing has a partition table.

So, if sda1 works under 2.4, then sda is certainly wrong under 2.6 -
your device would just look like garbage and the error messages are
meaningless.
Only try sda1, and report whatever goes wrong in that case.

Andries

