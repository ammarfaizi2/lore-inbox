Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWITU1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWITU1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWITU1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:27:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40834 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750758AbWITU1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:27:46 -0400
Date: Wed, 20 Sep 2006 13:27:34 -0700
From: Paul Jackson <pj@sgi.com>
To: sekharan@us.ibm.com
Cc: menage@google.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920132734.69ab4f57.pj@sgi.com>
In-Reply-To: <1158778496.6536.95.camel@linuxchandra>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158777240.6536.89.camel@linuxchandra>
	<6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	<1158778496.6536.95.camel@linuxchandra>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra wrote:
> We had this discussion more than 18 months back and concluded that it is
> not the right thing to do. Here is the link to the thread:

Because it is easy enough to carve memory up into nice little nameable
chunks, it might be the case that we can manage the percentage of
memory used by the expedient of something like cpusets and fake nodes.

Indeed, that seems to be doable, based on this latest work of Andrew
and others (David, some_bright_spark@jp, Magnus, ...).  There are
still a bunch of wrinkles that remain to be ironed out.

For other resources, such as CPU cycles and network bandwidth, unless
another bright spark comes up with an insight, I don't see how to
express the "percentage used" semantics provided by something such
as CKRM, using anything resembling cpusets.

... Can one imagine having the scheduler subdivide each second of
time available on a CPU into several fake-CPUs, each one of which
speaks for one of those sub-second fake-CPU slices?  Sounds too
weird to me, and a bit too rigid to be a servicable CKRM substitute.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
