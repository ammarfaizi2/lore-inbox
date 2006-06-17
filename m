Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWFQG6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWFQG6n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 02:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWFQG6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 02:58:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:6853 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932483AbWFQG6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 02:58:42 -0400
From: Andi Kleen <ak@suse.de>
To: Brent Casavant <bcasavan@sgi.com>
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Sat, 17 Jun 2006 08:58:39 +0200
User-Agent: KMail/1.8
Cc: Chase Venters <chase.venters@clientec.com>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>, Jes Sorensen <jes@sgi.com>,
       Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
References: <200606140942.31150.ak@suse.de> <Pine.LNX.4.64.0606161615450.23743@turbotaz.ourhouse> <20060616181940.S91827@pkunk.americas.sgi.com>
In-Reply-To: <20060616181940.S91827@pkunk.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606170858.39656.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That work could form the basis for a low-impact method of exporting
> the current CPU to user space via a read-only mapped page.  I'll admit
> to having zero knowledge of whether this would be workable on anything
> other than ia64.

On x86 per CPU mappings are not really feasible. That is because
the CPU uses the Linux page tables directly and to change them
per CPU you would need to fork them per CPU. That would add so much
complications that I don't even want to think them all through ...

-andi
