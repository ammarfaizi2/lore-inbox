Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264901AbUAIWRA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 17:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUAIWRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 17:17:00 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:39665 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264901AbUAIWQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 17:16:58 -0500
Message-ID: <3FFF2851.4060501@mvista.com>
Date: Fri, 09 Jan 2004 14:16:49 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Andrew Morton <akpm@osdl.org>, jim.houston@comcast.net, discuss@x86-64.org,
       ak@suse.de, shivaram.upadhyayula@wipro.com,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <1073603622.993.353.camel@new.localdomain> <20040108153243.11e45156.akpm@osdl.org> <200401091031.41493.amitkale@emsyssoft.com>
In-Reply-To: <200401091031.41493.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit,

The base line kgdb code in the mm patches was offered by me.  It derives from (a 
long time ago) a kgdb I got from the RTIA (or was it the RTLINUX) folks.  Prio 
to that, well, your name is on it as well as others.

As you may have noted there have been a lot of changes, mostly for the better, I 
hope.  I think we have slightly different objectives in our work.  I debug 
kernels, not drivers, so I am interested in getting into kgdb as early as 
possible.  To this end the current mm patch allows one to put a breakpoint() as 
the first line of C code in the kernel.  This required a few adjustments, such 
as configuring the I/O port at CONFIG time, for example.

I would like for the two versions of kgdb to merge while keeping the features of 
both.  The work on seperating the common code is something I like and, while I 
never do modules, the automatic module stuff in gdb sound good.

May I suggest that we compare and contrast the two versions and take a look at 
the differences and the overlaps and settle on one way of doing the various things.

George




-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

