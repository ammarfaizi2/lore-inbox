Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWFVQOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWFVQOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWFVQOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:14:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6297 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030296AbWFVQOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:14:32 -0400
Date: Thu, 22 Jun 2006 09:14:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: rdunlap@xenotime.net, ntl@pobox.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com, pavel@ucw.cz,
       ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
In-Reply-To: <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0606220909350.28399@schroedinger.engr.sgi.com>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
 <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain>
 <20060622084513.4717835e.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com>
 <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006, KAMEZAWA Hiroyuki wrote:

> Hm..
> Then, there is several ways to manage this sitation.
> 
> 1. migrate all even if it's not allowed by users

If its not allowed then the system should not do this. Otherwise we get an 
inconsistent system with lots of exceptions just because the user can
do something stupid.

> 2. kill mis-configured tasks.

If the user misconfigured then its their problem.

> 3. stop ...

That wont work well since the process may ignore stops. We have no history 
of stopping processes. This would be new functionality to pioneer in 
Linux.

> 4. cancel cpu-hot-removal.
> 
> I just don't like "1". 
> I discussed this problem with my colleagues before sending patch,
> one said "4" seems regular way but another said "4" is bad.

4 is a good thing. Just give the user some feedback as to why. F.e. write 
a message to the syslog. This is the way we deal with many other 
problem situations.
 
> I sent a patch for "4" in the first place but Andi Kleen said it's bad.
> As he said, I'm handling the problem for which I can't find a good answer :(

Andi: Why is 4 bad?

