Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132969AbRDJJdk>; Tue, 10 Apr 2001 05:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132970AbRDJJda>; Tue, 10 Apr 2001 05:33:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4869 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132969AbRDJJdS>; Tue, 10 Apr 2001 05:33:18 -0400
Date: Tue, 10 Apr 2001 11:33:09 +0200
From: Martin Mares <mj@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Mark Salisbury <mbs@mc.com>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410113309.A16825@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200104091830.NAA03017@ccure.karaya.com> <01040914220214.01893@pc-eng24.mc.com> <20010410075109.A9549@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010410075109.A9549@gruyere.muc.suse.de>; from ak@suse.de on Tue, Apr 10, 2001 at 07:51:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Just how would you do kernel/user CPU time accounting then ?  It's currently done 
> on every timer tick, and doing it less often would make it useless.

Except for machines with very slow timers we really should account time
to processes during context switch instead of sampling on timer ticks.
The current values are in many situations (i.e., lots of processes
or a process frequently waiting for events bound to timer) a pile
of random numbers.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
We all live in a yellow subroutine...
