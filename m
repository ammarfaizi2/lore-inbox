Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267694AbSLGBj1>; Fri, 6 Dec 2002 20:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267698AbSLGBj1>; Fri, 6 Dec 2002 20:39:27 -0500
Received: from holomorphy.com ([66.224.33.161]:29073 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267694AbSLGBj0>;
	Fri, 6 Dec 2002 20:39:26 -0500
Date: Fri, 6 Dec 2002 17:46:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Norman Gaywood <norm@turing.une.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021207014643.GW9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Norman Gaywood <norm@turing.une.edu.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <20021206222852.GF4335@dualathlon.random> <20021206232125.GR9882@holomorphy.com> <3DF13A54.927C04C1@digeo.com> <20021207002133.GT9882@holomorphy.com> <1039227589.25062.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039227589.25062.10.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-07 at 00:21, William Lee Irwin III wrote:
>> 16K is reasonable; after that one might as well go all the way.
>> About the only way to cope is amortizing it by cacheing zeroed pages,
>> and that has other downsides.

On Sat, Dec 07, 2002 at 02:19:49AM +0000, Alan Cox wrote:
> Some of the lower end CPU's only have about 12-16K of L1. I don't think
> thats a big problem since those aren't going to be highmem or large
> memory users 

It's an arch parameter, so they'd probably just
#define MMUPAGE_SIZE PAGE_SIZE
Hugh's original patch did that for all non-i386 arches.

Bill
