Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131353AbRCWTVn>; Fri, 23 Mar 2001 14:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131345AbRCWTVe>; Fri, 23 Mar 2001 14:21:34 -0500
Received: from altus.drgw.net ([209.234.73.40]:52490 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S131347AbRCWTVT>;
	Fri, 23 Mar 2001 14:21:19 -0500
Date: Fri, 23 Mar 2001 13:19:59 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: linux-kernel@vger.kernel.org
Subject: RE: regression tester
Message-ID: <20010323131959.B14042@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cort Dougan wrote:
>We have a start for PPC. It has the title "Regression Tester" but is 
>actually a "compiles and boots tester". The aim is a automated 
>regression test. 

>Take a look at http://altus.drgw.net/ 

I got a domain for this.. it works as 'hozed.org' and also the (sometimes 
appropriate) 'kernel.is.hozed.org'  ;)

>It pulls directly from our BitKeeper archive every time we push a change 
>and goes through the build targeted for a number of platforms. 

Right now, all the autobuilder part knows about is Bitkeeper, but it's
designed so that one can easily add methods to pull from a CVS
repository, or just plain old tarballs.

>} - automated compilation of the kernel with random config 
>} options (done by Arjan v/d Ven?) 
>} - automated testing of certain kernel behaviour (didn't 
>} SGI have a project to look at this? could they use help?) 
>} - ... ? 


I need to write a design document for this thing so I don't have to 
explain it 300 times in emails.. 

The executive summary goes something like this:

Goal: Distributed, scalable, cross-organization regression testing

Problem: No one group has *all* the hardware linux runs on, so how can 
anyone know a particular patch doesn't break something?

Solution:  
Automated tool builds kernels for multiple configurations (.config)
files, and uploads kernels and build logs to a web server. (hozed.org, 
for my initial testing). Now, some joe random user with weird hardware 
can download the the kernel and a ramdisk containing a small, simple set 
of 'regression tests' that verify basic kernel functionality. This 
ramdisk then uploads the results to a web server, so that this requires 
no user interaction, other than downloading the kernel and ramdisk and 
booting them.

Now, once the results are collected, kernel developers and look and see 
what changes to the kernel did to various machine types and stuff.

One of my goals is to have a kernel 'tree' that one of the requirements 
for any patch to go in is that it passes the regression tests on a 
certain number and/or type of machines. In theory, if this works, anyone 
can download either the source or pre-built binaries, and have a really 
good idea that it *will* work.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
