Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbTLPDEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 22:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTLPDEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 22:04:48 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:7880 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264323AbTLPDEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 22:04:47 -0500
Subject: Re: Increasing HZ (patch for HZ > 1000)
From: john stultz <johnstul@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031212234028.GA541@elf.ucw.cz>
References: <1071126929.5149.24.camel@idefix.homelinux.org>
	 <1293500000.1071127099@[10.10.2.4]> <20031212220853.GA314@elf.ucw.cz>
	 <1071269849.4182.14.camel@idefix.homelinux.org>
	 <20031212234028.GA541@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1071543853.989.183.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Dec 2003 19:04:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-12 at 15:40, Pavel Machek wrote:
> > For now, my patch only allows up to around 10 kHz. At that frequency, I
> > don't hear anything because the noise is not loud enough (ear is much
> > more sensitive at 1 kHz). Also, I have around 10% overhead on my
> > Pentium-M 1.6 GHz, so I guess it's not for everyone. Extrapolating from
> > there, I'd also say that at 100 kHz, it wouldn't do anything but handle
> > the interrupts, which is slightly annoying when you want to actually get
> > some work done :)
> 
> I wonder what happens at 200kHz then; system might detect some lost
> ticks and keep running at very slow speed...

Indeed, with all the trouble HZ==1000 has caused, I'm thinking that
playing w/ HZ at 10k and 10 would be good stress tests for the time
subsystem.

I'd be interested in hearing how much drift people see when running w/
this patch. 

thanks
-john


