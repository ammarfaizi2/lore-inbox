Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262923AbRFMSao>; Wed, 13 Jun 2001 14:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbRFMSaf>; Wed, 13 Jun 2001 14:30:35 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:13990 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262923AbRFMSaV>; Wed, 13 Jun 2001 14:30:21 -0400
Message-ID: <3B27B10F.CBE147BC@vnet.ibm.com>
Date: Wed, 13 Jun 2001 18:29:35 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <200106131717.f5DHHRJ295569@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> Tom Gall writes:
> 
> >   I was wondering if there are any other folks out there like me who
> > have the 256 PCI bus limit looking at them straight in the face?
> 
> I might. The need to reserve bus numbers for hot-plug looks like
> a quick way to waste all 256 bus numbers.

Hi Albert,

  yeah I'll be worring about this one too in time. Two birds with one stone
wouldn't be a bad thing. Hopefully it doesn't translate into needing a
significantly larger stone. 

> > each PHB has an
> > additional id, then each PHB can have up to 256 buses.
> 
> Try not to think of him as a PHB with an extra id. Lots of people
> have weird collections. If your boss wants to collect buses, well,
> that's his business. Mine likes boats. It's not a big deal, really.

Heh.... PHB==Primary Host Bridge  ... but I'll be sure to pass the word onto my
PHB that there's a used greyhound sale... <bah-bum-bum-tshhh>

Anyway, it really is a new id, at least for the implementation on this box. So
PHB0 could have 256 buses, and PHB1 could have 10 buses, PHB2 could have ....
you get the idea.

Hot plug would still have the problem in that it'd have 256 bus numbers in the
namespace of a PHB to manage. Hot plug under a different PHB would have another
256 to play with.

Regards,

Tom

-- 
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc
