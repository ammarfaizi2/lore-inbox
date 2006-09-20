Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWITSzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWITSzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWITSzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:55:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:32928 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932251AbWITSzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:55:04 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Menage <menage@google.com>
Cc: npiggin@suse.de, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, pj@sgi.com,
       Rohit Seth <rohitseth@google.com>, devel@openvz.org,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 20 Sep 2006 11:54:56 -0700
Message-Id: <1158778496.6536.95.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 11:43 -0700, Paul Menage wrote:
> On 9/20/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> > > We already have such a functionality in the kernel its called a cpuset. A
> >
> > Christoph,
> >
> > There had been multiple discussions in the past (as recent as Aug 18,
> > 2006), where we (Paul and CKRM/RG folks) have concluded that cpuset and
> > resource management are orthogonal features.
> >
> > cpuset provides "resource isolation", and what we, the resource
> > management guys want is work-conserving resource control.
> 
> CPUset provides two things:
> 
> - a generic process container abstraction
> 
> - "resource controllers" for CPU masks and memory nodes.
> 
> Rather than adding a new process container abstraction, wouldn't it
> make more sense to change cpuset to make it more extensible (more
> separation between resource controllers), possibly rename it to
> "containers", and let the various resource controllers fight it out
> (e.g. zone/node-based memory controller vs multiple LRU controller,
> CPU masks vs a properly QoS-based CPU scheduler, etc)
> 
> Or more specifically, what would need to be added to cpusets to make
> it possible to bolt the CKRM/RG resource controllers on to it?

Paul,

We had this discussion more than 18 months back and concluded that it is
not the right thing to do. Here is the link to the thread:

http://marc.theaimsgroup.com/?t=109173653100001&r=1&w=2

chandra
> 
> Paul
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


