Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSHCUxc>; Sat, 3 Aug 2002 16:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317759AbSHCUxc>; Sat, 3 Aug 2002 16:53:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8119 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317755AbSHCUxb>;
	Sat, 3 Aug 2002 16:53:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Sat, 3 Aug 2002 16:53:39 -0400
User-Agent: KMail/1.4.1
Cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Gerrit Huizenga <gh@us.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <15691.22889.22452.194180@napali.hpl.hp.com> <200208031441.29353.frankeh@watson.ibm.com> <15692.12781.344389.519591@napali.hpl.hp.com>
In-Reply-To: <15692.12781.344389.519591@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208031653.39827.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 03:41 pm, David Mosberger wrote:
> >>>>> On Sat, 3 Aug 2002 14:41:29 -0400, Hubertus Franke
> >>>>> <frankeh@watson.ibm.com> said:
>
>   Hubertus> But I'd like to point out that superpages are there to
>   Hubertus> reduce the number of TLB misses by providing larger
>   Hubertus> coverage. Simply providing page coloring will not get you
>   Hubertus> there.
>
> Yes, I agree.
>
> It appears that Juan Navarro, the primary author behind the Rice
> project, is working on breaking down the superpage benefits they
> observed.  That would tell us how much benefit is due to page-coloring
> and how much is due to TLB effects.  Here in our lab, we do have some
> (weak) empirical evidence that some of the SPECint benchmarks benefit
> primarily from page-coloring, but clearly there are others that are
> TLB limited.
>
> 	--daivd

Cool. 
Does that mean that BSD already has page coloring implemented ?

The agony is: 
Page Coloring helps to reduce cache conflicts in low associative caches
while large pages may reduce TLB overhead.

One shouldn't rule out one for the other, there is a place for both.

How did you arrive to the (weak) empirical evidence?
You checked TLB misses and cache misses and turned
page coloring on and off and large pages on and off?

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
