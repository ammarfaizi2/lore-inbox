Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277798AbRKFEMb>; Mon, 5 Nov 2001 23:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281453AbRKFEMV>; Mon, 5 Nov 2001 23:12:21 -0500
Received: from holomorphy.com ([216.36.33.161]:8903 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S277798AbRKFEMM>;
	Mon, 5 Nov 2001 23:12:12 -0500
Date: Mon, 5 Nov 2001 20:10:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] bootmem for 2.5
Message-ID: <20011105201053.E26577@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011102140207.V31822@w-wli.des.beaverton.ibm.com> <1005017025.897.0.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <1005017025.897.0.camel@phantasy>; from rml@tech9.net on Mon, Nov 05, 2001 at 10:23:45PM -0500
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 10:23:45PM -0500, Robert Love wrote:
> The patch is without problem on 2.4.13-ac7.  Free memory increased by
> about 100K: free and dmesg both confirm 384292k vs 384196k.  This is a
> P3-733 on an i815 with 384MB.  Very nice.

> Note that the patch and UP-APIC do not get along.  Some quick debugging
> with William found the cause.  APIC does indeed touch bootmem.  The
> above is thus obviously with CONFIG_X86_UP_APIC unset.

Thank you very much for testing the patch! And doubly so for uncovering
this deficiency, which I will work to correct in short order as soon as
I can get to some UP APIC machines (tomorrow).

It looks like things may be going wrong around line 675 of apic.c,
though I can't say more for sure at the moment.


Thanks,
Bill
-----------------
willir@us.ibm.com
