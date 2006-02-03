Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWBCBm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWBCBm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWBCBm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:42:57 -0500
Received: from beauty.rexursive.com ([218.214.6.102]:3215 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S932300AbWBCBm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:42:56 -0500
Message-ID: <20060203124253.m6azcn4wg88gsogc@imp.rexursive.com>
Date: Fri, 03 Feb 2006 12:42:53 +1100
From: Bojan Smojver <bojan@rexursive.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nigel@suspend2.net, suspend2-devel@lists.suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	<20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org>
	<200602030918.07006.nigel@suspend2.net>
	<20060203120055.0nu3ym4yuck0os84@imp.rexursive.com>
	<20060202171812.49b86721.akpm@osdl.org>
In-Reply-To: <20060202171812.49b86721.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@osdl.org>:

> This leaves us in rather awkward position.  You see, there will be other
> people whose machines don't work with suspend2 but which do work with
> swsusp.  And other people who prefer swsusp for other reasons.

 From what I can see on suspend2 development list, Nigel regularly 
addresses people's problems with his code, which then results in 
working systems. Most times when people see problems with suspend2, it 
is the drivers that can't do suspend that are the root cause (at least 
that seems to be the pattern on the suspend2 mailing list).

The only way for a much broader community to experience and test 
suspend2 is to put it in the mainline kernel. I'm not sure why that is 
such a problem...

> It'd help if we knew _why_ your machine doesn't work with swsusp so we can
> fix it.  Futhermore it'd help if we knew specifically what you prefer about
> suspend2 so we can understand what more needs to be done, and how we should
> do it.

Here is what I prefer in suspend2:

- it works (i.e. I have compiled it for at least 20 different Rawhide 
kernels and it always suspended/resumed properly)

- it is reliable (e.g. I have suspended/resumed mid kernel compile  - 
actually, kernel RPM build, which included compile - many times, 
without any ill effect)

- it is fast (i.e. even on my crappy old HP ZE4201 
[http://www.rexursive.com/articles/linuxonhpze4201.html], it writes all 
of 700+ MB of RAM to disk just as fast or faster than swsusp).

- it looks nice (both text and GUI interface supported)

- it leaves the system responsive on resume (kinda nice to come back to 
X and "Just Use it")

- it suspends to both swap and file (I personally use swap, but many 
people on the list use file)

Just today, I tried the most recent Rawhide kernel (based on 
2.6.16-rc1-git5) with swsusp and for the first time *ever* it actually 
returned X to its original state (I was so excited, I even notified 
people on suspend2 development list about it). But, on second 
suspend/resume, it promptly locked up my system. Before, it would 
simply lock up. So, if swsusp can be made to actually work, be 
reliable, look nice and be responsive on resume, I'm all for it. I will 
miss Nigel's excellent support though, but I'm sure he deserves a break 
:-)

-- 
Bojan
