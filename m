Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263730AbUC3P2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbUC3P2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:28:23 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:27326 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263735AbUC3P1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:27:38 -0500
Date: Tue, 30 Mar 2004 07:27:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Erich Focht <efocht@hpce.nec.com>
cc: Andi Kleen <ak@suse.de>, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <5380000.1080660424@[10.10.2.4]>
In-Reply-To: <406935A6.4030203@yahoo.com.au>
References: <20040329080150.4b8fd8ef.ak@suse.de> <20040329114635.GA30093@elte.hu> <20040329221434.4602e062.ak@suse.de> <4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de> <40691BCE.2010302@yahoo.com.au> <205870000.1080630837@[10.10.2.4]> <4069223E.9060609@yahoo.com.au> <20040330080530.GA22195@elte.hu> <40692D95.8030605@yahoo.com.au> <20040330084501.GA23069@elte.hu> <406935A6.4030203@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, it will be interesting to see how it goes. Unfortunately
> I don't have a single realistic benchmark. 

That's OK, neither does anyone else ;-) OK, for HPC workloads they do,
but not for other stuff.

The closest I can come conceptually is to run multiple instances of a 
Java benchmark in parallel. The existing ones all tend to be either 1 
process with many threads, or many processes each with one thread. There's 
no m x n benchamrks around I've found, and that seems to be a lot more 
like what the customers I've seen are interested in (throwing a DB, 
webserver, java, etc all on one machine).

Making balance_on_fork a userspace hintable thing wouldn't hurt us at all
though, and would provide a great escape route for the HPC people. 
Some simple pokeable in /proc would probably be sufficient. balance_on_clone
is harder, as whether you want to do it or not depends more on the state
of the rest of the system, which is very hard for userspace to know ...

M.




