Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSKNVEl>; Thu, 14 Nov 2002 16:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSKNVEl>; Thu, 14 Nov 2002 16:04:41 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:22511 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S265243AbSKNVEj>; Thu, 14 Nov 2002 16:04:39 -0500
Date: Thu, 14 Nov 2002 16:11:34 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021114161134.E20258@redhat.com>
References: <20021113184555.B10889@redhat.com> <20021114203035.GF22031@holomorphy.com> <20021114154809.D20258@redhat.com> <20021114210220.GM23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021114210220.GM23425@holomorphy.com>; from wli@holomorphy.com on Thu, Nov 14, 2002 at 01:02:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oracle does not run as root, so they can't even use the syscalls 
directly.  At least with hugetlbfs we can chmod the filesystem to be 
owned by the oracle user.

		-ben

On Thu, Nov 14, 2002 at 01:02:20PM -0800, William Lee Irwin III wrote:
> On Thu, Nov 14, 2002 at 12:30:35PM -0800, William Lee Irwin III wrote:
> >> The main reason I haven't considered doing this is because they already
> >> got in and there appears to be a user (Oracle/IA64).
> 
> On Thu, Nov 14, 2002 at 03:48:09PM -0500, Benjamin LaHaise wrote:
> > Not in shipping code.  Certainly no vendor kernels that I am aware of 
> > have shipped these syscalls yet either, as nearly all of the developers 
> > find them revolting.  Not to mention that the code cleanups and bugfixes 
> > are still ongoing.
> 
> This is a bit out of my hands; the support decision came from elsewhere.
> I have to service my users first, and after that, I don't generally want
> to stand in the way of others. In general it's good to have minimalistic
> interfaces, but I'm not a party to the concerns regarding the syscalls.
> My direct involvement there has been either of a kernel janitor nature,
> helping to adapt it to Linux kernel idioms, or reusing code for hugetlbfs.
> 
> I guess the only real statement left to make is that hugetlbfs (or my
> participation/implementation of it) was not originally intended to
> compete with the syscalls, though there's a lot of obvious overlap
> (which I tried to exploit by means of code reuse).
> 
> Bill

-- 
"Do you seek knowledge in time travel?"
