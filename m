Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315400AbSEBUUq>; Thu, 2 May 2002 16:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315401AbSEBUUp>; Thu, 2 May 2002 16:20:45 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:53921 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315400AbSEBUUo>;
	Thu, 2 May 2002 16:20:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Thu, 2 May 2002 21:58:11 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E173MEW-00027y-00@starship> <20020502193847.GM32767@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173Mj5-00028l-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 21:38, William Lee Irwin III wrote:
> In the more general case, avoiding an O(fragments) (or sometimes even
> O(mem)) iteration in favor of, say, O(lg(fragments)) or O(cpus)
> iteration when fragments is very large would be an excellent optimization.

In general, config_nonlinear gets it down to O(NR_ZONES), i.e., O(1), by
eliminating the loops across nodes in the non-numa case.

Yes, teaching for_each_* about the 'list length equals one' case would be
worthwhile.

-- 
Daniel
