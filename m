Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318215AbSHZTAy>; Mon, 26 Aug 2002 15:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318221AbSHZTAy>; Mon, 26 Aug 2002 15:00:54 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:5630 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318215AbSHZTAv>; Mon, 26 Aug 2002 15:00:51 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Pavel Machek <pavel@elf.ucw.cz>, Andrea Arcangeli <andrea@suse.de>,
       Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <159220000.1030387536@flay>
References: <1028812663.28883.32.camel@irongate.swansea.linux.org.uk>
	<1028860246.1117.34.camel@cog> <20020815165617.GE14394@dualathlon.random>
	<1029496559.31487.48.camel@irongate.swansea.linux.org.uk>
	<15708.64483.439939.850493@kim.it.uu.se>
	<20020821131223.GB1117@dualathlon.random>
	<1029939024.26425.49.camel@irongate.swansea.linux.org.uk>
	<20020821143323.GF1117@dualathlon.random>
	<1029942115.26411.81.camel@irongate.swansea.linux.org.uk>
	<20020821161317.GI1117@dualathlon.random> <20020826161031.GA479@elf.ucw.cz>
	 <159220000.1030387536@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 20:05:13 +0100
Message-Id: <1030388713.2776.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 19:45, Martin J. Bligh wrote:
> It's not correlating it to real time that's the problem. It's getting resceduled
> inbetween calls that hurts. Take your example.
> 
> rdtsc
> mov %eax,%ebx
> 			<- get rescheduled here
> rdtsc
> 
> Broken. May even take negative "time".

Statistically irrelevant. When you have 100,000 samples all the
pre-emption ones drop into the dud sample filter with IRQ disturbance
and so on.


