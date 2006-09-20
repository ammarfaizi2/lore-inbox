Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWITQUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWITQUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWITQUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:20:06 -0400
Received: from smtp-out.google.com ([216.239.45.12]:53919 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751696AbWITQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:20:04 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=RzXrN3LGRPv/21yrVSNxDFIDjScg/MdHHSc1xRR8pu3KdV7u5pxDQEk3TDVEekpvA
	RQSZQV8jotGAFynaRwT4w==
Subject: Re: [Patch04/05]- Containers: Core Container support
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, devel@openvz.org, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060920113238.29745a4b.kamezawa.hiroyu@jp.fujitsu.com>
References: <1158284550.5408.156.camel@galaxy.corp.google.com>
	 <20060920113238.29745a4b.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 09:19:35 -0700
Message-Id: <1158769175.8574.1.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 11:32 +0900, KAMEZAWA Hiroyuki wrote:
> On Thu, 14 Sep 2006 18:42:30 -0700
> Rohit Seth <rohitseth@google.com> wrote:
> 
> > This patch has the definitions and other core part of container support
> > implementing all the counters for different resources (like tasks, anon
> > memory etc.).
> > 
> 
> > +int container_add_task(struct task_struct *task, struct task_struct *parent,
> > +		struct container_struct *ctn)
> > +{
> 
> What should happen if a process of thread-group is newly added/removed ?
> (I think only thread-group-leader can be added/removed)
> 


If there are multiple threads then each thread will need to be
individually added into the container.  This keeps the semantics clean
and implementation simple.

-rohit

