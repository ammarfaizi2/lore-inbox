Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277738AbRKADSo>; Wed, 31 Oct 2001 22:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277728AbRKADSd>; Wed, 31 Oct 2001 22:18:33 -0500
Received: from mail11.speakeasy.net ([216.254.0.211]:14600 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S277713AbRKADSP>; Wed, 31 Oct 2001 22:18:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: graphical swap comparison of aa and rik vm
Date: Wed, 31 Oct 2001 22:18:51 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011101031823Z277713-17408+8578@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In an earlier post i mentioned a way of locking up my vm easily and 
repeatedly but that has since been fixed in one way or another.  I reran the 
test and took vmstat 1 's of both runnings on a 2.4.14-pre6-preempt kernel 
and a 2.4.13-ac5-preempt kernel.  I began both vmstat's at the same time 
(about 4 seconds before running each).  What i did was run kghostview on a 
postscript file located here http://safemode.homeip.net/test.ps  .  It is 
224K.  kmail was loaded previously in both trials so kdeinit was already 
loaded as were all libs.   After kghostview became responsive, i waited a few 
seconds (again about 5) and then exited the app.  

No other interaction or running programs were present while doing this.  
I have 771580 KB of ram and 290740 KB of swap.

Now to explain the graphs.
The blue is AA's vm.  The red is Rik's vm.  Rik's vm finished in 66 seconds. 
AA's vm finished in 52 seconds.  Both start at 0 swap usage.  Both from clean 
boots.  

Here is the graph   http://safemode.homeip.net/vm_swapcomparison.png   . It's 
about 4.6K. 

When you look at the graph it goes like this. 
The left side is 0 seconds, the right side is 66 seconds.  bottom is 0KB, top 
is 290740KB.   

These are generated from data from the orignal vmstat outputs.  These are at 
http://safemode.homeip.net/aa_vmstat
and 
http://safemode.homeip.net/rik_vmstat 

I'll leave the actual interpretation of the data of both the graph and raw 
data up to those who actually know the code.  

Neadless to say that while running the test on either box, the entire 
computer became unresponsive multiple times for extended lengths of times.  
No OOM was generated on either run. 
