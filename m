Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSJWCAB>; Tue, 22 Oct 2002 22:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262697AbSJWCAB>; Tue, 22 Oct 2002 22:00:01 -0400
Received: from [195.223.140.120] ([195.223.140.120]:28204 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262667AbSJWCAA>; Tue, 22 Oct 2002 22:00:00 -0400
Date: Wed, 23 Oct 2002 04:05:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
Message-ID: <20021023020534.GJ11242@dualathlon.random>
References: <20021022184938.A2395@infradead.org> <Pine.LNX.4.44.0210222204330.21530-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210222204330.21530-100000@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 10:19:37PM +0200, Ingo Molnar wrote:
> protection bits. It has been clearly established in the past few years
> empirically that the vma tree approach itself sucks performance-wise for
> applications that have many different mappings.

if you're talking about get_unmapped_area showing up heavy on the
profiling then you're on the wrong track with this, if nobody beats me I
will fix that one soon right, I discussed that some month ago with Claus
Fisher and it's going to be optimized away completely from all
profilings out there (at least as much as mmap). The vma ram overhead
will be still there though, just the cpu overhead will go away, but I
never heard anybody complaining about finishing ram because of vmas yet
(while I know several cases where the lack of O(log(N)) in
get_unmapped_area is a showstopper, the GUI as well suffers badly with
the hundred of librarians but the guis are otherwise idle so it doesn't
matter much for them if the cpu is wasted but they will get a bit lower
latency).

Andrea
