Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWCHVoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWCHVoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWCHVoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:44:07 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:57617 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751198AbWCHVoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:44:05 -0500
From: Hans Verkuil <hverkuil@xs4all.nl>
To: v4l-dvb-maintainer@linuxtv.org
Subject: Re: [v4l-dvb-maintainer] Re: drivers/media/video/saa7115.c misreports max. value of contrast and saturation
Date: Wed, 8 Mar 2006 22:42:54 +0100
User-Agent: KMail/1.8.91
Cc: Adrian Bunk <bunk@stusta.de>,
       Kyler Laird <kyler-keyword-lkml00.e701c2@lairds.com>,
       mchehab@infradead.org, linux-kernel@vger.kernel.org
References: <20060215051908.GF13033@snout> <20060308211900.GM4006@stusta.de>
In-Reply-To: <20060308211900.GM4006@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603082242.54547.hverkuil@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 22:19, Adrian Bunk wrote:
> On Wed, Feb 15, 2006 at 12:19:08AM -0500, Kyler Laird wrote:
> > For changes to V4L2_CID_CONTRAST and V4L2_CID_SATURATION, the value
> > is checked by "if (ctrl->value < 0 || ctrl->value > 127)" yet the
> > maximum value in v4l2_queryctrl is set to 255 for both of these
> > items.  This means that programs (like MythTV) which set the
> > contrast and saturation to the midvalue (127) get *full* contrast
> > and saturation.  (It's not pretty.)
> >
> > Setting the maximum values to 127 solves this problem.
>
> Mauro, can you comment on this issue?

It's fixed with the patch with subject '[PATCH 08/13] Fix maximum for 
the saturation and contrast controls.' It was posted by Mauro to the 
linux mailinglist a week ago. I hope it will be fixed in 2.6.16, but 
Mauro should know more about it. It was a stupid copy-and-paste bug so 
I see no reason why it shouldn't go in.

> > Please copy me on responses.
> >
> > Thank you.
> >
> > --kyler
>
> cu
> Adrian
