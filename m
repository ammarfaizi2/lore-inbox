Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSECQlz>; Fri, 3 May 2002 12:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314697AbSECQly>; Fri, 3 May 2002 12:41:54 -0400
Received: from dsl-213-023-039-070.arcor-ip.net ([213.23.39.70]:3752 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314690AbSECQlw>;
	Fri, 3 May 2002 12:41:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Date: Fri, 3 May 2002 18:41:15 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020503103813.K11414@dualathlon.random> <E173fVi-0002Ic-00@starship> <20020503182028.C14505@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173g7P-0002J6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 May 2002 18:20, Andrea Arcangeli wrote:
> On Fri, May 03, 2002 at 06:02:18PM +0200, Daniel Phillips wrote:
> > and solves 75% of the problem.  It's not just ia32 numa that will benefit
> > from it.  For example, MIPS supports 16K pages in software, which will
> 
> the whole change would be specific to ia32, I don't see the connection
> with mips. There would be nothing to share between ia32 2M pages and
> mips 16K pages.

The topic here is 'page clustering'.  The idea is to use one struct page for
every four 4K page frames on ia32.

-- 
Daniel
