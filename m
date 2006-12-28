Return-Path: <linux-kernel-owner+w=401wt.eu-S964900AbWL1DuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWL1DuF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 22:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWL1DuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 22:50:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55517 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964900AbWL1DuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 22:50:03 -0500
Date: Wed, 27 Dec 2006 19:49:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drop page cache of a single file
Message-Id: <20061227194959.0ebce0e4.akpm@osdl.org>
In-Reply-To: <1167275845.15989.153.camel@ymzhang>
References: <1167275845.15989.153.camel@ymzhang>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 11:17:25 +0800
"Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:

> Currently, by /proc/sys/vm/drop_caches, applications could drop pagecache,
> slab(dentries and inodes), or both, but applications couldn't choose to
> just drop the page cache of one file. An user of VOD (Video-On-Demand)
> needs this capability to have more detailed control on page cache release.

The posix_fadvise() system call should be used for this.  Probably in
combination with sys_sync_file_range().

