Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318074AbSG2Axp>; Sun, 28 Jul 2002 20:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSG2Axo>; Sun, 28 Jul 2002 20:53:44 -0400
Received: from holomorphy.com ([66.224.33.161]:18090 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318074AbSG2Axn>;
	Sun, 28 Jul 2002 20:53:43 -0400
Date: Sun, 28 Jul 2002 17:56:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
Message-ID: <20020729005649.GT25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D448808.CF8D18BA@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 05:10:48PM -0700, Andrew Morton wrote:
> - Few pages use ->private for much.  Hash for it.  4(ish) bytes
>   saved.

Do you know an approximate reasonable constant of proportionality
for how many pages have ->private attached?


On Sun, Jul 28, 2002 at 05:10:48PM -0700, Andrew Morton wrote:
> - Remove the rmap chain (I just broke ptep_to_address() anyway).  4 bytes
>   saved.  struct page is now 20 bytes.

How did ptep_to_address() break? I browsed over your latest changes and
missed the bit where that fell apart. I'll at least take a stab at fixing
it up until the other bits materialize.



Cheers,
Bill
