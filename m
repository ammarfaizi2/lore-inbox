Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265305AbUF1X7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUF1X7L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 19:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265310AbUF1X7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 19:59:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30155 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265305AbUF1X6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 19:58:54 -0400
Date: Mon, 28 Jun 2004 19:58:22 -0400
From: Jeff Garzik <jgarzik@redhat.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com, arjanv@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       mdharm-usb@one-eyed-alien.net, david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040628235822.GD29883@devserv.devel.redhat.com>
References: <200406271624.18984.oliver@neukum.org> <Pine.LNX.4.44L0.0406271108190.10134-100000@netrider.rowland.org> <20040627154515.GI5526@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040627154515.GI5526@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 05:45:15PM +0200, Andries Brouwer wrote:
> I still prefer writing explicitly what happens.

This is my preference for the implementation of conversions to and from
what I call 'scsi endian'.

Personally, I am pondering creation and use of cpu_to_scsiXX() and
scsiXX_to_cpu() static inline helper functions in my code, because
I'm tired of hand-coding conversions for {read,write}{6,10,12,16}.

Further, the value I see in direct cdb-to-something conversions has
declined over time.  I now prefer the more clear

* scsi-to-u32
* u32-to-something

operations as preferred to a single

* scsi-to-something

operation that's hand-coded and frequently gets corner cases wrong.

	Jeff


