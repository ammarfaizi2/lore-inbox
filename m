Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265955AbUGPB6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUGPB6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 21:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbUGPB6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 21:58:45 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:300 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265955AbUGPB6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 21:58:44 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] reduce inter-node balancing frequency
Date: Thu, 15 Jul 2004 21:58:17 -0400
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       John Hawkes <hawkes@sgi.com>
References: <200407151829.20069.jbarnes@engr.sgi.com> <200407152038.32755.jbarnes@engr.sgi.com> <40F733D2.2000309@yahoo.com.au>
In-Reply-To: <40F733D2.2000309@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407152158.17605.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 15, 2004 9:48 pm, Nick Piggin wrote:
> Yeah, these numbers actually used to be a lot higher, but someone
> at Intel (I forget who it was right now) found them to be too high
> on even a 32 way SMT system. They could probably be raised a *little*
> bit in the generic code.

Ok, but I wouldn't want to hurt the performance of small machines at all.  If 
possible, I'd rather just add another level to the hierarchy if MAX_NUMNODES 
> some value.

> > We may have enough information to do that already... I'll look.
>
> The plan is to allow arch overridable SD_CPU/NODE_INIT macros for
> those architectures that just look like a regular SMT+SMP+NUMA, and
> have the generic code set them up.

Would simply creating a 'supernode' scheduling domain work with the existing 
scheduler?  My thought was that in the ia64 code we'd create them for every N 
regular nodes; its children would be the regular nodes with the existing 
defaults.

Thanks,
Jesse
