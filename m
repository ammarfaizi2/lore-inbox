Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWAEAWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWAEAWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWAEAWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:22:44 -0500
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:1241 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750832AbWAEAWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:22:43 -0500
Date: Wed, 4 Jan 2006 19:17:47 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.15] i386: Optimize local APIC timer interrupt
  code
To: Andrew Morton <akpm@osdl.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Message-ID: <200601041922_MC3-1-B554-CF6A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060104150139.34829833.akpm@osdl.org>


Andrew Morton wrote:

> The code which you're patching is cheerfully nuked by a patch in Andi's
> tree:
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/no-subjiffy-profile
>
> I don't immediately understand that patch and I don't recall seeing it
> discussed - maybe I was asleep.
>
> It removes the profile multiplier (readprofile -M).  I've used that
> occasionally, but can't say that I noticed much benefit from it.

 It's probably required for the i386-timer-broadcast patch from the same
patchset.  Apparently some Intel CPUs stop their local APIC timer when in
certain ACPI C-states, so that patch switches them to use an IPI broadcast
from the main timer interrupt instead.  Supporting subjiffy profiling
is impossible in that case, so the code was removed.

-- 
Chuck
