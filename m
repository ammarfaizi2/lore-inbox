Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272232AbTHRSt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272236AbTHRSt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:49:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:6606 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272232AbTHRStz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:49:55 -0400
Date: Mon, 18 Aug 2003 11:47:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix up riscom8 driver to use work queues instead of task queueing.
In-Reply-To: <20030818192831.E1737@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308181141010.5929-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Aug 2003, Russell King wrote:
> 
> Of course, the more correct approach is for someone to convert them to
> use the new serial driver core (and fix the driver core interface to
> allow them to work with it.)

Hey, I'm all for that for 2.7.x. In the meantime, they've been broken for 
a year, so let's just try to fix them up into a "limping along" state.

I don't have the hardware either, but at least now they should be testable
on UP configurations (SMP is generally still broken due to the drivers
expecting to be able to disable all interrups globally instead of using
proper locking).

I'd be interested to hear whether the dang things work. Of course, there 
probably aren't that many people around with the hardware any more. I 
could just have added them to the BROKEN list, but since they _might_ work 
it seemed like a better idea to be hugely optimistic instead ;)

		Linus

