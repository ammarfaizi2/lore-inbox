Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSKGQ7K>; Thu, 7 Nov 2002 11:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSKGQ7K>; Thu, 7 Nov 2002 11:59:10 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:31240 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261476AbSKGQ7J>; Thu, 7 Nov 2002 11:59:09 -0500
Date: Thu, 7 Nov 2002 17:05:46 +0000
From: John Levon <levon@movementarian.org>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Corey Minyard <cminyard@mvista.com>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework
Message-ID: <20021107170545.GA5914@compsoc.man.ac.uk>
References: <3DCA0BCC.3080203@mvista.com> <Pine.LNX.4.44.0211070103540.27141-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211070103540.27141-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 01:20:20AM -0500, Zwane Mwaikambo wrote:

> How? The NMI interrupt should be internally masked till IRET. I think your 

The question is not re-entrancy of the NMI handler (this cannot happen
indeed) but whether if when an NMI is generated, and the CPU is handling
an NMI, it will create another interrupt following the current one.

For the performance counters this seems to be the case, but Corey is
unsure about other sources of NMIs...

> you can therefore add tasks in with specific time intervals which will get 
> triggered. This code currently is only running the nmi watchdog, but i'll 
> be experimenting with various other handlers. I'll post a URL soon.

This can easily be built on top of the above API anyway, I think

regards
john

-- 
"When a man has nothing to say, the worst thing he can do is to say it
memorably."
	- Calvin Trillin
