Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVBIAZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVBIAZu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 19:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVBIAZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 19:25:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39055 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261713AbVBIAZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 19:25:41 -0500
Date: Tue, 8 Feb 2005 16:24:43 -0800
From: Paul Jackson <pj@sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: dino@in.ibm.com, mbligh@aracnet.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20050208162443.0f8068c6.pj@sgi.com>
In-Reply-To: <420939B6.7010608@us.ibm.com>
References: <20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<1097014749.4065.48.camel@arrakis>
	<420800F5.9070504@us.ibm.com>
	<20050208095440.GA3976@in.ibm.com>
	<42090C42.7020700@us.ibm.com>
	<20050208124234.6aed9e28.pj@sgi.com>
	<420939B6.7010608@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew wrote:
> I should have been more clear that CKRM and CPUSETs (seem) to 
> be unreconcilable.  Sched_domains and CPUSETs (seem) to have some potential 
> functionality overlap that leads me to (still) believe there is hope to 
> integrate these two systems.

Aha - now we're getting somewhere.

I was under the illusion these last four months that you were going to
serve as priest at the shotgun wedding that Andrew had requested be
arranged between cpusets and CKRM.  All this time, you were hoping to
get cpusets hooked up with sched domains.

My daughter 'cpusets' sure is popular ;).

If cpusets were somehow to be subsumed into CKRM, it would likely have
meant reincarnating cpusets in a new form, varying in some degree, large
or small, from its current form.  If that had been in our forseeable
future, then we would not have wanted to put cpusets in its current form
in the main tree.  It's alot easier to change API's that aren't API's
yet.

I remain certain that cpusets don't fit in CKRM.  Not even close.

The merger of cpusets and sched domains is an entirely different affair,
in my view.  It's an internal optimization, having next to zero impact
on any API's that the kernel presents to userland.  On most systems, it
would be of no particular benefit.  But on big honkin numa boxes making
heavy use of cpusets, it might make the schedulers work more efficient. 
Or might not.  I will leave that up to others to figure out, when and if
they choose to.  I'll be glad to help with such an effort, what little
I can, if it comes about.

If such an integration between cpusets and sched domains is in our
future, we should first get cpusets into the kernel, and then the
appropriate experts can refine the interaction of cpusets with sched
domains.  In this case, the sooner cpusets goes in, the better, so that
the integration effort with sched domains can commence, confident that
cpusets are here to stay.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
