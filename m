Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266194AbUFYNAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUFYNAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 09:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUFYNAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 09:00:40 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:20894 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266194AbUFYNAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 09:00:38 -0400
Date: Fri, 25 Jun 2004 08:00:24 -0500
From: Erik Jacobson <erikj@subway.americas.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
In-Reply-To: <20040625124807.GA29937@infradead.org>
Message-ID: <Pine.SGI.4.53.0406250751470.377692@subway.americas.sgi.com>
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com>
 <20040623143801.74781235.akpm@osdl.org> <200406231754.56837.jbarnes@engr.sgi.com>
 <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com>
 <20040625083130.GA26557@infradead.org> <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com>
 <20040625124807.GA29937@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus stance is there shouldn't be new static allocations for 2.6 (I disagree
> with him, btw).  I still wonder why you need your own major for 2.6 but not
> for 2.4.

As I understand it, if you feed serial core a given major, minor, and
device name, it rejects you if there is already a driver using them.

I certainly had failed registrations when I tried to "share" ttyS0.

If my understanding is not correct, I'd be happy to try something else to
see if it would work for us.

The old driver didn't use serial core, so I think it was able to get away
with it.

If the current distributions worked better with a console port using
dynamic minors, I would have no problem using them.  But at this point, if
we tried to use them, we'd just break until /dev was populated with our
device node - missing startup messages and such.

--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
