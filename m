Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266075AbUHMPzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUHMPzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 11:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUHMPzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 11:55:45 -0400
Received: from commedia.cnds.jhu.edu ([128.220.221.1]:50374 "EHLO
	commedia.cnds.jhu.edu") by vger.kernel.org with ESMTP
	id S266075AbUHMPzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 11:55:08 -0400
Date: Fri, 13 Aug 2004 11:54:41 -0400
From: Jonathan Stanton <jonathan@cnds.jhu.edu>
To: sdake@mvista.com,
       Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, dcl_discussion@osdl.org,
       linux-kernel@vger.kernel.org, cgl_discussion@osdl.org
Subject: Re: [Linux-cluster] Re: [cgl_discussion] Re: [dcl_discussion] Clustersummit materials
Message-ID: <20040813155441.GA16662@cnds.jhu.edu>
References: <3689AF909D816446BA505D21F1461AE4C75110@cacexc04.americas.cpqcorp.net> <1092249962.4717.21.camel@persist.az.mvista.com> <20040812095736.GE4096@marowsky-bree.de> <1092332536.7315.1.camel@persist.az.mvista.com> <20040812203738.GK9722@marowsky-bree.de> <1092351549.7315.5.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092351549.7315.5.camel@persist.az.mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just joined the linux-cluster list after seeing a few of the messages 
that were cross-posted to linux-kernel. 

On Thu, Aug 12, 2004 at 03:59:10PM -0700, Steven Dake wrote:
> Lars
> 
> Thanks for posting transis.  I had a look at the examples and API.  The
> API is of course different then openais and focused on client/server
> architecture.

If you havn't looked at it already, you might want to try out the Spread
group communication system. 

http://www.spread.org/

It is, conceptually although not code-wise, a decendant of the Transis
work (and the Totem system from UCSB)  and is relatively widely used as a
production quality group messaging system (Some apache modules use it
along with a number of large web-clusters, a few commercial clustered
storage systems, and a lot of custom replication apps). It is not under
GPL but is open-source under a bsd-style (but not exactly the same)
license.

Like transis it has a client-server architecture (and a simpler API). 

> I tried a performance test by sending a 64k message, and then receiving
> it 10 times with two nodes.  This operation takes about 5 seconds on my
> hardware which is 128k/sec.  I was expecting more like 8-10MB/sec.  Is
> there anything that can be done to improve the performance?

I would expect transis to definitely do better then 128k/s given tests we
ran a number of years ago, but on upto medium sized lan environments the
totem/spread protocols are generally faster with less cpu overhead. I know
Spread could get 80Mb/s a number of years ago. We recently re-ran a clean
set of benchmarks and wrote them up. You can find them at:

http://www.cnds.jhu.edu/pub/papers/cnds-2004-1.pdf

I admit some bias as I'm one of the lead developers of Spread, and we (the 
developers) have been building group messaging systems since the early 
90's -- so I may look at things a bit differently -- so I would be very 
intersted in your thoughts on how you could use GCS and whether Spread 
would be useful. 

Cheers,

Jonathan

-- 
-------------------------------------------------------
Jonathan R. Stanton         jonathan@cs.jhu.edu
Dept. of Computer Science   
Johns Hopkins University    
-------------------------------------------------------
