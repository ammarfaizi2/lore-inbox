Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbWHQPfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWHQPfO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWHQPfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:35:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22287 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965152AbWHQPfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:35:12 -0400
Date: Thu, 17 Aug 2006 15:31:38 +0000
From: Pavel Machek <pavel@suse.cz>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@lifl.fr>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-mips@linux-mips.org,
       Thomas =?iso-8859-1?Q?K=F6ller?= <thomas@koeller.dyndns.org>
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
Message-ID: <20060817153138.GE5950@ucw.cz>
References: <200608102318.04512.thomas.koeller@baslerweb.com> <loom.20060812T191433-775@post.gmane.org> <44E09C7E.204@lifl.fr> <200608142126.29171.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608142126.29171.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If so then the Video4Linux2 API is still the best way to implement the
> > protocol to pass data between the user-space programs and the driver.
> > The V4L2 API doesn't says that the camera must be far away from the
> > processor, it can work for USB webcams, for Firewire video camera, PCI
> > TV tuners, and probably also for your device. Using the V4L2 not only
> > has the advantage of being a well tested API for communicating video
> > related information with the user-space but it also buys you the fact
> > that any program available on Linux for video should be able to directly
> > detect and use the captor!
> 
> Sorry, but no. The camera has been designed to be used in industrial
> control applications, such as quality assurance. Think of an automated
> inspection of a certain product, where the inspection is integrated
> into the production process. Faulty products are sorted out. For this to
> work it is absolutely necessary to get the maximum speed (image frames
> per second) out of the hardware, so image acquisition and processing
> must be carried out in parallel. The way to achieve this is have the
> driver manage a queue of image buffers to fill, so it will continue
> grabbing images even if no read operation is currently pending. Also,
> the ability to attach user-specific context information to every buffer
> is essential.

Well, I guess v4l api will need to be improved, then. That is still
not a reason to introduce completely new api...

-- 
Thanks for all the (sleeping) penguins.
