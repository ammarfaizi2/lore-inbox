Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbWF2VJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWF2VJe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbWF2VJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:09:33 -0400
Received: from [141.84.69.5] ([141.84.69.5]:29969 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932642AbWF2VJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:09:32 -0400
Date: Thu, 29 Jun 2006 23:08:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] VIDEO_V4L1 shouldn't be user-visible
Message-ID: <20060629210829.GG19712@stusta.de>
References: <20060629192124.GD19712@stusta.de> <1151612317.3728.34.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1151612317.3728.34.camel@praia>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 05:18:37PM -0300, Mauro Carvalho Chehab wrote:

> Adrian,

Hi Mauro,

> Em Qui, 2006-06-29 às 21:21 +0200, Adrian Bunk escreveu:
> > VIDEO_V4L1 is an implementation detail that shouldn't be user-visible.
> 
> Nack. 
> 
> V4L1 is an obsolete api, just like OSS, marked at
> feature-removal-schedule.txt to be removed on July (probably, we might
> need to postpone this, but this is another question). 
> 
> This API have serious trouble on handling video and audio standards used
> on analog world and should be discontinued in favor of V4L2 API. Like
> ALSA have, V4L2 drivers also have a compatibility driver that changes
> calls from legacy userspace applications into newer V4L2 calls (of
> course losing several features, working fine only for a few video
> standards that were supported by V4L1).

I might not understand the issue well enough for getting your point.

My point is:

For users (= people compiling their own kernel), the obsolete in-kernel 
API is an implementation detail.

When configuring the kernel, the important thing for users is to find 
the driver for their hardware, not which internal APIs the driver is 
using.

The userspace visible part VIDEO_V4L1_COMPAT is something different, 
and it shouldn't be hidden.

> Cheers, 
> Mauro.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

