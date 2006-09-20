Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWITUtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWITUtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWITUtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:49:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:59569 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750774AbWITUtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:49:14 -0400
Date: Wed, 20 Sep 2006 13:49:03 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: sekharan@us.ibm.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920134903.fbd9fea8.pj@sgi.com>
In-Reply-To: <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158777240.6536.89.camel@linuxchandra>
	<6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	<1158778496.6536.95.camel@linuxchandra>
	<6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> Even if the resource control portions aren't totally compatible,
> having two separate process container abstractions in the kernel is
> sub-optimal

At heart, CKRM (ne Resource Groups) are (well, have been until now)
different than cpusets.

Cpusets answers the question 'where', and Resource Groups 'how much'.

The fundamental motivation behind cpusets was to be able to enforce
job isolation.  A job can get dedicated use of specified resources,
-even- if it means those resources are severely underutilized by that
job.

The fundamental motivation (Chandra or others correct me if I'm wrong)
of Resource Groups is to improve capacity utilization while limiting
starvation due to greedy, competing users for the same resources.

Cpusets seeks maximum isolation.  Resource Groups seeks maximum
capacity utilization while preserving guaranteed levels of quality
of service.

Cpusets are that wall between you and the neighbor you might not
trust.  Resource groups are a large family of modest wealth sitting
down to share a meal.

It seems that cpusets can mimic memory resource groups.  I don't
see how cpusets could mimic other resource groups.  But maybe I'm
just being a dimm bulb.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
