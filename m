Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272286AbTHRTRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272273AbTHRTPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:15:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:6876 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272307AbTHRTMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:12:37 -0400
Date: Mon, 18 Aug 2003 12:12:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix up riscom8 driver to use work queues instead of task queueing.
In-Reply-To: <20030818184403.GL24693@gtf.org>
Message-ID: <Pine.LNX.4.44.0308181210430.5929-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Aug 2003, Jeff Garzik wrote:
> 
> schedule_work() is _not_ for that.  As currently implemented, you have
> no guarantees that your schedule_work()-initiated work will even
> begin in this century.

In theory yes. In practice no. schedule_work() tries to wake up the worker 
process immediately, and as such usually gets the work done asap.

But hey, if you want to improve on the drivers, please go wild.  I care 
more about "real life working" than "theoretical but doesn't work".

		Linus

