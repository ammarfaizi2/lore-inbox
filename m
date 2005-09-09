Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbVIIEqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVIIEqU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 00:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVIIEqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 00:46:20 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:59085 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750926AbVIIEqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 00:46:19 -0400
Date: Fri, 9 Sep 2005 00:44:47 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13] x86: check host bridge when applying
  vendor quirks
To: Andi Kleen <ak@suse.de>
Cc: Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509090046_MC3-1-A99D-882E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200509090447.10118.ak@suse.de>

On Fri, 9 Sep 2005 at 04:47:09 +0200, Andi Kleen wrote:

> On Friday 09 September 2005 04:33, Chuck Ebbert wrote:
> > I was looking at the i386 ACPI early quirk code and x86_64 equivalent
> > and it seems to me it should be checking the host bridge vendor, not
> > the one for various PCI bridges.  Nvidia might release some kind of
> > PCI card with an embedded bridge that would break this code, for
> > example.  I made this patch but I can't test it:
>
> It's wrong. On AMD K8 systems the host bridge is always from
> AMD because the Northbridge is part of the CPU.

It's at least right on my system:

00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
__
Chuck
