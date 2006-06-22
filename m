Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbWFVQGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWFVQGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWFVQGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:06:47 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:1157 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161114AbWFVQGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:06:46 -0400
Date: Fri, 23 Jun 2006 01:05:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: rdunlap@xenotime.net, ntl@pobox.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com, pavel@ucw.cz,
       ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
Message-Id: <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
	<20060621225609.db34df34.akpm@osdl.org>
	<20060622150848.GL16029@localdomain>
	<20060622084513.4717835e.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 08:45:55 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Thu, 22 Jun 2006, Randy.Dunlap wrote:
> 
> > Sounds much better than just killing the process.
> 
> Right and having active interrupts or devices using that processor should 
> also stop offlining a processor.
> 
> So just remove everything from a processor before offlining. If you cannot 
> remove all users then the processor cannot be offlined.
> 
Hm..
Then, there is several ways to manage this sitation.

1. migrate all even if it's not allowed by users
2. kill mis-configured tasks.
3. stop ...
4. cancel cpu-hot-removal.

I just don't like "1". 
I discussed this problem with my colleagues before sending patch,
one said "4" seems regular way but another said "4" is bad.

I sent a patch for "4" in the first place but Andi Kleen said it's bad.
As he said, I'm handling the problem for which I can't find a good answer :(

my point is that "1" is bad.
-Kame

