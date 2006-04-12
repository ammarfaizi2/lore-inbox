Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWDLXxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWDLXxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 19:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWDLXxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 19:53:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35003 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932388AbWDLXxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 19:53:36 -0400
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V2
Date: Thu, 13 Apr 2006 01:53:07 +0200
User-Agent: KMail/1.9.1
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, linux-mm@kvack.org
References: <20060412232036.18862.84118.sendpatchset@skynet>
In-Reply-To: <20060412232036.18862.84118.sendpatchset@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604130153.08604.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 01:20, Mel Gorman wrote:
> This is V2 of the patchset. They have been boot tested on x86, ppc64
> and x86_64 but I still need to do a double check that zones are the
> same size before and after the patch on all arches. IA64 passed a
> basic compile-test. a driver program that fed in the values generated
> by IA64 to add_active_range(), zone_present_pages_in_node() and
> zone_absent_pages_in_node() seemed to generate expected values.

For x86-64  the new code seems far more complicated than the old one and keeps
the same information in two places now. I have my doubts that is really a 
improvement over the old state.

I think it would be better if you just defined some simple "library functions"
that can be called from the architecture specific code instead of adding
all this new high level code.

-Andi
