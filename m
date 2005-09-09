Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVIISvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVIISvs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 14:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVIISvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 14:51:48 -0400
Received: from [67.40.69.52] ([67.40.69.52]:36847 "EHLO morpheus")
	by vger.kernel.org with ESMTP id S932576AbVIISvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 14:51:48 -0400
Subject: Re: [ham] Re: Gracefully killing kswapd, or any kernel thread
From: Kristis Makris <kristis.makris@asu.edu>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0509071826180.4951@chaos.analogic.com>
References: <1126122068.2744.20.camel@syd.mkgnu.net>
	 <Pine.LNX.4.61.0509071554190.4695@chaos.analogic.com>
	 <1126127233.2743.25.camel@syd.mkgnu.net>
	 <Pine.LNX.4.61.0509071826180.4951@chaos.analogic.com>
Date: Fri, 09 Sep 2005 11:51:40 -0700
Message-Id: <1126291900.2725.4.camel@syd.mkgnu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 18:36 -0400, linux-os (Dick Johnson) wrote:
> On Wed, 7 Sep 2005, Kristis Makris wrote:
> 
> >> To kill a kernel thread, you need to make __it__ call exit(). It must be

I was able to make it call do_exit(). However, even if I recompile a
kernel to have kswapd issued a do_exit(), I still see from ps:

root         4  0.0  0.0     0    0 ?        Z    06:20   0:00 [kswapd
<defunct>]

Why isn't the task_struct for it gone ?


