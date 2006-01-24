Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWAXXvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWAXXvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWAXXvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:51:06 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:49875 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750869AbWAXXvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:51:05 -0500
Date: Tue, 24 Jan 2006 17:50:07 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
cc: Robin Holt <holt@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <07A9BE6C2CADACD27B259191@[10.1.1.4]>
In-Reply-To: <200601241743.28889.raybry@mpdtxmail.amd.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <200601231758.08397.raybry@mpdtxmail.amd.com>
 <6BC41571790505903C7D3CD6@[10.1.1.4]>
 <200601241743.28889.raybry@mpdtxmail.amd.com>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Those are interesting numbers.  That's pretty much the showcase for
sharing, yeah.

--On Tuesday, January 24, 2006 17:43:28 -0600 Ray Bryant
<raybry@mpdtxmail.amd.com> wrote:

> Of course, it would be more dramatic with a real DB application, but that
> is  going to take a bit longer to get running, perhaps a couple of months
> by the  time all is said and done.

I must mention here that I think most DB performance suites do their forks
up front, then never fork during the test, so fork performance doesn't
really factor in as much.  There are other reasons shared page tables helps
there, though.

> Now I am off to figure out how Andi's mmap() randomization patch
> interacts  with all of this stuff.

mmap() randomization doesn't affect fork at all, since by definition all
regions are at the same address in the child as the parent (ie good for
sharing).  The trickier case is where processes independently mmap() a
region.

Dave

