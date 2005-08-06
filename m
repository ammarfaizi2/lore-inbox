Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVHFTVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVHFTVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 15:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbVHFTVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 15:21:12 -0400
Received: from xenotime.net ([66.160.160.81]:40342 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S261164AbVHFTVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 15:21:11 -0400
Date: Sat, 6 Aug 2005 12:21:08 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "James C. Georgas" <jgeorgas@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Freeing a dynamic struct cdev
Message-Id: <20050806122108.4a458c68.rdunlap@xenotime.net>
In-Reply-To: <1123334776.29913.3.camel@Tachyon.home>
References: <1123334776.29913.3.camel@Tachyon.home>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Aug 2005 09:26:15 -0400 James C. Georgas wrote:

> If I allocate a struct cdev using cdev_alloc(), what function do I call
> to free it when I'm done with it?

Should be cdev_put(), which calls kobject_put(), which implements
ref counting (using krefs), so that when the last reference is
going away, the object will be removed.

---
~Randy
