Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWJ1ARg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWJ1ARg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 20:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWJ1ARg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 20:17:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63724 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751134AbWJ1ARf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 20:17:35 -0400
Subject: Re: AMD X2 unsynced TSC fix?
From: Lee Revell <rlrevell@joe-job.com>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: "thockin@hockin.org" <thockin@hockin.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <68676e00610271700i741b949frc73bf790d38ab1f@mail.gmail.com>
References: <1161969308.27225.120.camel@mindpipe>
	 <20061027201820.GA8394@dreamland.darkstar.lan>
	 <20061027230458.GA27976@hockin.org>
	 <68676e00610271700i741b949frc73bf790d38ab1f@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 20:17:35 -0400
Message-Id: <1161994656.27225.243.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-28 at 02:00 +0200, Luca Tettamanti wrote:
> 
> As you say you cannot use it to do timing unless you disable any power
> management on the CPU. Otherwise you can count the elapsed ticks but
> you cannot convert the number to anything meaningful.
> You may be able to emulate rdtsc for userspace but then again the
> whole point of using rdtsc is that it should be uber-fast... if rdtsc
> is emulated then you can just use gettimeofday (which is also
> optimized to be *very* fast). No? 

gettimeofday() cannot be fast if it has to use the ACPI PM timer.  It's
50% slower on my shiny new "AMD Athlon(tm)64 X2 Dual Core Processor
3800+" than on my 600Mhz Via C3, which in general is about a 10x slower
machine.  That's a massive regression.

Lee

