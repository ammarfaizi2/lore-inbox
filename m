Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269614AbUJFWyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269614AbUJFWyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269531AbUJFWyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:54:04 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:27037 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269596AbUJFWwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:52:33 -0400
Date: Wed, 6 Oct 2004 15:49:58 -0700
From: Paul Jackson <pj@sgi.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Simon.Derr@bull.net, colpatch@us.ibm.com, mbligh@aracnet.com,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041006154958.18d9d917.pj@sgi.com>
In-Reply-To: <416469D5.9050202@bigpond.net.au>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<1097014749.4065.48.camel@arrakis>
	<20041005194702.0644070b.pj@sgi.com>
	<Pine.LNX.4.61.0410061114470.19964@openx3.frec.bull.fr>
	<416469D5.9050202@bigpond.net.au>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter protests:
> I think that this is becoming overly complicated.

My brainstorming ways to accomodate the isolation that the scheduler,
allocator and resource manager domains require is getting ahead of
itself.

First I need to hear from the CKRM folks what degree of isolation they
really need, the essential minimum, and how they intend to accomodate
not just cpusets, but also the other placement API's sched_setaffinity,
mbind and set_mempolicy, as well as the per-cpu kernel threads.

Then it makes sense to revisit the implementation.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
