Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTJ2Wa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 17:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTJ2Wa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 17:30:56 -0500
Received: from cmailm5.svr.pol.co.uk ([195.92.193.21]:29454 "EHLO
	cmailm5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261699AbTJ2Way (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 17:30:54 -0500
From: Chris Vine <chris@cvine.freeserve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 - poor swap performance on low end machines
Date: Wed, 29 Oct 2003 22:30:12 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310292230.12304.chris@cvine.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been testing the 2.6.0-test9 kernel on a couple of desktop machines.  
On the first, a 1.8GHz Pentium 4 uniprocessor with 512MHz of RAM, it seems to 
perform fine, and on various compilation tests, compile times for the test 
programs I have compiled are pretty much the same as those obtained with a 
stock 2.4.22 kernel, and the 2.6 kernel seems to be slightly more responsive 
on the desktop.  Nothing I use it for knocks it substantially into swap.

However, on a low end machine (200MHz Pentium MMX uniprocessor with only 32MB 
of RAM and 70MB of swap) I get poor performance once extensive use is made of 
the swap space.  On a test compile of a C++ program involving quite a lot of 
templates and therefore which is quite memory intensive, it chugs along with 
the stock 2.4.22 kernel and completes the compile in about 10 minutes going 
(at its worst) into about 34MB of swap.  However, doing the same compile on 
the 2.6.0-test9 kernel, it reaches about 22MB into swap and then goes into 
some kind of swap frenzy, continuously swaping and unswapping.  Even after 
leaving it for an hour it continuously swaps and unswaps and fails to compile 
even the first file (which takes about 2 minutes using the 2.4.22 kernel) and 
sticks at about 24MB of swap.  The kernel is compiled with gcc-2.95.3.

Chris.

PS Please copy any replies to my e-mail address.

