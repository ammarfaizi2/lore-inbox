Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTJ3XAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbTJ3XAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:00:21 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:10454 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262914AbTJ3XAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:00:18 -0500
Message-ID: <3FA195BD.2040701@nortelnetworks.com>
Date: Thu, 30 Oct 2003 17:50:37 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: George Anzinger <george@mvista.com>,
       Peter Chubb <peter@chubb.wattle.id.au>,
       Stephen Hemminger <shemminger@osdl.org>,
       Gabriel Paubert <paubert@iram.es>, john stultz <johnstul@us.ibm.com>,
       Joe Korty <joe.korty@ccur.com>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
References: <20031027234447.GA7417@rudolph.ccur.com> <1067300966.1118.378.camel@cog.beaverton.ibm.com> <20031027171738.1f962565.shemminger@osdl.org> <20031028115558.GA20482@iram.es> <20031028102120.01987aa4.shemminger@osdl.org> <20031029100745.GA6674@iram.es> <20031029113850.047282c4.shemminger@osdl.org> <16288.17470.778408.883304@wombat.chubb.wattle.id.au> <3FA1838C.3060909@mvista.com> <Pine.LNX.4.53.0310301645170.16005@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> There isn't any magic that can solve this problem. It turns out
> that with later Intel CPUs, one can get CPU-clock resolution
> from rdtsc. However, this is hardware-specific. If somebody
> modifies the gettimeofday() and the POSIX clock routines to
> use rdtsc when available, a lot of problems will go away.

Its not just x86.  PowerPC has a similar call, so does MIPS, and I'm 
sure most other modern cpus do too.

The only problem with this stuff is that they usually slow down when the 
cpu does, so laptops and other power-managed chips cause complexities.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

