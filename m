Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWCIAWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWCIAWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWCIAWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:22:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25832 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932628AbWCIAWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:22:15 -0500
Subject: Re: drivers/media/video/saa7115.c misreports max. value of
	contrast and saturation
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Kyler Laird <kyler-keyword-lkml00.e701c2@lairds.com>,
       linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
In-Reply-To: <20060308234626.GV4006@stusta.de>
References: <20060215051908.GF13033@snout> <20060308211900.GM4006@stusta.de>
	 <1141858063.3133.2.camel@praia>  <20060308234626.GV4006@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 08 Mar 2006 21:21:19 -0300
Message-Id: <1141863679.3133.13.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2006-03-09 às 00:46 +0100, Adrian Bunk escreveu:
> On Wed, Mar 08, 2006 at 07:47:43PM -0300, Mauro Carvalho Chehab wrote:
> > Adrian,
> > 
> > 
> > Em Qua, 2006-03-08 às 22:19 +0100, Adrian Bunk escreveu:
> > > On Wed, Feb 15, 2006 at 12:19:08AM -0500, Kyler Laird wrote:
> > > 
> > > > For changes to V4L2_CID_CONTRAST and V4L2_CID_SATURATION, the value is
> > > > checked by "if (ctrl->value < 0 || ctrl->value > 127)" yet the maximum
> > > > value in v4l2_queryctrl is set to 255 for both of these items.  This
> > > > means that programs (like MythTV) which set the contrast and saturation
> > > > to the midvalue (127) get *full* contrast and saturation.  (It's not
> > > > pretty.)
> > > > 
> > > > Setting the maximum values to 127 solves this problem.
> > > 
> > > Mauro, can you comment on this issue?
> > Yes. Patch is already available at both git and mercurial trees, fixing
> > it for saa7115 and cx25840:
> > 
> > http://linuxtv.org/hg/v4l-dvb?cmd=changeset;node=b77c2f933b620bccaa751d556c1aa2fca30de7ec;style=gitweb
> 
> This patch seems to be 2.1.16 stuff?
I think you meant 2.6.16 :) Yes, it is. I've already sent an email to
Linus for him to pull it, among with some other pending patches.
> 
> > Cheers, 
> > Mauro.
> 
> cu
> Adrian
> 
Cheers, 
Mauro.

