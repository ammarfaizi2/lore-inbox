Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314649AbSEFSMH>; Mon, 6 May 2002 14:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314650AbSEFSMG>; Mon, 6 May 2002 14:12:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:33462 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314649AbSEFSME>; Mon, 6 May 2002 14:12:04 -0400
Date: Mon, 06 May 2002 12:09:14 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <244530000.1020712153@flay>
In-Reply-To: <E174mTn-0004Kr-00@starship>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that for NUMA-Q, the ->lmem_map arrays are currently off-node for
> all but node zero, so the per-node ->lmem_map is doing nothing for
> NUMA-Q at the moment.  In order for this to make sense for NUMA-Q, I
> really do have to provide a local mapping of a portion of zone_numa,
> otherwise we might as well just use config_nonlinear in its current
> form.

To split hairs, they're not currently off node - as they have to reside in
ZONE_NORMAL, I can't make them so until I have the nonlinear stuff
(or equivalent). But they ought to be on their home node, so your point
is pretty much the same ;-) AFAIK, all other NUMA arches use the local
lmem_map already.

Is zone_numa a typo for zone_normal, or did I lose track of the conversation 
at some point? I'm not sure I grok the last sentence of yours ....

M.


