Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264539AbRFJQGj>; Sun, 10 Jun 2001 12:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264540AbRFJQG3>; Sun, 10 Jun 2001 12:06:29 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:64591 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264539AbRFJQGR>; Sun, 10 Jun 2001 12:06:17 -0400
Date: Sun, 10 Jun 2001 12:06:08 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Andrew Morton <andrewm@uow.edu.au>, <hofmang@ibm.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <20010610093838.A13074@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0106101201490.9384-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2001, Russell King wrote:

> Is this a change of requirements for ethernet drivers?  Many other drivers
> do exactly the same (drop the first few packets while they're negotiating
> with a hub), unless they're using 10base2, even back to the days of 2.0
> kernels.

I doubt it's a change, more likely an undocumented requirement.  Look at
it another way: is the transmitter ready when the link is down?  No.
Why?  Because if it does attempt to transmit a packet, it will get a
transmit error, but it can't possibly be an error since it's a normal part
of bringing the link up.  Does this sound reasonable?

		-ben

