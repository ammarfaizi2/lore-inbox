Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318252AbSHZUUw>; Mon, 26 Aug 2002 16:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318253AbSHZUUw>; Mon, 26 Aug 2002 16:20:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:28670 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318252AbSHZUUv>;
	Mon, 26 Aug 2002 16:20:51 -0400
Date: Mon, 26 Aug 2002 13:19:24 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Machek <pavel@elf.ucw.cz>, Andrea Arcangeli <andrea@suse.de>,
       Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
Message-ID: <160380000.1030393164@flay>
In-Reply-To: <1030388713.2776.11.camel@irongate.swansea.linux.org.uk>
References: <1028812663.28883.32.camel@irongate.swansea.linux.org.uk><1028860246.1117.34.camel@cog> <20020815165617.GE14394@dualathlon.random><1029496559.31487.48.camel@irongate.swansea.linux.org.uk><15708.64483.439939.850493@kim.it.uu.se><20020821131223.GB1117@dualathlon.random><1029939024.26425.49.camel@irongate.swansea.linux.org.uk><20020821143323.GF1117@dualathlon.random><1029942115.26411.81.camel@irongate.swansea.linux.org.uk><20020821161317.GI1117@dualathlon.random> <20020826161031.GA479@elf.ucw.cz> <159220000.1030387536@flay> <1030388713.2776.11.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It's not correlating it to real time that's the problem. It's getting resceduled
>> inbetween calls that hurts. Take your example.
>> 
>> rdtsc
>> mov %eax,%ebx
>> 			<- get rescheduled here
>> rdtsc
>> 
>> Broken. May even take negative "time".
> 
> Statistically irrelevant. When you have 100,000 samples all the
> pre-emption ones drop into the dud sample filter with IRQ disturbance
> and so on.
 
OK, so let's take a better example. People are (I think) mainly using rdtsc
to provide a monotonically increasing counter for database "transaction
order" stamping. I think that's really the case we're worried about. 

M.

