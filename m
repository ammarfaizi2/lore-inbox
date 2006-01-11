Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWAKAkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWAKAkP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWAKAkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:40:14 -0500
Received: from fmr23.intel.com ([143.183.121.15]:45007 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030195AbWAKAkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:40:12 -0500
Date: Tue, 10 Jan 2006 16:39:57 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keith Owens <kaos@sgi.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       tony.luck@intel.com, Systemtap <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [patch 1/2] [BUG]kallsyms_lookup_name should return the text addres
Message-ID: <20060110163956.A17329@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <Pine.LNX.4.58.0601101606380.12724@shark.he.net> <20396.1136939008@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20396.1136939008@ocs3.ocs.com.au>; from kaos@sgi.com on Wed, Jan 11, 2006 at 11:23:28AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 11:23:28AM +1100, Keith Owens wrote:
> "Randy.Dunlap" (on Tue, 10 Jan 2006 16:07:55 -0800 (PST)) wrote:
> >On Wed, 11 Jan 2006, Keith Owens wrote:
> >> Changing the thread slightly, kallsyms_lookup_name() has never coped
> >> with duplicate local symbols and it cannot do so without changing its
> >> API, and all its callers.  For debugging purposes, it would be nicer if
> >> the kernel did not have any duplicate symbols.  Perhaps some kernel
> >> janitor would like to take that task on.
> >
> >Jesper Juhl was doing some -Wshadow patches.  Would that detect
> >duplicate symbols?
> 
> No, the duplicate symbols are (a) static and (b) in separate source
> files.  Run this against a System.map.
> 
>  awk '{print $NF}' System.map | egrep -v '^__ks|^__func' | sort | uniq -dc | LANG=C sort -k2

Humm..This duplication of symbols in the kernel will be a 
problem for systemtap scripts, as we might end up putting probes
in the unwanted places :-(

I agree with you Keith, from the debugging purposes, it 
would make sense not to have any duplicate symbols.

Thanks,
Anil

