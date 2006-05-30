Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWE3I3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWE3I3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 04:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWE3I3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 04:29:02 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:25301 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932171AbWE3I3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 04:29:00 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17532.305.602559.660069@gargle.gargle.HOWL>
Date: Tue, 30 May 2006 12:24:17 +0400
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com,
       axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.mm
In-Reply-To: <447BD63D.2080900@yahoo.com.au>
References: <447AC011.8050708@yahoo.com.au>
	<20060529121556.349863b8.akpm@osdl.org>
	<447B8CE6.5000208@yahoo.com.au>
	<20060529183201.0e8173bc.akpm@osdl.org>
	<447BB3FD.1070707@yahoo.com.au>
	<Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
	<447BD31E.7000503@yahoo.com.au>
	<447BD63D.2080900@yahoo.com.au>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:
 > Nick Piggin wrote:
 > > Linus Torvalds wrote:
 > > 
 > >>
 > >> Why do you think the IO layer should get larger requests?
 > > 
 > > 
 > > For workloads where plugging helps (ie. lots of smaller, contiguous
 > > requests going into the IO layer), should be pretty good these days
 > > due to multiple readahead and writeback.
 > 
 > Let me try again.
 > 
 > For workloads where plugging helps (ie. lots of smaller, contiguous
 > requests going into the IO layer), the request pattern should be
 > pretty good without plugging these days, due to multiple page
 > readahead and writeback.

Pageout by VM scanner doesn't benefit from those, and it is still quite
important in some workloads (e.g., mmap intensive).

Nikita.
