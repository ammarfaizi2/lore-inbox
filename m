Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbTCFXcb>; Thu, 6 Mar 2003 18:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261285AbTCFXcb>; Thu, 6 Mar 2003 18:32:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:16341 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261284AbTCFXc1>; Thu, 6 Mar 2003 18:32:27 -0500
Date: Thu, 06 Mar 2003 15:33:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Robert Love <rml@tech9.net>, "Dimitrie O. Paun" <dimi@intelliware.ca>
cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <23050000.1046993597@flay>
In-Reply-To: <1046991923.715.64.camel@phantasy.awol.org>
References: <Pine.LNX.4.44.0303061725330.23356-100000@dimi.dssd.ca> <1046991923.715.64.camel@phantasy.awol.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Right, being able to control this interactivity knob programmatically
>> seems like a useful thing. That way, the window manager can boost the
>> interactivity of the foreground window for example. It does seem that
>> figuring out that something is interactive in the scheduler is tough,
>> there is just not enough information, whereas a higher layer may know
>> this for a fact. I guess this reduces my argument to just keeping the 
>> interactivity setting separate from priority.
> 
> No no no.  Martin's point shows exactly that nothing but the kernel can
> ever know whether a task is I/O or CPU bound.  What is bash?  Is it
> interactive (when you are typing into it) or CPU bound (when its running
> a script or doing other junk)?
> 
> Only the kernel knows exactly the sleep patterns of tasks, which is
> essentially whether or not a task is interactive.

Exactly ... all this tweaking, and setting up every app individually is bad.
It should "just frigging work" ;-) We seem to be pretty close to that
at the moment - 2.5 feels *so* much better than 2.4 already (2.4 degenerates
into a total slug overnight, presumably when things like man page reindexes
thrash the page cache).

The fact that the debian renice of the X server actually breaks things is
probably good news ... we're actually paying real attention to the nice
value ;-)

M.

