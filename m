Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272055AbRHVRt4>; Wed, 22 Aug 2001 13:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272063AbRHVRtp>; Wed, 22 Aug 2001 13:49:45 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:58529
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S272059AbRHVRt0>; Wed, 22 Aug 2001 13:49:26 -0400
Message-ID: <3B83F107.61FD47A0@nortelnetworks.com>
Date: Wed, 22 Aug 2001 13:51:03 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: adding accuracy to random timers on PPC - new config option or 
 runtime overhead?
In-Reply-To: <Pine.LNX.4.33.0108221335000.12521-100000@terbidium.openservices.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignacio Vazquez-Abrams wrote:
> 
> On Wed, 22 Aug 2001, Chris Friesen wrote:
> > I'm looking at putting in PPC-specific code in add_timer_randomness() that would
> > be similar to the x86-specific stuff.
> >
> > The problem is that the PPC601 uses real time clock registers while the other
> > PPC chips use a timebase register, so two different versions will be required.
> > Should I try and identify at runtime which it is (which would be extra
> > overhead), or should I add another config option to the kernel?

> How about determining which one to use at boot time? That way there's no
> overhead, and there's no need to have yet another config option which probably
> doesn't need to be there.

As far as I can see there will still be some extra overhead.  We'd need an extra
conditional that wouldn't be there with the config option.  Granted, one
conditional shouldn't be too expensive, especially since we'll always be picking
the same branch.

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
