Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUJHS3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUJHS3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUJHS1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:27:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54219 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263778AbUJHSZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:25:57 -0400
Date: Fri, 8 Oct 2004 11:23:19 -0700
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: ricklind@us.ibm.com, colpatch@us.ibm.com, mbligh@aracnet.com,
       Simon.Derr@bull.net, pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041008112319.63b694de.pj@sgi.com>
In-Reply-To: <4166B569.60408@watson.ibm.com>
References: <20041007015107.53d191d4.pj@sgi.com>
	<200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	<20041007072842.2bafc320.pj@sgi.com>
	<4165A31E.4070905@watson.ibm.com>
	<20041008061426.6a84748c.pj@sgi.com>
	<4166B569.60408@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus, responding to Paul:
> >  (*) P.S. - It's more like CKRM is now the combination of
> >      a virtual resource manager framework and a particular
> >      instance of such (the fair shair controllers that have
> >      their conceptual origins in IBM's WLM, I suspect).  If
> >      numa placement controllers (aka cpusets) are going to
> >      exist as well, then CKRM needs to split into (1) a
> >      virtual resource manager framework (vrm), and (2) the
> >      fair share stuff.  The vrm framework should be neutral
> >      of either fair share or numa placement bias.
> 
> As indicated in many notes so are the usage of cpusets.

Cpusets pretends to be nothing more than what it is now.  I am not
recommending to Andrew that cpusets incorporate your fair shair
scheduling.

CKRM aspires to be both a general purpose resource management framework
and the embodiment of fair share scheduling.

Let me put the question again, and this time don't try to dodge it by
saying "but cpusets does it too ..."

> >      If numa placement controllers (aka cpusets) are going to
> >      exist as well, then CKRM needs to split into (1) a
> >      virtual resource manager framework (vrm), and (2) the
> >      fair share stuff.  The vrm framework should be neutral
> >      of either fair share or numa placement bias.

Hubertus' second response to the above:
>
> Very few people have the #cpus to even worry about this.

If for whatever reason, you don't think it is worth the effort to morph
the virtual resouce manager that is currently embedded within CKRM into
an independent, neutral framework, then don't expect the rest of us to
embrace it.  Do you think Reiser would have gladly used vfs to plug in
his file system if it had been called "ext"?  In my personal opinion, it
would be foolhardy for SGI, NEC, Bull, Platform (LSF) or Altair (PBS) to
rely on critical technology so clearly biased toward and dominated by a
natural competitor.

> But by self admission, you are driven by timing constraints as
> your bacon is sizzling.

You broke your promise - you said no more analogies ;)

Of _course_ I have scheduling pressures.  You don't?

> > Keep talking.
> 
> To whom ?   :-)

A duh ... to us, here.

Just in case there was a communication failure here, let me be explicit.
When I said "Here's where I stand today - keep talking" it meant that my
current position was thus, but that I was still open to further
discussion and analysis.

When someone offers you an open door ("Keep talking"), don't slam it in
their face.  It might not open again.

... keep talking ...

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
