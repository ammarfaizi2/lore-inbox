Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbVIHWvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbVIHWvh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVIHWvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:51:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46045 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965061AbVIHWvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:51:36 -0400
Subject: Re: [ckrm-tech] Re: [PATCH 0/5] SUBCPUSETS: a resource control
	functionality using CPUSETS
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: dino@in.ibm.com
Cc: Paul Jackson <pj@sgi.com>, KUROSAWA Takahiro <kurosawa@valinux.co.jp>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
In-Reply-To: <20050908131427.GA5994@in.ibm.com>
References: <20050908053912.1352770031@sv1.valinux.co.jp>
	 <20050908002323.181fd7d5.pj@sgi.com>  <20050908131427.GA5994@in.ibm.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 08 Sep 2005 15:51:29 -0700
Message-Id: <1126219889.21617.91.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-08 at 18:44 +0530, Dinakar Guniguntala wrote:
> Interesting implementation of resource controls. Cross posting this 

I second this :)

Browsed a little through the docs/patches... seems to fit very well into
a resource management solution (hint CKRM :) than CPUSET (resource
isolation).

I can see the usefulness of resource management inside CPUSET. We have
had discussions earlier(in lkml and lse-tech) about how CKRM can play
inside a CPUSET, and this plays directly into that, providing resource
management inside a CPUSET.

The parameters used, guarantee and limit, fits very well into CKRM's
shares usage model.

Takahiro-san, How much effort you think will be needed to make this work
under CKRM. thanks.

> to ckrm-tech as well. I am sure CKRM folks have something to say...
> 
> Any thoughts about how you want to add more resource control features
> on top of/in addition to this setup. (Such as memory etc)
> 
> 
> On Thu, Sep 08, 2005 at 12:23:23AM -0700, Paul Jackson wrote:
> > I'm guessing you do not want such cpusets (the parents of subcpusets)
> > to overlap, because if they did, it would seem to confuse the meaning
> > of getting a fixed proportion of available cpu and memory resources.  I
> > was a little surprised not to see any additional checks that
> > cpu_exclusive and mem_exclusive must be set true in these cpusets, to
> > insure non- overlapping cpusets.
> 
> I agree with Paul here. You would want to build your controllers
> on top of exclusive cpusets to keep things sane.
> 
> > On the other hand, Dinakar had more work to do than you might, because
> > he needed a complete covering (so had to round up cpus in non exclusive
> > cpusets to form more covering elements).  From what I can tell, you
> > don't need a complete covering - it seems fine if some cpus are not
> > managed by this resource control function.
> 
> 
> I think it makes more sense to add this functionality directly as part
> of the existing cpusets instead of creating further leaf cpusets (or subcpusets
> as you call it) where we can specify resource control parameters. I think that 
> approach would be much more intuitive and simple to work with rather than 
> what you have currently. 
> 
> 	-Dinakar
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


