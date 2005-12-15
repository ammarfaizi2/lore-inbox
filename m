Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVLOTrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVLOTrc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVLOTrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:47:32 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:43012 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1750915AbVLOTrb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:47:31 -0500
Date: Thu, 15 Dec 2005 15:38:18 -0500
From: Jeff Dike <jdike@addtoit.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@osdl.org>,
       Mark Lord <lkml@rtr.ca>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk,
       pj@sgi.com, mingo@elte.hu, hch@infradead.org, torvalds@osdl.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051215203818.GA11487@ccure.user-mode-linux.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0535A549@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0535A549@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 09:45:10AM -0800, Luck, Tony wrote:
> There was a USENIX paper a couple of decades ago that described how
> to do a fast s/w disable of interrupts on machines where really disabling
> interrupts was expensive.  The rough gist was that the spl[1-7]()
> functions would just set a flag in memory to hold the desired interrupt
> mask.  If an interrupt actually occurred when it was s/w blocked, the
> handler would set a pending flag, and just rfi with interrupts disabled.
> Then the splx() code checked to see whether there was a pending interrupt
> and dealt with it if there was.

... and this is currently implemented (but not yet merged to mainline) in
UML.

				Jeff
