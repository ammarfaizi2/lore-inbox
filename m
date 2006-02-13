Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWBMUEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWBMUEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWBMUEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:04:24 -0500
Received: from [194.90.237.34] ([194.90.237.34]:2240 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S964845AbWBMUEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:04:23 -0500
Date: Mon, 13 Feb 2006 22:05:46 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland Dreier <rdreier@cisco.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>, Hugh Dickins <hugh@veritas.com>
Subject: Re: Re: madvise MADV_DONTFORK/MADV_DOFORK
Message-ID: <20060213200546.GG12458@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org> <adar767133j.fsf@cisco.com> <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 13 Feb 2006 20:06:15.0156 (UTC) FILETIME=[F1A0E340:01C630D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds <torvalds@osdl.org>:
> I would suggest that if you wanted to be very careful, you'd simply 
> disallow changing - or perhaps just clearing - that DONTCOPY flag on 
> special regions (ie ones that have been marked with VM_IO or VM_RESERVED).

Right, this was already proposed here
http://lkml.org/lkml/2005/11/3/81
and I site:
> You're then saying that a process cannot set VM_DONTCOPY on a VM_IO
> area to prevent the first child getting the area, but clear it after
> so the next child does get a copy of the area.  I think it'd be wrong
> (surprising) to limit the functionality in that way.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
