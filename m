Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTJJSm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTJJSm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:42:59 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:60868 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261427AbTJJSm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:42:58 -0400
Date: Fri, 10 Oct 2003 19:42:41 +0100
From: Dave Jones <davej@redhat.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test7] cpufreq longhaul trouble
Message-ID: <20031010184241.GC32600@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jurgen Kramer <gtm.kramer@inter.nl.net>,
	linux-kernel@vger.kernel.org
References: <1065784536.2071.3.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065784536.2071.3.camel@paragon.slim>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 01:15:37PM +0200, Jurgen Kramer wrote:

 > It seems that longhaul support in 2.6.0-test7 is still not working
 > properly...:-(. 
 > 
 > longhaul: VIA C3 'Ezra' [C5C] CPU detected. Longhaul v2 supported.
 > longhaul: Bogus values Min:0.000 Max:0.000. Voltage scaling disabled.
 > longhaul: MinMult=5.0x MaxMult=6.0x
 > longhaul: FSB: 0MHz Lowestspeed=0MHz Highestspeed=0MHz

Oh boy, this is a real egg-on-face bug if I'm right..
edit arch/i386/kernel/cpu/cpufreq/longhaul.c and change line
394 to read longhaul_version = 1;
I suspect things will suddenly start making a lot more sense.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
