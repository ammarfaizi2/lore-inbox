Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263467AbRFAMVL>; Fri, 1 Jun 2001 08:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263469AbRFAMUv>; Fri, 1 Jun 2001 08:20:51 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:21916 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263467AbRFAMUs>;
	Fri, 1 Jun 2001 08:20:48 -0400
Message-ID: <3B17889F.3118A564@mandrakesoft.com>
Date: Fri, 01 Jun 2001 08:20:47 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for realthis 
 time)
In-Reply-To: <Pine.LNX.4.33.0106011400550.18082-100000@kenzo.iwr.uni-heidelberg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bogdan Costescu wrote:
> 
> On Fri, 1 Jun 2001, Pete Zaitcev wrote:
> 
> > > But, each time a user cats this proc file, the user is banging the
> > > hardware.  What happens when a malicious user forks off 100 processes to
> > > continually cat this file?  :)
> >
> > Nothing good, probably. Same story as /proc/apm, which only
> > hits BIOS instead (and it's debateable what is better).
> 
> Hmm, the MII related ioctl's in some net drivers (checked for 3c59x,
> tulip, eepro100) are also querying the hardware. And a user is allowed to
> ask for this info (but not able to modify it).

And a malicious user calling those at a high rate is bound to get ugly.

In both of these situations, calling the ioctls without priveleges is
quite useful, so maybe rate-limiting for ioctls and proc files like this
would be a good idea in general.

	Jeff


-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
