Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319583AbSIHJJk>; Sun, 8 Sep 2002 05:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319585AbSIHJJk>; Sun, 8 Sep 2002 05:09:40 -0400
Received: from holomorphy.com ([66.224.33.161]:23225 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319583AbSIHJJj>;
	Sun, 8 Sep 2002 05:09:39 -0400
Date: Sun, 8 Sep 2002 02:12:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, ciarrocchi@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
Message-ID: <20020908091206.GL888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, akpm@digeo.com,
	ciarrocchi@linuxmail.org, linux-kernel@vger.kernel.org
References: <3D7B0177.6A35FE9B@digeo.com> <20020908.003700.07120871.davem@redhat.com> <20020908082821.GK888@holomorphy.com> <20020908.012526.48196975.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020908.012526.48196975.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 8 Sep 2002 01:28:21 -0700
>    But if this were truly the issue, the allocation and deallocation
>    overhead for pagetables should show up as additional pressure
>    against zone->lock.

On Sun, Sep 08, 2002 at 01:25:26AM -0700, David S. Miller wrote:
> The big gain is not only that allocation/free is cheap, also
> page table entries tend to hit in cpu cache for even freshly
> allocated page tables.
> I think that is the bit that would show up in the mmap lmbench
> test.

I'd have to doublecheck to see how parallelized lat_mmap is. My
machines are considerably more sensitive to locking uglies than cache
warmth. (They're taking my machines out, not just slowing them down.)
Cache warmth goodies are certainly nice optimizations, though.


Cheers,
Bill
