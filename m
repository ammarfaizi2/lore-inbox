Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUCKWHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUCKWHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:07:23 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:33932 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261784AbUCKWHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:07:17 -0500
Message-ID: <4050E453.3010809@tmr.com>
Date: Thu, 11 Mar 2004 17:12:35 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: markw@osdl.org
CC: linux-lvm@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: lvm2 performance data with linux-2.6
References: <200403081916.i28JGgE25794@mail.osdl.org>
In-Reply-To: <200403081916.i28JGgE25794@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org wrote:
> I've started collecting various data (including oprofile) using our
> DBT-2 (OLTP) workload with lvm2 on linux 2.6.2 and 2.6.3 on ia32 and
> ia64 platforms:
> 	http://developer.osdl.org/markw/lvm2/
> 
> So far I've only varied the stripe width with lvm, from 8 KB to 512 KB,
> for PostgreSQL that is using 8 KB sized blocks with ext2.  It appears
> that a stripe width of 16 KB through 128KB on the ia64 system gives the
> best throughput for the DBT-2 workload on a volume that should be doing
> mostly sequential writes.
> 
> I'm going to run through more tests varying the block size that
> PostgreSQL uses, but I wanted to share what I had so far in case there
> were other suggestions or recommendations.
> 
Here's one thought: look at the i/o rates on individual drives using 
each stripe size. You *might* see that one size does far fewer seeks 
than others, which is a secondary thing to optimize after throughput IMHO.

If you don't have a tool for this I can send you the latest diorate 
which does stuff like this, io rate perdrive or per partition, something 
I occasionally find revealing.

		-bill
