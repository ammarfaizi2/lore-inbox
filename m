Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278902AbRKIA26>; Thu, 8 Nov 2001 19:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278890AbRKIA2s>; Thu, 8 Nov 2001 19:28:48 -0500
Received: from holomorphy.com ([216.36.33.161]:31698 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S278902AbRKIA2f>;
	Thu, 8 Nov 2001 19:28:35 -0500
Date: Thu, 8 Nov 2001 16:27:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] bootmem for 2.5
Message-ID: <20011108162712.H26577@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011102140207.V31822@w-wli.des.beaverton.ibm.com> <1005017025.897.0.camel@phantasy> <20011107164400.G26577@holomorphy.com> <1005185194.939.20.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <1005185194.939.20.camel@phantasy>; from rml@tech9.net on Wed, Nov 07, 2001 at 09:06:04PM -0500
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 09:06:04PM -0500, Robert Love wrote:
> Fix does indeed work. Tested on:
> 
> 	P3-733 i815-based, gained 4KB from 384MB
> 	PPro-200 i440FX-based, gained 4KB from 64MB
> 	Celeron-500 i440BX-based, gained 8KB from 512MB
> 
> No problem on any system -- no difference, in fact, except the gain in
> total system memory.  Most importantly, however, the new design is quite
> nice. :>

Terrific! I can't say what an incredible help and relief it is to have
independent verification, and of course, another set of watchful eyes
to help you catch your small mistakes. Thanks again!

On Wed, Nov 07, 2001 at 09:06:04PM -0500, Robert Love wrote:
> I bet the previous ~100KB gain came from not using APIC.  I was
> comparing APIC without new bootmem to new bootmem without APIC.  The
> much more realistic and modest 4KB is within range of what I would
> expect, and I bet if I compared with and without bootmem on a non-APIC
> kernel I would see the same results.

Running with the APICs does require reserving some memory, though often
it seems to come out of what's already reserved, resulting in multiple
reservation messages (in the stock bootmem too).

On Wed, Nov 07, 2001 at 09:06:04PM -0500, Robert Love wrote:
> Would you expect problems from laptops or other things with flakey
> mappings/reservations?  I can test it on a couple of laptops if you
> want...

I don't want to wear you out as a tester. =) Probably the testing most
needed, though, is testing on all the different supported architectures.
Of course, it won't hurt, either.

I've got independent verification on i386, and have verified myself on
IA64. I should roll a fresh patch and call for testers this weekend.


Cheers,
Bill
