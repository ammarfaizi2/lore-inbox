Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWIECRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWIECRZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 22:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWIECRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 22:17:25 -0400
Received: from peabody.ximian.com ([130.57.169.10]:449 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S964953AbWIECRY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 22:17:24 -0400
Subject: Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
From: Adam Belay <abelay@novell.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, ACPI ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20060904125921.GB6279@ucw.cz>
References: <1156884681.1781.120.camel@localhost.localdomain>
	 <20060904125921.GB6279@ucw.cz>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 22:19:49 -0400
Message-Id: <1157422789.3777.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, 2006-09-04 at 12:59 +0000, Pavel Machek wrote:
> Hi!
> 
> > This patch improves the ACPI c-state selection algorithm.  It also
> > includes a major cleanup and simplification of the processor idle code.
> 
> Nice!
> 
> > @@ -1009,7 +883,7 @@
> >  
> >  	seq_printf(seq, "active state:            C%zd\n"
> >  		   "max_cstate:              C%d\n"
> > -		   "bus master activity:     %08x\n",
> > +		   "bus master activity:     %d\n",
> >  		   pr->power.state ? pr->power.state - pr->power.states : 0,
> >  		   max_cstate, (unsigned)pr->power.bm_activity);
> >  
> 
> This changes kernel - user interface. You should change the field
> description, or keep it in hex...

Good catch!  Essentially the field now counts the number of times bus
master activity was detected, rather than bitshifting.  I'll change its
name in the next iteration.

> 
> BTW will you be on september's labs conference?

It's not currently in my plans, but I'd love to attend one at some
point.

> 
> 							Pavel

Thanks for the comments.

Regards,
Adam


