Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281162AbRKLXP6>; Mon, 12 Nov 2001 18:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281174AbRKLXPt>; Mon, 12 Nov 2001 18:15:49 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:39176 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S281162AbRKLXPf>; Mon, 12 Nov 2001 18:15:35 -0500
Date: Mon, 12 Nov 2001 20:59:05 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-Id: <20011112205905.4a695ed3.rusty@rustcorp.com.au>
In-Reply-To: <3BEBBB21.357149FC@idb.hist.no>
In-Reply-To: <Pine.LNX.4.33.0111081802380.15975-100000@localhost.localdomain.suse.lists.linux.kernel>
	<Pine.LNX.4.33.0111081836080.15975-100000@localhost.localdomain.suse.lists.linux.kernel>
	<p731yj8kgvw.fsf@amdsim2.suse.de>
	<20011109141215.08d33c96.rusty@rustcorp.com.au>
	<3BEBBB21.357149FC@idb.hist.no>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Nov 2001 12:16:49 +0100
Helge Hafting <helgehaf@idb.hist.no> wrote:

> Rusty Russell wrote:
> 
> > Modules have lots of little disadvantages that add up.  The speed penalty
> > on various platforms is one, the load/unload race complexity is another.
> > 
> Races can be fixed.  (Isn't that one of the things considered for 2.5?)

We get more problems if we go preemptible (some seem to thing that preemption
is "free").  And some races can be fixed by paying more of a speed penalty
(atomic_inc & atomic_dec_and_test for every packet, anyone?).

Hope that clarifies,
Rusty.

