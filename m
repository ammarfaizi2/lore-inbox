Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289877AbSA2VAF>; Tue, 29 Jan 2002 16:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289882AbSA2U7z>; Tue, 29 Jan 2002 15:59:55 -0500
Received: from holomorphy.com ([216.36.33.161]:57502 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289877AbSA2U7p>;
	Tue, 29 Jan 2002 15:59:45 -0500
Date: Tue, 29 Jan 2002 13:01:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Momchil Velikov <velco@fadata.bg>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com
Subject: Re: Note describing poor dcache utilization under high memory pressure
Message-ID: <20020129130116.L899@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Momchil Velikov <velco@fadata.bg>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Oliver Xymoron <oxymoron@waste.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Josh MacDonald <jmacd@CS.Berkeley.EDU>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	reiserfs-list@namesys.com, reiserfs-dev@namesys.com
In-Reply-To: <20020129123932.K899@holomorphy.com> <Pine.LNX.4.33.0201291240180.1223-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0201291240180.1223-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 29, 2002 at 12:49:24PM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 12:49:24PM -0800, Linus Torvalds wrote:
> I really isn't a co-incidence. The reason so many architectures have page
> table trees is that most architects try to make good decisions, and a tree
> layout is a simple and efficient data structure that maps well to both
> hardware and to usage patterns.

No debate there.

On Tue, Jan 29, 2002 at 12:49:24PM -0800, Linus Torvalds wrote:
> Hashed page tables are incredibly naive, and perform badly for build-up
> and tear-down (and mostly have horrible cache access patterns). At least
> in some version of the UltraSparc, the Linux tree-based software TLB fill
> outperformed the Solaris version, even though the Solaris version was
> handtuned assembly and used hardware acceleration for the hash
> computations. That should tell you something.

Given this, it appears less useful to play with the representations.
There also appears to be some other material on this subject which
you yourself have written. I'll review that for my own enlightenment,
and regardless, I'll focus on something else.

Thanks again,
Bill
