Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEBQx>; Thu, 4 Jan 2001 20:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbRAEBQn>; Thu, 4 Jan 2001 20:16:43 -0500
Received: from jalon.able.es ([212.97.163.2]:40833 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129183AbRAEBQa>;
	Thu, 4 Jan 2001 20:16:30 -0500
Date: Fri, 5 Jan 2001 02:16:23 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: "James H . Cloos Jr ." <cloos@jhcloos.com>
Cc: "Michael D . Crawford" <crawford@goingware.com>,
        linux-kernel@vger.kernel.org
Subject: Re: How to Power off with ACPI/APM?
Message-ID: <20010105021623.C743@werewolf.able.es>
In-Reply-To: <3A54DC87.5B861B7@goingware.com> <m37l4akdn5.fsf@austin.jhcloos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <m37l4akdn5.fsf@austin.jhcloos.com>; from cloos@jhcloos.com on Fri, Jan 05, 2001 at 02:10:06 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.05 James H. Cloos Jr. wrote:
> Michael> APM gives its message first in the boot process, then later
> Michael> ACPI does.  But ACPI says something like "APM already
> Michael> present, exiting", so the doc is wrong both ways you read it,
> Michael> or else ACPI doesn't succeed in the intended behavior to
> Michael> override APM.
> 
> I get th eopposite behavior.  If both are compiled in only ACPI works.
> (Only tested w/ 2.4.0-test kernels, though.)
> 
> Either way you need the userspace daemon running to actually do
> anything.  Even my notebook's key for toggling full-screen vs
> un-expanded display on the lcd does nothing unless apmd or acpid
> as applicable are running....
> 

How is each of your setups, ie, what is compiled in kernel and what is
a module ? My guess is:
- ACPI+APM in kernel: ACPI wins
- APM in kernel, ACPI module; APM starts, blocks ACPI
- and so on....

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre6 #1 SMP Wed Jan 3 21:28:10 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
