Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbTJJTcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTJJTcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:32:10 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:14854 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262279AbTJJTcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:32:08 -0400
Date: Fri, 10 Oct 2003 20:31:51 +0100
From: Dave Jones <davej@redhat.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test7] cpufreq longhaul trouble
Message-ID: <20031010193151.GI25856@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jurgen Kramer <gtm.kramer@inter.nl.net>,
	linux-kernel@vger.kernel.org
References: <1065784536.2071.3.camel@paragon.slim> <20031010184241.GC32600@redhat.com> <1065812601.1842.6.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065812601.1842.6.camel@paragon.slim>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 09:03:22PM +0200, Jurgen Kramer wrote:
 > Ok, changing line 394 gives:
 > 
 > <snip>
 > longhaul: VIA C3 'Ezra' [C5C] CPU detected. Longhaul v1 supported.
 > longhaul: MinMult=3.0x MaxMult=6.0x
 > longhaul: FSB: 133MHz Lowestspeed=399MHz Highestspeed=798MHz
 > <snip>
 > 
 > But should it really be v1? With 2.4.20 I get:
 > ep 28 21:09:28 paradox kernel: longhaul: VIA CPU detected. Longhaul
 > version 2 supported
 > Sep 28 21:09:28 paradox kernel: longhaul: CPU currently at 798MHz (133 x
 > 6.0)
 > Sep 28 21:09:28 paradox kernel: longhaul: MinMult(x10)=30
 > MaxMult(x10)=60
 > Sep 28 21:09:28 paradox kernel: longhaul: Lowestspeed=399000
 > Highestspeed=798000
 > Sep 28 21:09:28 paradox kernel: longhaul: New FSB:133 Mult(x10):60
 > Sep 28 21:09:28 paradox kernel: longhaul: New FSB:133 Mult(x10):30

Note that the various speeds etc now match.
Why we got away with this in 2.4 I'm not sure, depends which patch you used.

 > x86info -a gives (running 2.6.0test7):
...
 > /dev/cpu/0/msr: No such device

Heh. this was the important bit.. Doesn't matter now anyway.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
