Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268048AbUIAXOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268048AbUIAXOA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIAXIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:08:17 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:42565 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264726AbUIAXFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:05:37 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
X-Message-Flag: Warning: May contain useful information
References: <1094052981.431.7160.camel@cube> <52vfey0ylu.fsf@topspin.com>
	<20040901215314.GC26044@mellanox.co.il>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 01 Sep 2004 15:58:44 -0700
In-Reply-To: <20040901215314.GC26044@mellanox.co.il> (Michael S. Tsirkin's
 message of "Thu, 2 Sep 2004 00:53:14 +0300")
Message-ID: <52sma1y4t7.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2004 22:58:44.0985 (UTC) FILETIME=[3BABF690:01C49077]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> Yes, this is exactly right.  One issue raised by this
    Roland> thread is that the ioctl32 compatibility code only allows
    Roland> one compatibility handler per ioctl number.  It seems that
    Roland> this creates all sorts of possibilities for mayhem because
    Roland> it makes the ioctl namespace global in scope in some
    Roland> situations.  Does anyone have any thoughts on if/how this
    Roland> should be addressed?

    Michael> Thats what my original patch attempts to address
    Michael> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0409.0/0025.html
    Michael> What do you think?

That patch seems somewhat orthogonal to the issue I raised.  You're
just fixing the problem for devices that don't use the ioctl32 compat
layer.

 - Roland
