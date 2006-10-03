Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030613AbWJCWUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030613AbWJCWUg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030619AbWJCWUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:20:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030613AbWJCWUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:20:17 -0400
Date: Tue, 3 Oct 2006 15:20:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [PATCH take2 0/5] dio: clean up completion phase of
 direct_io_worker()
Message-Id: <20061003152004.ca255c33.akpm@osdl.org>
In-Reply-To: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Oct 2006 16:21:19 -0700 (PDT)
Zach Brown <zach.brown@oracle.com> wrote:

> I've tested these on low end PC drives with aio-stress, the direct IO tests I
> could manage to get running in LTP, orasim, and some home-brew functional
> tests.

I trust a lot of testing was done on blocksize<pagesize filesystems?

And did you test direct-io into and out of hugepages?  `odread' and
`odwrite' from
http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz can be
used to test that.

