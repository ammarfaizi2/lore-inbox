Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268110AbTCFPvf>; Thu, 6 Mar 2003 10:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268131AbTCFPvf>; Thu, 6 Mar 2003 10:51:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29614 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268110AbTCFPve>;
	Thu, 6 Mar 2003 10:51:34 -0500
Message-ID: <3E6770F3.8030207@pobox.com>
Date: Thu, 06 Mar 2003 11:01:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrew Morton <akpm@digeo.com>, rml@tech9.net, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
References: <Pine.LNX.4.44.0303060710350.7206-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303060710350.7206-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pardon the suggestion of a dumb hueristic, feel free to ignore me: 
would it work to run-first processes that have modified their iopl() 
level?  i.e. "if you access hardware directly, we'll treat you specially 
in the scheduler"?

An alternative is to encourage distros to set some sort of flag for 
processes like the X server, when it is run.  This sounds suspiciously 
like the existing "renice X server" hack, but it could be something like 
changing the X server from SCHED_OTHER  to SCHED_HW_ACCESS instead.

Just throwing out some things, because I care about apps which access 
hardware from userspace :)

