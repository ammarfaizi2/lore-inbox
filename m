Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVIGVHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVIGVHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 17:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVIGVHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 17:07:13 -0400
Received: from [67.40.69.52] ([67.40.69.52]:33770 "EHLO morpheus")
	by vger.kernel.org with ESMTP id S932259AbVIGVHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 17:07:12 -0400
Subject: Re: [ham] Re: Gracefully killing kswapd, or any kernel thread
From: Kristis Makris <kristis.makris@asu.edu>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0509071554190.4695@chaos.analogic.com>
References: <1126122068.2744.20.camel@syd.mkgnu.net>
	 <Pine.LNX.4.61.0509071554190.4695@chaos.analogic.com>
Date: Wed, 07 Sep 2005 14:07:12 -0700
Message-Id: <1126127233.2743.25.camel@syd.mkgnu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To kill a kernel thread, you need to make __it__ call exit(). It must be

There must be another way to do it. Perhaps one could have another
process effectively issue the contents of do_exit for the kswapd
task_struct ?

> CODED to do that! You can't do it externally although you can send

I'm clearly asking for the case where the thread wasn't coded to do
that.

> it a signal, after which it will spin forever....

kflushd and keventd don't seem to spin forever. I still haven't
determined what makes kswapd spin forever after it receives the signal.


