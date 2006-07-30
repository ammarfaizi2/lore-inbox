Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWG3VP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWG3VP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 17:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWG3VP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 17:15:29 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:65500 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1751395AbWG3VP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 17:15:28 -0400
Date: Sun, 30 Jul 2006 23:13:59 +0200
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, bunk@stusta.de,
       lethal@linux-sh.org, hirofumi@mail.parknet.co.jp,
       asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060730211359.GZ3662@kiste.smurf.noris.de>
References: <20060723081604.GD27566@kiste.smurf.noris.de> <20060723044637.3857d428.akpm@osdl.org> <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org> <1153756738.9440.14.camel@localhost> <20060724171711.GA3662@kiste.smurf.noris.de> <20060724175150.GD50320@muc.de> <1153774443.12836.6.camel@localhost> <20060730020346.5d301bb5.akpm@osdl.org> <20060730201005.GA85093@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730201005.GA85093@muc.de>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andi Kleen:
> > It is a "CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03".
> 
> Was that on that system? I guess it could be checked for and TSC 
> be forced off. It sounds like a real CPU bug however.
> 
Board problem? After all, it has some very noxious DMI entries:

System Information
        Manufacturer: Intel Corporation
        Product Name: Nocona/Tumwater Customer Reference Board
        Version: Revision A0
        Serial Number: 0123456789
        UUID: 0A0A0A0A-0A0A-0A0A-0A0A-0A0A0A0A0A0A

... all of which are patently *wrong*.

You'd have to ask the people from Tyan what the hell they were smoking
when they blindly copied the Intel data.

At least the different CPU speed issue is a known bug, fixed by a
BIOS update. I'll postpone that until we have a working kernel fix,
for obvious reasons.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You might be a Redneck if ...
You consider a six-pack and a bug-zapper high-quality entertainment.
