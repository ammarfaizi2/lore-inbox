Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUJDOjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUJDOjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267769AbUJDOjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:39:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34751 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267449AbUJDOjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:39:32 -0400
Date: Mon, 4 Oct 2004 07:37:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: efocht@hpce.nec.com, akpm@osdl.org, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041004073713.2d047a24.pj@sgi.com>
In-Reply-To: <416156E8.7060708@watson.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<200410032221.26683.efocht@hpce.nec.com>
	<416156E8.7060708@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich wrote:
> > Can CKRM (as it is now) fulfil the requirements?
> ...
> [CKRM] doesn't care about the structure of the machine

Hubertus wrote:
> You forget that CKRM does NOT violate ... cpus_allowed ...
> ...
> In order to allow CKRM scheduling within a cpuset ...

I sense a disconnect here.

Seems to me Erich was asking if CKRM could be used _instead_ of cpusets,
and observes that, for now at least, CKRM lacks something.

Seems to me Hubertus is, _in_ _part_, responding to the question of
whether CKRM can be used _within_ cpusets, and claims to be taking a
position opposite to Erich's, protesting that indeed CKRM can be used
within cpusets - CKRM doesn't violate cpus_allowed constraints.

Hubertus - I didn't realize that Erich considered that question, not did
I realize he took that position.

Unfortunately, the plot thickens.  Hubertus goes on it seems to consider
other questions, and I start to lose the thread of his thought.  Such
questions as:

 - can RCFS/controllers set cpus_allowed as do cpusets?
	[ beware that there's more to cpusets than setting cpus_allowed ]
 - can cpusets replace shared based scheduling?
 - can share based scheduling replace cpusets?
 - can CKRM scheduling be allowed within cpusets?
 - are sibling cpusets exclusive?
	[ yes - if the exclusive property is set on them ]
 - can we enforce that a certain task class is limited to a cpuset subtree?

By now I'm thoroughly confused.  Fortunately, Hubertus concludes:

  - If we agree or disagree then we can work on a proposal for this.

Well, since I'm pretty sure from my Logic 101 class that we agree or
disagree, this is good news.  I'm glad to hear we can work on a proposal
on this [ what was 'this' again ...? ;) ]

One thing I am sure of ... either one of Hubertus or myself needs another
cup of coffee, or both Hubertus and I need to have a beer together.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
