Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbUKVWmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbUKVWmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbUKVWj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:39:57 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:5092 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261156AbUKVWjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:39:24 -0500
Date: Mon, 22 Nov 2004 14:39:19 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: deferred rss update instead of sloppy rss
In-Reply-To: <41A26910.7090401@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0411221436570.22895@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <41A26910.7090401@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Nick Piggin wrote:

> Deferred rss might be a practical solution, but I'd prefer this if it can
> be made workable.

Both results in an additional field in task_struct that is going to be
incremented when the page_table_lock is not held. It would be possible
to switch to looping in procfs later. The main question with this patchset
is:

How and when can we get this get into the kernel?

