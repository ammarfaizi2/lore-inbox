Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032190AbWLGNUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032190AbWLGNUg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 08:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032196AbWLGNUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 08:20:36 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:2502 "EHLO
	jurassic.park.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032190AbWLGNUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 08:20:35 -0500
Date: Thu, 7 Dec 2006 16:20:50 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061207162050.A5009@jurassic.park.msu.ru>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4577DF5C.5070701@yahoo.com.au>; from nickpiggin@yahoo.com.au on Thu, Dec 07, 2006 at 08:31:08PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 08:31:08PM +1100, Nick Piggin wrote:
> It might be reasonable to implement this watered down version, but:
> don't some architectures have restrictions on what instructions can
> be issued between the ll and the sc?

Yes. On Alpha you cannot execute other load/stores, taken branches etc.
So in general case the code between ll and sc cannot be written in C...

Ivan.
