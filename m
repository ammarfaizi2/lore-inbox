Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292017AbSBOIz5>; Fri, 15 Feb 2002 03:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292037AbSBOIzr>; Fri, 15 Feb 2002 03:55:47 -0500
Received: from dsl-213-023-043-075.arcor-ip.net ([213.23.43.75]:42370 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292017AbSBOIz3>;
	Fri, 15 Feb 2002 03:55:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [TEST] page tables filling non-highmem
Date: Fri, 15 Feb 2002 09:59:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: rsf@us.ibm.com
In-Reply-To: <20020215045106.GB26322@holomorphy.com>
In-Reply-To: <20020215045106.GB26322@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16beDZ-0002jy-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 15, 2002 05:51 am, William Lee Irwin III wrote:
> The following testcase brought down 2.4.17 mainline on an
> 8-way P-III 700MHz machine with 12GB of RAM. The last thing
> logged from it was a LowFree of 2MB with 9GB of highmem free
> after something like 6-8 hours of pounding away, at which
> time the machine stopped responding (IIRC it was given ~12
> hours to echo another character).
> 
> This testcase is a blatant attempt to fill the direct-mapped
> portion of the kernel virtual address space with process pagetables.
> It was suspected such a thing was happening in another failure scenario
> which is what motivated me to devise this testcase. I believe a fix
> already exists (i.e. aa's ptes in highmem stuff) though I've not yet
> verified its correct operation here.

As you described it to me on irc, this demonstration turns up a
considerably worse problem than just having insufficient space for
page tables - the system locks up hard instead of doing anything
reasonable on page table-related oom.  It's wrong that the system
should behave this way, it is after all, just an oom.

Now that basic stability issues seem to be under control, perhaps
it's time to give the oom problem the attention it deserves?

-- 
Daniel
