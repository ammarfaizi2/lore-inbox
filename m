Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUHaSJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUHaSJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUHaSJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:09:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14044 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266274AbUHaSFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:05:55 -0400
Date: Tue, 31 Aug 2004 14:05:37 -0400
From: Alan Cox <alan@redhat.com>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: Luca Risolia <luca.risolia@studio.unibo.it>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc1-mm1] Disable colour conversion in the CPiA Video Camera driver
Message-ID: <20040831180537.GA22376@devserv.devel.redhat.com>
References: <20040830013201.7d153288.akpm@osdl.org> <20040830133205.GC1727@bytesex> <20040830203117.5acca627.luca.risolia@studio.unibo.it> <20040831175235.GA21130@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831175235.GA21130@bytesex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 07:52:36PM +0200, Gerd Knorr wrote:
> the lack of a sane negotiation of the color formats in the v4l1 API
> you'll get warning printk's even if there is no real problem.  xawtv for

The warning printks are bugs

> example doesn't depend on RGB formats being available, but will try to
> use them (which then generates a warning printk), and failing that

The printk is the bug here. The v4l1 design isnt very good either on this
matter but thats a seperate screwup 8)

> That isn't true.  I can remember that at least one usb webcam driver
> stopped working with xawtv because in-kernel software conversion was
> dropped and xawtv had no support the specific color format used by
> that webcam at that time.

Generally neither party will fix such problems until its forced. So a little
pain ends up neccessary

> In any case the message should make clear the intention of this, i.e.
> that it is planned to drop in-kernel conversion altogether by -- say --
> sept 2005 (should be enougth warning time), that is disabled by default

We've been saying its not allowed since 2000 or so, if nobody listens
whats the point of saying 2005

