Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSJVFpy>; Tue, 22 Oct 2002 01:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262209AbSJVFpy>; Tue, 22 Oct 2002 01:45:54 -0400
Received: from franka.aracnet.com ([216.99.193.44]:59366 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262207AbSJVFpx>; Tue, 22 Oct 2002 01:45:53 -0400
Date: Mon, 21 Oct 2002 22:49:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
Message-ID: <2629107186.1035240598@[10.10.2.3]>
In-Reply-To: <3DB4D20A.8A579516@digeo.com>
References: <3DB4D20A.8A579516@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh it's reproduceable OK.  Just run
> 
> 	make-teeny-files 7 7

Excellent - thanks for that ... will try it.
 
> Maybe you didn't cat /dev/sda2 for long enough?

Well, it's a multi-gigabyte partition. IIRC, I just ran it until
it died with "input/output error" ... which I assumed at the time
was the end of the partition, but it should be able to find that
without error, so maybe it just ran out of ZONE_NORMAL ;-)
 
> Perhaps we need to multiply the slab cache scanning pressure by the
> slab occupancy.  That's simple to do.

That'd make a lot of sense (to me, at least). I presume you mean
occupancy on a per-slab basis, not global.

M.

