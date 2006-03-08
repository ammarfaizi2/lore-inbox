Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWCHXq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWCHXq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWCHXq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:46:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43790 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932087AbWCHXq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:46:28 -0500
Date: Thu, 9 Mar 2006 00:46:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Kyler Laird <kyler-keyword-lkml00.e701c2@lairds.com>,
       linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: Re: drivers/media/video/saa7115.c misreports max. value of contrast and saturation
Message-ID: <20060308234626.GV4006@stusta.de>
References: <20060215051908.GF13033@snout> <20060308211900.GM4006@stusta.de> <1141858063.3133.2.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1141858063.3133.2.camel@praia>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 07:47:43PM -0300, Mauro Carvalho Chehab wrote:
> Adrian,
> 
> 
> Em Qua, 2006-03-08 às 22:19 +0100, Adrian Bunk escreveu:
> > On Wed, Feb 15, 2006 at 12:19:08AM -0500, Kyler Laird wrote:
> > 
> > > For changes to V4L2_CID_CONTRAST and V4L2_CID_SATURATION, the value is
> > > checked by "if (ctrl->value < 0 || ctrl->value > 127)" yet the maximum
> > > value in v4l2_queryctrl is set to 255 for both of these items.  This
> > > means that programs (like MythTV) which set the contrast and saturation
> > > to the midvalue (127) get *full* contrast and saturation.  (It's not
> > > pretty.)
> > > 
> > > Setting the maximum values to 127 solves this problem.
> > 
> > Mauro, can you comment on this issue?
> Yes. Patch is already available at both git and mercurial trees, fixing
> it for saa7115 and cx25840:
> 
> http://linuxtv.org/hg/v4l-dvb?cmd=changeset;node=b77c2f933b620bccaa751d556c1aa2fca30de7ec;style=gitweb

This patch seems to be 2.1.16 stuff?

> Cheers, 
> Mauro.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

