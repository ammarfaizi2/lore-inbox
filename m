Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314450AbSECPn1>; Fri, 3 May 2002 11:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314453AbSECPn0>; Fri, 3 May 2002 11:43:26 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:63175 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314450AbSECPnZ>; Fri, 3 May 2002 11:43:25 -0400
Date: Fri, 03 May 2002 08:42:59 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>,
        William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <4056814871.1020415377@[10.10.2.3]>
In-Reply-To: <20020503123009.P11414@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Putting the mem_map in highmem would be the first step, after that you
> should be just at at the 90% of work done to make it general purpose,
> you should wrap most actions on the page struct with wrappers and it
> will be quite an invasive change (much more invasive than pte-highmem),
> but it could be done. For this one (unlike pte-highmem) you definitely
> need a config option to select it, most people doesn't need this feature
> enabled because they've less than 8G of ram and also considering it will
> have a significant runtime cost.

Absolutely agree making it an option - other people with smaller memory
configs may also find this useful for enlarging the user address space 
to 3.5Gb for databases et al. with a 8Gb or 16Gb machine.
 
M.


