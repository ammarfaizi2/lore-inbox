Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWJWOWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWJWOWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWJWOWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:22:06 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:40892 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964881AbWJWOWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:22:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Mon, 23 Oct 2006 16:20:55 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231607.17525.rjw@sisk.pl> <453CCE75.20302@yahoo.com.au>
In-Reply-To: <453CCE75.20302@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231620.56459.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 October 2006 16:15, Nick Piggin wrote:
> Rafael J. Wysocki wrote:
> 
> > This case is a bit special.  I don't think it would be right to require every
> > device driver writer to avoid modifying RCU pages from the interrupt
> > context, because that would break the suspend to disk ...
> > 
> > Besides, if there is an RCU page that we _know_ we can use to store the image
> > in it, we can just include this page in the image without copying.  This
> > already gives us one extra free page for the rest of the image and we can
> > _avoid_ creating two images which suspend2 does and which adds a _lot_ of
> > complexity to the code.
> 
> If you don't mind me asking... what are these RCU pages you speak of?
> I couldn't work it out by grepping kernel/power/*

Oops, s/RCU/LRU/g (shame, shame).

Sorry for the confusion.


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
