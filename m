Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUA0CQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 21:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbUA0CQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 21:16:58 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:2266 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261779AbUA0CQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 21:16:57 -0500
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: New NUMA scheduler and hotplug CPU
Date: Mon, 26 Jan 2004 20:19:13 -0600
User-Agent: KMail/1.5
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20040125235431.7BC192C0FF@lists.samba.org> <200401261740.12657.habanero@us.ibm.com> <35060000.1075162177@flay>
In-Reply-To: <35060000.1075162177@flay>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401262019.13824.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 January 2004 18:09, Martin J. Bligh wrote:
> > For example, you boot on just the boot cpu, which by default is in the
> > first node on the first runqueue.  All other cpus, whether being "booted"
> > for the for the first time or hotplugged (maybe now there's really no
> > difference), the hotplugging tells where the cpu should be, in what node
> > and what runqueue.  HT cpus work even better, because you can hotplug
> > siblings, once at a time if you wanted, to the same runqueue.  Or you
> > have cpus sharing a die, same thing, lots of choices here.  This removes
> > any per-arch updates to the kernel for things like scheduler topology,
> > and lets them go somewhere else more easily changes, like userspace.
>
> Ummm ... but *none* of that is dictated as policy stuff - it's all just
> the hardware layout of the machine. You cannot "decide" as the sysadmin
> which node a CPU is in, or which HT sibling it has. It's just there ;-)
> The only thing you could possibly dictate is the CPU number you want
> assigned to the new CPU, which frankly, I think is pointless - they're
> arbitrary tags, and always have been.

How many cpus share a runqueue IMO could be a policy thing.  Some HT cpus may 
be better sharing a runqueue where others (lots and lots of siblings in one 
core) may not.

