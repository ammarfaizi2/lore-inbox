Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278098AbRKAGYR>; Thu, 1 Nov 2001 01:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278102AbRKAGYG>; Thu, 1 Nov 2001 01:24:06 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:59915 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S278098AbRKAGXs>; Thu, 1 Nov 2001 01:23:48 -0500
Date: Thu, 1 Nov 2001 01:23:47 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: safemode <safemode@speakeasy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: graphical swap comparison of aa and rik vm
In-Reply-To: <20011101031823Z277713-17408+8578@vger.kernel.org>
Message-ID: <Pine.LNX.4.10.10111010056100.31484-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is the graph   http://safemode.homeip.net/vm_swapcomparison.png   . It's 

here's my munge of the same data:
	http://mhahn.mcmaster.ca/~hahn/foo.png
the measures I find interesting are the SI/SO rates.  first, the most obvious
feature is that Rik-VM has a serious problem knowing when to *stop* swapping
out.  but SO isn't a bad thing unless it's obsessive: it's when you see high 
*swap-in* that you know the VM has previously chosen bad pages to SO.  
and this is the second big difference: Rik-VM doesn't make nearly as many
mistakes - especially look at Andrea-VM thrashing out-in-out at ~ samples 26-32.

also, if you merely sum the SI and SO columns for each:
		sum(SI)		sum(SO)		sum(SI+SO)
      Rik-VM	43564		317448		290032
      AA-VM	118284		171748		361012
to me, this looks like the same point: Rik being SO-happy, 
Andrea having to SI a lot more.  interesting also that Andrea wins the race, 
in spite of poorer SO choices and more swap traffic overall.

> Neadless to say that while running the test on either box, the entire 
> computer became unresponsive multiple times for extended lengths of times.  

yes, unfortunately this corrupts the value of the data, since the timecourses
are not really comparable, and samples are only vaguely related to time...

regards, mark hahn.


