Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263633AbUD2Gju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbUD2Gju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbUD2Gju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:39:50 -0400
Received: from holomorphy.com ([207.189.100.168]:2946 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263633AbUD2Gjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:39:48 -0400
Date: Wed, 28 Apr 2004 23:38:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marc Singer <elf@buici.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429063827.GI737@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marc Singer <elf@buici.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	brettspamacct@fastclick.com, linux-kernel@vger.kernel.org,
	Russell King <rmk@arm.linux.org.uk>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040429005801.GA21978@buici.com> <40907AF2.2020501@yahoo.com.au> <20040429042047.GB26845@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429042047.GB26845@buici.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 09:20:47PM -0700, Marc Singer wrote:
> Now, I just read a comment you or WLI made about the page cache
> use-once logic.  I wonder if that's the real culprit?  As I wrote to
> Andrew Morton, the kernel seems to be assigning an awful lot of value
> to page cache pages that are used once (or twice?).  I know that it
> would be expensive to perform an HTG aging algorithm where the head of
> the LRU list is really LRU.  Does your patch pursue this line of
> thought?

I don't recall ever having seen an actual pure LRU patch.

The physical scanning infrastructure should be enough to implement most
global replacement algorithms with. It's always good to compare
alternatives. Also, we should have an implementation of random
replacement just as a control case to verify we do better than random.


-- wli
