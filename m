Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWCQTkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWCQTkD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWCQTkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:40:03 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:14003 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751132AbWCQTkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:40:02 -0500
Message-ID: <441B1025.7000708@cfl.rr.com>
Date: Fri, 17 Mar 2006 14:38:13 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Nick Warne <nick@linicks.net>,
       Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: chmod 111
References: <200603171746.18894.nick@linicks.net>  <6f6293f10603171007vbf752e5n8a3d6f2d65e0a1e7@mail.gmail.com>  <200603171811.01963.nick@linicks.net> <1142620004.9478.13.camel@localhost.localdomain> <Pine.LNX.4.64.0603171036240.3618@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603171036240.3618@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Mar 2006 19:42:29.0454 (UTC) FILETIME=[ED1006E0:01C649FA]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14329.000
X-TM-AS-Result: No--1.300000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In particular, it's fairly easy to create a shared library that replaces a 
> system library (LD_LIBRARY_PATH) and then just dumps out the binary image.
> 

What prevents you from injecting a shared library and manipulating a 
suid executable?  Does the environment get cleared when you exec a suid 
program?  Or does the dynamic linker just notice euid != uid and ignore 
the LD environment variables?  If so then would adding the sgid bit and 
making the binary owned by a powerless group effectively prevent this 
attack vector to read it?


