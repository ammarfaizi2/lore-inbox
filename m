Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272440AbTGZIQt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 04:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272441AbTGZIQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 04:16:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:44433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272440AbTGZIQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 04:16:48 -0400
Date: Sat, 26 Jul 2003 01:33:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       torvalds@transmeta.com, marcelo@conectiva.com.br
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
Message-Id: <20030726013301.6164e6e4.akpm@osdl.org>
In-Reply-To: <3F1EF7DB.2010805@namesys.com>
References: <3F1EF7DB.2010805@namesys.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> Please look at http://www.namesys.com/benchmarks/v4marks.html

It says "but since most users use ext3 with only meta-data journaling"
which isn't really correct.  ext3's metadata-only journalling mode is
writeback mode.

Most people in fact use ext3's ordered mode, which provides the same data
consistency guarantees on recovery as data journalling.

Please compare against the ext3 in -mm.  It has tweaks which aren't yet
merged, but which will be submitted soon.
