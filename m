Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135372AbRDRVkH>; Wed, 18 Apr 2001 17:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135375AbRDRVjr>; Wed, 18 Apr 2001 17:39:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55312 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135372AbRDRVjj>;
	Wed, 18 Apr 2001 17:39:39 -0400
Date: Wed, 18 Apr 2001 23:39:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Mike Panetta <mpanetta@applianceware.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel panic when using loop device on kernel 2.4.3
Message-ID: <20010418233928.K501@suse.de>
In-Reply-To: <20010418143316.A955@tetsuo.applianceware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010418143316.A955@tetsuo.applianceware.com>; from mpanetta@applianceware.com on Wed, Apr 18, 2001 at 02:33:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18 2001, Mike Panetta wrote:
> I have been getting kernel panics on kernel 2.4.3
> when using the loop device on a rather regular basis.
> I get a kernel panic but no oops message.  The kernel
> panic message says Kernel panic: invalid blocksize passed
> to set_blocksize.  I saw that someone else on the list
> has had these problems as well but I have seen no response.

There was a response, I just didn't have time to look at the problem
just yet.

> Has a fix for this bug been posted that I have not seen?
> Is the fix in any current stable or AC kernel?  As far as
> I know I am not using any strange options.  The only thing
> I can think of would be that multiple people are using the
> loopback device at the same time.  This is because the box
> that is having the problems is a build server for a custom
> software distro.  We use the loopback filesystem to create
> the boot image.  The box is a 4way xeon with 1GB of ram.

For now, just losetup and don't mount directly -- the previous report
had something to do with that, so I'm assuming that's part of the reason
at least.

> Are there any known issues with loopback and SMP?  Or even
> loopback and multiple mounts/usage?

No

-- 
Jens Axboe

