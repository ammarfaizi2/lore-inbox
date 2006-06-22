Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWFVQVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWFVQVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030643AbWFVQVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:21:37 -0400
Received: from xenotime.net ([66.160.160.81]:37001 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030624AbWFVQVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:21:36 -0400
Date: Thu, 22 Jun 2006 09:24:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: clameter@sgi.com, ntl@pobox.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com, pavel@ucw.cz,
       ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
Message-Id: <20060622092422.256d6692.rdunlap@xenotime.net>
In-Reply-To: <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
	<20060621225609.db34df34.akpm@osdl.org>
	<20060622150848.GL16029@localdomain>
	<20060622084513.4717835e.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com>
	<20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 01:05:50 +0900 KAMEZAWA Hiroyuki wrote:

> On Thu, 22 Jun 2006 08:45:55 -0700 (PDT)
> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > On Thu, 22 Jun 2006, Randy.Dunlap wrote:
> > 
> > > Sounds much better than just killing the process.
> > 
> > Right and having active interrupts or devices using that processor should 
> > also stop offlining a processor.
> > 
> > So just remove everything from a processor before offlining. If you cannot 
> > remove all users then the processor cannot be offlined.
> > 
> Hm..
> Then, there is several ways to manage this sitation.
> 
> 1. migrate all even if it's not allowed by users
> 2. kill mis-configured tasks.

I would claim that the tasks are not misconfigured,
but that the admin misconfigured the hardware (CPU).

> 3. stop ...
> 4. cancel cpu-hot-removal.
> 
> I just don't like "1". 

I like it better than 2.

> I discussed this problem with my colleagues before sending patch,
> one said "4" seems regular way but another said "4" is bad.
> 
> I sent a patch for "4" in the first place but Andi Kleen said it's bad.
> As he said, I'm handling the problem for which I can't find a good answer :(
> 
> my point is that "1" is bad.

Sounds like we are getting nowhere.  The sysctl knob might
have to be the answer.

---
~Randy
