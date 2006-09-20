Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWITRhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWITRhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWITRhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:37:36 -0400
Received: from smtp-out.google.com ([216.239.45.12]:21180 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932135AbWITRhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:37:35 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=hWvocdnGb9ou/JIwedxcfI+sWw0QH6t40/Yvdt2SN+sB3xu1Bdt1K0l+z/tjF9TZb
	eoUC31sEySDUSgRJqOM2A==
Message-ID: <6599ad830609201037j62276d94q3514df7edb0870dc@mail.google.com>
Date: Wed, 20 Sep 2006 10:37:19 -0700
From: "Paul Menage" <menage@google.com>
To: rohitseth@google.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: "Christoph Lameter" <clameter@sgi.com>, npiggin@suse.de, pj@sgi.com,
       linux-kernel <linux-kernel@vger.kernel.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <1158773208.8574.53.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158773208.8574.53.camel@galaxy.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Rohit Seth <rohitseth@google.com> wrote:
>
> cpusets provides cpu and memory NODES binding to tasks.  And I think it
> works great for NUMA machines where you have different nodes with its
> own set of CPUs and memory.  The number of those nodes on a commodity HW
> is still 1.  And they can have 8-16 CPUs and in access of 100G of
> memory.  You may start using fake nodes (untested territory) to

I've been experimenting with this, and it's looking promising.

>
> Containers also provide a mechanism to move files to containers. Any
> further references to this file come from the same container rather than
> the container which is bringing in a new page.

This could be done with memory nodes too - a vma can specify its
memory policy, so binding individual files to nodes shouldn't be hard.

>
> In future there will be more handlers like CPU and disk that can be
> easily embeded into this container infrastructure.

I think that at least the userspace API for adding more handlers would
need to be defined before actually committing a container patch, even
if the kernel code isn't yet extensible. The CKRM/RG interface is a
good start towards this.

Paul
