Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVAUCii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVAUCii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 21:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVAUCih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 21:38:37 -0500
Received: from gizmo04bw.bigpond.com ([144.140.70.14]:40647 "HELO
	gizmo04bw.bigpond.com") by vger.kernel.org with SMTP
	id S262235AbVAUCie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 21:38:34 -0500
Message-ID: <41F06B26.6000702@bigpond.net.au>
Date: Fri, 21 Jan 2005 13:38:30 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Marc E. Fiuczynski" <mef@cs.princeton.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Chris Han <xiphux@gmail.com>,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ANNOUNCE][RFC] plugsched-2.0 patches ...
References: <NIBBJLJFDHPDIBEEKKLPGELGDHAA.mef@cs.princeton.edu>
In-Reply-To: <NIBBJLJFDHPDIBEEKKLPGELGDHAA.mef@cs.princeton.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc E. Fiuczynski wrote:
> Peter, thank you for maintaining Con's plugsched code in light of Linus' and
> Ingo's prior objections to this idea.  On the one hand, I partially agree
> with Linus&Ingo's prior views that when there is only one scheduler that the
> rest of the world + dog will focus on making it better. On the other hand,
> having a clean framework that lets developers in a clean way plug in new
> schedulers is quite useful.
> 
> Linus & Ingo, it would be good to have an indepth discussion on this topic.
> I'd argue that the Linux kernel NEEDS a clean pluggable scheduling
> framework.
> 
> Let me make a case for this NEED by example.  Ingo's scheduler belongs to
> the egalitarian regime of schedulers that do a poor job of isolating
> workloads from each other in multiprogrammed environments such as those
> found on Enterprise servers and in my case on PlanetLab (www.planet-lab.org)
> nodes.  This has been rectified by HP-UX, Solaris, and AIX through the use
> of fair share schedulers that use O(1) schedulers within a share.  Currently
> PlanetLab uses a CKRM modified version of Ingo's scheduler.

I'm hoping that the CKRM folks will send me a patch to add their 
scheduler to plugsched :-)

>  Similarly, the
> linux-vserver project also modifies Ingo's scheduler to construct an
> entitlement based scheduling regime. These are not just variants of O(1)
> schedulers in the sense of Con's staircase O(1). Nor is it clear what the
> best type of scheduler is for these environments (i.e., HP-UX, Solaris and
> AIX don't have it fully solved yet either). The ability to dynamically swap
> out schedulers on a production system like PlanetLab would help in
> determining what type of scheduler is the most appropriate.  This is because
> it is non-trivial, if not impossible, to recreate the multiprogrammed
> workloads that we see in a lab.
> 
> For these reasons, it would be useful for plugsched (or something like it)
> to make its way into the mainline kernel as a framework to plug in different
> schedulers.  Alternatively, it would be useful to consider in what way
> Ingo's scheduler needs to support plugins such as the CKRM and Vserver types
> of changes.
> 
> Best regards,
> Marc


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
