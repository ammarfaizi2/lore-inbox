Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310740AbSCWBP1>; Fri, 22 Mar 2002 20:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293053AbSCWBPU>; Fri, 22 Mar 2002 20:15:20 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S293041AbSCWBPF>;
	Fri, 22 Mar 2002 20:15:05 -0500
Date: Fri, 22 Mar 2002 16:53:21 -0700
Message-Id: <200203222353.g2MNrLY05466@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: John Jasen <jjasen1@umbc.edu>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, <linux-kernel@vger.kernel.org>
Subject: Re: ORBZ is dead, don't use it...
In-Reply-To: <Pine.SGI.4.31L.02.0203221829420.7868723-100000@irix2.gl.umbc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Jasen writes:
> On Fri, 22 Mar 2002, Richard Gooch wrote:
> 
> > Interesting. When I try to lookup hosts using orbz.org, I just get
> > Non-existent host/domain results (thus mail shouldn't bounce). Why are
> > some people bouncing email?
> 
> Some people set their systems to reject mail from unresolveable
> hosts or domains?

No, this is different. The way these DNS-based blacklists work is that
if the sending IP is listed in the database (because it's a known
spammer/open relay) then DNS lookups succeeds, so the MTA will reject
the mail. If the DNS lookup fails, it implies that the IP address is
*not* in the database, and thus the email is accepted.

Maybe some broken MTA's will reject the message on DNS *transaction
failure* (due to an intermittent network fault or DNS server failure),
but that's not the same as a lookup failure (host not found, but DNS
server responded).

All this is separate from normal reverse DNS lookups of the sending
IP (where many MTA's are configured to reject mail from hosts which
don't resolve).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
