Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbSJZBw1>; Fri, 25 Oct 2002 21:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSJZBw0>; Fri, 25 Oct 2002 21:52:26 -0400
Received: from fmr02.intel.com ([192.55.52.25]:12028 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261784AbSJZBwY>; Fri, 25 Oct 2002 21:52:24 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000ECE70ED@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@tech9.net>, "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo
Date: Fri, 25 Oct 2002 18:58:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I mean what you were referring to is called Chip-Multiprocessor (CMP),
architecturally. And probably, this is the cause of the confusion in the
discussions.

SMT is an orthogonal to it, and it is an established notion. You can have
SMT CMP, for example. So using "thread" for the cores in CMP is not proper
wording. It sounds something like "core" to me.  

In my mind, the processor hierarchy looks like:
	node    
	package (chip die)	
	core			
	thread

Jun
-----Original Message-----
From: Nakajima, Jun 
Sent: Friday, October 25, 2002 5:54 PM
To: 'Rik van Riel'; Alan Cox
Cc: Nakajima, Jun; Robert Love; 'Dave Jones'; 'akpm@digeo.com';
'linux-kernel@vger.kernel.org'; 'chrisl@vmware.com'; 'Martin J. Bligh'
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo


I don't understand. HT is one implementaion of (true) SMT. 

Thanks,
Jun

-----Original Message-----
From: Rik van Riel [mailto:riel@conectiva.com.br]
Sent: Friday, October 25, 2002 5:49 PM
To: Alan Cox
Cc: Nakajima, Jun; Robert Love; 'Dave Jones'; 'akpm@digeo.com';
'linux-kernel@vger.kernel.org'; 'chrisl@vmware.com'; 'Martin J. Bligh'
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo


On 25 Oct 2002, Alan Cox wrote:
> On Fri, 2002-10-25 at 22:50, Nakajima, Jun wrote:

> > Can you please change "siblings\t" to "threads\t\t". SuSE 8.1, for
example,
> > is already doing it:

> Im just wondering what we would then use to describe a true multiple cpu
> on a die x86. Im curious what the powerpc people think since they have
> this kind of stuff - is there a generic terminology they prefer ?

Agreed.  Siblings is probably best for HT stuff and threads
are probably best reserved for true SMT CPUs.

Then there's the SMP-on-a-chip, but we should probably just
call those CPUs.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a
href=mailto:"october@surriel.com">october@surriel.com</a>
