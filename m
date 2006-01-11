Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWAKAH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWAKAH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160998AbWAKAH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:07:58 -0500
Received: from xenotime.net ([66.160.160.81]:7627 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161000AbWAKAH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:07:57 -0500
Date: Tue, 10 Jan 2006 16:07:55 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Keith Owens <kaos@sgi.com>
cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       tony.luck@intel.com, Systemtap <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [patch 1/2] [BUG]kallsyms_lookup_name should return the text
 addres 
In-Reply-To: <19866.1136937775@ocs3.ocs.com.au>
Message-ID: <Pine.LNX.4.58.0601101606380.12724@shark.he.net>
References: <19866.1136937775@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, Keith Owens wrote:

> Keshavamurthy Anil S (on Tue, 10 Jan 2006 15:29:05 -0800) wrote:
> >On Wed, Jan 11, 2006 at 10:11:26AM +1100, Keith Owens wrote:
> >> Keshavamurthy Anil S (on Tue, 10 Jan 2006 13:07:37 -0800) wrote:
> >> >On Tue, Jan 10, 2006 at 08:45:02PM +0000, Paulo Marques wrote:
> >> >But my [patch 2/2] speeds up the lookup and that can go in, I think.
> >> >Please ack that patch if you think so.
> >>
> >> Your second patch changes the behaviour of kallsyms lookup w.r.t
> >> duplicate symbols.
> >With this send patch, kallsyms lookup first finds
> >the real text address which is what we want. If you consider
> >this as the change in behaviour, what is the negetive effect of this
> >I am unable to get it.
>
> Local symbols can be (and are) duplicated in the kernel code, and these
> duplicate symbols can appear in modules.  Changing the list order of
> loaded modules also changes which version of a duplicated symbol is
> returned by the kallsyms code.  Not a big deal, but annoying enough to
> say "don't change the module list order".
>
> Changing the thread slightly, kallsyms_lookup_name() has never coped
> with duplicate local symbols and it cannot do so without changing its
> API, and all its callers.  For debugging purposes, it would be nicer if
> the kernel did not have any duplicate symbols.  Perhaps some kernel
> janitor would like to take that task on.

Jesper Juhl was doing some -Wshadow patches.  Would that detect
duplicate symbols?

-- 
~Randy  [sees nothing wrong with dup. local symbols, except for debugging]
