Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262183AbTC1DqD>; Thu, 27 Mar 2003 22:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262186AbTC1DqC>; Thu, 27 Mar 2003 22:46:02 -0500
Received: from dp.samba.org ([66.70.73.150]:21451 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262183AbTC1DqC>;
	Thu, 27 Mar 2003 22:46:02 -0500
Date: Fri, 28 Mar 2003 14:55:20 +1100
From: Anton Blanchard <anton@samba.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BLKGETSIZE64 is broken (0x80041272)
Message-ID: <20030328035520.GD25721@krispykreme>
References: <20030327214214.B19517@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327214214.B19517@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was adding ioctl translations and found that BLKGETSIZE64
> equals 0x80041272, with wrong size. Apparently, a whole bunch
> of ioctls takes sizeof(sizeof(foo)), which evaluates to 4
> in 32 bit userland, regardless of the size of foo.
> Are we going to do anything about it? At the bare minimum,
> I suggest we add comments near EVERY of the offenders,
> marking them as broken and warning that we are leaving them
> as is for binary compatibility. I compared 2.4 and 2.5, and
> the same breakage is present in both, only more people fell
> for this trap in 2.5, so it obviously needs some action.

Thats old news :) Check out ppc64 and sparc64 ioctl32.c, its ugly but we
have to translate them.

Anton
