Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161394AbWALW4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161394AbWALW4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161395AbWALW4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:56:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11016 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161396AbWALW4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:56:04 -0500
Date: Thu, 12 Jan 2006 22:55:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Stuff left for 2.6.16-rc1 (was: [git tree] drm tree for 2.6.16-rc1)
Message-ID: <20060112225554.GG9288@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0601120948270.1552@skynet> <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 10:17:52AM -0800, Linus Torvalds wrote:
> I'm actually somewhat inclined to not pull any more. We've had lots of 
> (hopefully minor) issues for the last few days, and I know that people 
> had DRM issues with the -mm tree (which I assume tracked this tree) not 
> more than a week or so ago.
> 
> IOW, I want to make sure that my tree is somewhat stable again. I don't 
> want -rc1 to be horrible.

FYI - I have one large merge still to come, which is the ARM EABI code.
This allows us to build the kernel with the new ARM ELF ABI toolchain,
and maintain a certain level of compatibility with existing userspace.
(Some ioctls end up breaking, but so far we've only found some ALSA
mixer related ones.)

Of course, if you build with the existing non-EABI toolchain, there's
almost no change to the binary (well, it unfortunately grows by about
160 bytes because the stat64 structure is handled a very slightly
different but 100% compatible way.)

I'm expecting the patches to be re-spun hopefully before -rc1, but this
is dependent on others doing so - and of course it will only impact ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
