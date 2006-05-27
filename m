Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWE0HBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWE0HBm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 03:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWE0HBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 03:01:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751430AbWE0HBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 03:01:41 -0400
Date: Sat, 27 May 2006 00:00:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/33] readahead: state based method - aging accounting
Message-Id: <20060527000058.70e84318.akpm@osdl.org>
In-Reply-To: <348710943.27498@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469542.24469@ustc.edu.cn>
	<20060526100426.2faf1367.akpm@osdl.org>
	<348710943.27498@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> > Is this function well-named?  Why does it have "cold" in the name?
> 
>  Because it only sums `nr_inactive', leaving out `nr_active'.

We use the term "cold" to refer to probably-cache-cold pages in the page
allocator.  How about you use "inactive"?
