Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbRFMVhx>; Wed, 13 Jun 2001 17:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbRFMVho>; Wed, 13 Jun 2001 17:37:44 -0400
Received: from intranet.resilience.com ([209.245.157.33]:15002 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S262731AbRFMVh3>; Wed, 13 Jun 2001 17:37:29 -0400
Message-ID: <3B27DE0E.84025F41@resilience.com>
Date: Wed, 13 Jun 2001 14:41:34 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mochel <mochel@transmeta.com>
CC: Keith Owens <kaos@ocs.com.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.6-pre3
In-Reply-To: <Pine.LNX.4.10.10106121944470.13607-100000@nobelium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> 
> On Wed, 13 Jun 2001, Keith Owens wrote:
> 
> > tulip_core.c:1756: warning: initialization from incompatible pointer type
> > tulip_core.c:1757: warning: initialization from incompatible pointer type
> 
> This is likely due to the updates to struct pci_driver.
> 
> The suspend callback was changed to take another parameter (the state it
> is to enter) and to return an int.
> 
> The resume callback was changed to return an int.
> 
> Since these callbacks are rarely, if ever used, and since they don't
> cause an actual compile error, the changes were considered benign.
> 

No offense, but that kind of attitude is harmful to the progression of making Linux a good operating system.

Our products NEED suspend/resume to work properly.  PERIOD.  I just spent a few days fixing some bugs in the Tulip driver with suspend/resume, and now your telling me that it's ok to change the API because no one is using it?  So if people ARE using the suspend/resume calls they are just SOL?  Sorry, I don't think things work well that way.

These sort of changes should either wait until 2.5 OR wait until EVERYONE has time to change ALL the drivers so that things don't get broken when you change the API.

2.4.x is supposed to be a "stable" series of kernels.  Thus far, I have NOT been impressed with its stability.

-Jeff

-- 
Jeff Golds
Sr. Software Engineer
jgolds@resilience.com
