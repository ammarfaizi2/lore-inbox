Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936131AbWLFP5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936131AbWLFP5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936127AbWLFP5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:57:50 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36531 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936100AbWLFP5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:57:49 -0500
Date: Wed, 6 Dec 2006 07:57:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Roland Dreier <rdreier@cisco.com>, Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061206075729.b2b6aa52.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
	<20061205132643.d16db23b.akpm@osdl.org>
	<adaac22c9cu.fsf@cisco.com>
	<20061205135753.9c3844f8.akpm@osdl.org>
	<Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 15:25:22 +0000 (GMT)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> > Maybe the lesson here is that flush_scheduled_work() is a bad function.
> > It should really be flush_this_work(struct work_struct *w).  That is in
> > fact what approximately 100% of the flush_scheduled_work() callers actually
> > want to do.
> 
>  There may be cases where flush_scheduled_work() is indeed needed, but 
> likely outside drivers, and I agree such a specific call would be useful 
> and work here.

I think so too.  But it would be imprudent to hang around waiting for me
to write it :(
