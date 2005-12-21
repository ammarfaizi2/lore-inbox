Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVLUTcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVLUTcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVLUTcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:32:22 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:24527 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751186AbVLUTcV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:32:21 -0500
Date: Wed, 21 Dec 2005 12:32:20 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Mark Maule <maule@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 3/4] per-platform IA64_{FIRST,LAST}_DEVICE_VECTOR definitions
Message-ID: <20051221193220.GF2361@parisc-linux.org>
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com> <20051221184353.5003.87888.74327@attica.americas.sgi.com> <20051221190916.GE2361@parisc-linux.org> <20051221191843.GJ9920@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221191843.GJ9920@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 01:18:43PM -0600, Mark Maule wrote:
> Ok.  Was just following the lead of this:
> 
> static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
> 
> So arrays are always init'd to zero?

Static variables without an initialiser go to the bss section and get
initialised to 0 by the loader.  So the initialisation above is
redundant on all machines which use a bitpattern of zeros to represent
the NULL pointer.  Which is all machines Linux runs on.
