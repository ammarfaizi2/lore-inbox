Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUJIAH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUJIAH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 20:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUJIAH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 20:07:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:3294 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266316AbUJIAH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 20:07:56 -0400
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <20041007072842.2bafc320.pj@sgi.com>
References: <20041007015107.53d191d4.pj@sgi.com>
	 <200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	 <20041007072842.2bafc320.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097280401.6470.112.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 08 Oct 2004 17:06:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 07:28, Paul Jackson wrote:
> Rick wrote:
> >     * There is no clear policy on how to amiably create an exclusive set.
> >       The main problem is what to do with the tasks already there.
> 
> There is a policy, that works well, and those of us in this business
> have been using for years.  When the system boots, you put everything
> that doesn't need to be pinned elsewhere in a bootcpuset, and leave
> the rest of the system dark.  You then, whether by manual administrative
> techniques or a batch scheduler, hand out dedicated sets of CPU and
> Memory to jobs, which get exclusive use of those compute resources
> (or controlled sharing with only what you intentionally let share).

No one is trying to take that away.  There is nothing that says you
can't boot with a small, 1-2 CPU 'boot' domain where you stick all those
tasks you typically put in a 'boot' cpuset.

<offtopic> In fact, people have talked before about reducing boot times
by booting only a single CPU, then bringing the rest online later.  This
work could potentially facilitate that.  Boot up just a single 'boot'
CPU.  All 'boot' tasks would necessarily be stuck there.  Create a new
'work' domain and add (hotplug on) CPUs into that domain to your heart's
content. </offtopic>

-Matt

