Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQLDStk>; Mon, 4 Dec 2000 13:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbQLDStb>; Mon, 4 Dec 2000 13:49:31 -0500
Received: from fw-west.west.akamai.com ([63.102.156.130]:35823 "EHLO
	akamai.com") by vger.kernel.org with ESMTP id <S129602AbQLDStW>;
	Mon, 4 Dec 2000 13:49:22 -0500
Date: Mon, 4 Dec 2000 10:23:26 -0800 (PST)
From: Rajeev Bector <rajeev@akamai.com>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: Rajeev Bector <rajeev@akamai.com>, linux-kernel@vger.kernel.org
Subject: Re: using TOS as a key in route cache
In-Reply-To: <3A2B750C.924E6CAB@idb.hist.no>
Message-ID: <Pine.LNX.4.10.10012041020200.21145-100000@marjorie.sanmateo.akamai.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
 Thanks for your reply. But this can create problems
in some of the cases. For example, "scp" over TCP
starts with TOS 0, then goes to 8 (bulk data). What
happens is that when RTOs are cached, they are
updated for TOS 8 and not for TOS 0, therefore a
new connection does not pick up the cached RTO.

Does this make sense ?

Thanks,
-- Rajeev
(Again, please cc replies to rajeev@akamai.com)

On Mon, 4 Dec 2000, Helge Hafting wrote:

> Rajeev Bector wrote:
> > 
> > Guys
> >  I am looking for a reason as to why we want
> > to have different route cache entries for
> > different IP ToS types. Does anyone have
> > any insight into this ?
> 
> Because you may want to route time-critical stuff like
> video through a dedicated fast network and slow stuff like email
> through another.  Such a setup prevents an email burst from 
> disrupting video.
> 
> There are many similiar uses.
> 
> Helge Hafting
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
