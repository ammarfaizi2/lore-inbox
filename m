Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318234AbSHZS4j>; Mon, 26 Aug 2002 14:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSHZS4j>; Mon, 26 Aug 2002 14:56:39 -0400
Received: from jabberwock.ucw.cz ([212.71.128.53]:56326 "HELO
	jabberwock.ucw.cz") by vger.kernel.org with SMTP id <S318234AbSHZS4i>;
	Mon, 26 Aug 2002 14:56:38 -0400
Date: Mon, 26 Aug 2002 21:00:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Pavel Machek <pavel@elf.ucw.cz>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
Message-ID: <20020826210054.J24056@ucw.cz>
References: <20020815165617.GE14394@dualathlon.random> <1029496559.31487.48.camel@irongate.swansea.linux.org.uk> <15708.64483.439939.850493@kim.it.uu.se> <20020821131223.GB1117@dualathlon.random> <1029939024.26425.49.camel@irongate.swansea.linux.org.uk> <20020821143323.GF1117@dualathlon.random> <1029942115.26411.81.camel@irongate.swansea.linux.org.uk> <20020821161317.GI1117@dualathlon.random> <20020826161031.GA479@elf.ucw.cz> <159220000.1030387536@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <159220000.1030387536@flay>; from Martin.Bligh@us.ibm.com on Mon, Aug 26, 2002 at 11:45:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> And following your argument that these apps have been silenty broken
> >> since 1999, if there's no broken app out there, nobody will ever get the
> >> instruction fault. If there's any app broken out there we probably like
> > 
> > No. rdtsc is still usefull if you are clever and statistically filter
> > out. Also rdtsc provides you number of cycles, so if you want to know
> > how many cycles mov %eax,%ebx takes, you can do that even on
> > speedstep. Anything that correlates rdtsc to real time is broken, however.
> 
> It's not correlating it to real time that's the problem. It's getting resceduled
> inbetween calls that hurts. Take your example.
> 
> rdtsc
> mov %eax,%ebx
> 			<- get rescheduled here
> rdtsc
> 
> Broken. May even take negative "time".

Yep, you need to do 10000 tries and then choose the most common one.

But I believe andrea was talking about apps that corelate rdtsc to real time.

