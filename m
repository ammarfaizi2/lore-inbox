Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbVKYTWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbVKYTWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVKYTWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:22:13 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:32432 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751459AbVKYTWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:22:12 -0500
Subject: Re: 2.6.14-rt4: via DRM errors
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <unichrome@shipmail.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>,
       "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>
In-Reply-To: <1132935863.3298.36.camel@localhost.localdomain>
References: <1132807985.1921.82.camel@mindpipe>
	 <8964.192.138.116.230.1132825958.squirrel@192.138.116.230>
	 <1132829378.3473.11.camel@mindpipe>
	 <1132935863.3298.36.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 14:21:55 -0500
Message-Id: <1132946515.20390.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-25 at 16:24 +0000, Alan Cox wrote:
> On Iau, 2005-11-24 at 05:49 -0500, Lee Revell wrote:
> > what kind of lock it is or what it's protecting

> It co-ordinates access between the X server and various 3D clients so
> that they don't step on each others drawing. A shared memory area is
> used to co-ordinate other things like clip lists and what context may
> have been stomped by another user if when you retake the lock you were
> not last holder.
> 
> Precisely what it protects is board dependant

OK.  So it's schedulable.

Any debugging advice for a DRI driver (radeon not via) that I suspect is
causing scheduling blips and audio dropouts due to bus greediness or
other rude behavior?  There seem to be a bunch of timeouts where it will
bit bang the hardware in a loop, should I try reducing these?

Lee

