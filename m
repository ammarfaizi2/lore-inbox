Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281267AbRKHCHB>; Wed, 7 Nov 2001 21:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281277AbRKHCGv>; Wed, 7 Nov 2001 21:06:51 -0500
Received: from zero.tech9.net ([209.61.188.187]:34064 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281267AbRKHCGm>;
	Wed, 7 Nov 2001 21:06:42 -0500
Subject: Re: [RFC] bootmem for 2.5
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011107164400.G26577@holomorphy.com>
In-Reply-To: <20011102140207.V31822@w-wli.des.beaverton.ibm.com>
	<1005017025.897.0.camel@phantasy>  <20011107164400.G26577@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 07 Nov 2001 21:06:04 -0500
Message-Id: <1005185194.939.20.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-07 at 19:44, William Lee Irwin III wrote:
> I've managed to reproduce the problem, and I heard from you elsewhere
> that you've verified the fix (although it appeared to reduce the memory
> savings to 4KB).

Fix does indeed work. Tested on:

	P3-733 i815-based, gained 4KB from 384MB
	PPro-200 i440FX-based, gained 4KB from 64MB
	Celeron-500 i440BX-based, gained 8KB from 512MB

No problem on any system -- no difference, in fact, except the gain in
total system memory.  Most importantly, however, the new design is quite
nice. :>

I bet the previous ~100KB gain came from not using APIC.  I was
comparing APIC without new bootmem to new bootmem without APIC.  The
much more realistic and modest 4KB is within range of what I would
expect, and I bet if I compared with and without bootmem on a non-APIC
kernel I would see the same results.

Would you expect problems from laptops or other things with flakey
mappings/reservations?  I can test it on a couple of laptops if you
want...

	Robert Love

