Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUDGNoC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 09:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbUDGNoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 09:44:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6368 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263589AbUDGNn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 09:43:59 -0400
Date: Tue, 6 Apr 2004 15:00:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Administrator@ucw.cz, Pavel Machek <pavel@ucw.cz>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Message-ID: <20040406130018.GG3084@openzaurus.ucw.cz>
References: <20031212221045.GB314@elf.ucw.cz> <1071269429.4182.6.camel@idefix.homelinux.org> <010f01c415a4_27033d00_d100000a@sbs2003.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010f01c415a4_27033d00_d100000a@sbs2003.local>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Actually, the way I rewrote it in the patch is immune to that kind of
> >problem:
> >
> >seq_printf(m, "\nbogomips\t: %lu.%02lu\n\n",
> >           HZ*(c->loops_per_jiffy>>3)/62500,
> >           (HZ*(c->loops_per_jiffy>>3)/625)%100);
> >
> >It will work correctly for any HZ up to ~34000 bogomips (using 32-bit
> >arithmetic).
> 
> I think it's likely any CPU with 34000 bogomips will have more than 
> 32 bit ;-)

Hmmm, but it will perhaps be running in compatibility mode.

;-),
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

