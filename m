Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWJWXFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWJWXFZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 19:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWJWXFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 19:05:25 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:21943 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932367AbWJWXFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 19:05:24 -0400
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200610231620.56459.rjw@sisk.pl>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	 <200610231607.17525.rjw@sisk.pl> <453CCE75.20302@yahoo.com.au>
	 <200610231620.56459.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 09:05:19 +1000
Message-Id: <1161644719.7033.25.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-10-23 at 16:20 +0200, Rafael J. Wysocki wrote:
> On Monday, 23 October 2006 16:15, Nick Piggin wrote:
> > Rafael J. Wysocki wrote:
> > 
> > > This case is a bit special.  I don't think it would be right to require every
> > > device driver writer to avoid modifying RCU pages from the interrupt
> > > context, because that would break the suspend to disk ...
> > > 
> > > Besides, if there is an RCU page that we _know_ we can use to store the image
> > > in it, we can just include this page in the image without copying.  This
> > > already gives us one extra free page for the rest of the image and we can
> > > _avoid_ creating two images which suspend2 does and which adds a _lot_ of
> > > complexity to the code.
> > 
> > If you don't mind me asking... what are these RCU pages you speak of?
> > I couldn't work it out by grepping kernel/power/*
> 
> Oops, s/RCU/LRU/g (shame, shame).
> 
> Sorry for the confusion.

Ah. I wondered where RCU came into the picture, but was willing to go
with the theory that you knew something I didn't :)

Nigel

