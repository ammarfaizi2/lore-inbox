Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269786AbUJHKmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269786AbUJHKmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 06:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269772AbUJHKmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 06:42:52 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:23964 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S269766AbUJHKmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 06:42:33 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Fri, 8 Oct 2004 12:40:26 +0200
User-Agent: KMail/1.6.2
Cc: mbligh@aracnet.com, pj@sgi.com, Simon.Derr@bull.net, colpatch@us.ibm.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       ak@suse.de, sivanich@sgi.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200410081123.45762.efocht@hpce.nec.com> <20041008025034.3deedac5.akpm@osdl.org>
In-Reply-To: <20041008025034.3deedac5.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410081240.26482.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 October 2004 11:50, Andrew Morton wrote:
> So it's a quite cheap patch for the kernel.org people to carry.
> 
> So I'm (just) OK with it from that point of view.  My main concern is that
> the CKRM framework ought to be able to accommodate the cpuset function,
> dammit.  I don't want to see us growing two orthogonal resource management
> systems partly because their respective backers have no incentive to make
> their code work together.

I don't think cpusets needs to grow beyond what it contains now. The
discussion started as an API discussion. Cpusets requirements, current
API and usage models were clearly shown. According to Hubertus CKRM
will be able to deal with these and implement them in its own API. It
isn't today. So why not wait for that? Having two APIs for the same
thing isn't unusual. Whether we switch from affinity to sched_domains
underneath isn't really the question.

> I realise there are technical/architectural problems too, but I do fear
> that there's a risk of we-don't-have-a-business-case happening here too.

ISVs are already using the current cpusets API. I think of resource
management systems like PBS (Altair), LSF (Platform Computing) plus
several providers of industrial simulation codes in the area of CAE
(computer aided engineering). I know examples from static and dynamic
mechanical stress analysis, fluid dynamics and electromagnetics
simulations. Financial simulation software could benefit of such
stuff, too, but I don't know of any example. Anyhow, I'd say we
already have a business case here. And instead of pushing ISVs to
support the SGI way of doing this, the Bull way and the NEC way, it
makes more sense to ask them to support the LINUX way.

> But we're not there yet - we're still waiting for the design dust to
> settle.

:-)

Regards,
Erich


