Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAEJdb>; Fri, 5 Jan 2001 04:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbRAEJdW>; Fri, 5 Jan 2001 04:33:22 -0500
Received: from jalon.able.es ([212.97.163.2]:42122 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129436AbRAEJdO>;
	Fri, 5 Jan 2001 04:33:14 -0500
Date: Fri, 5 Jan 2001 10:33:06 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Dominik Kubla <dominik.kubla@uni-mainz.de>
Cc: "Michael D . Crawford" <crawford@goingware.com>,
        linux-kernel@vger.kernel.org
Subject: Re: How to Power off with ACPI/APM?
Message-ID: <20010105103306.C2095@werewolf.able.es>
In-Reply-To: <3A55403C.39E4A48B@goingware.com> <20010105101846.A2095@werewolf.able.es> <20010105102356.B17200@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010105102356.B17200@uni-mainz.de>; from dominik.kubla@uni-mainz.de on Fri, Jan 05, 2001 at 10:23:56 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.05 Dominik Kubla wrote:
> On Fri, Jan 05, 2001 at 10:18:46AM +0100, J . A . Magallon wrote:
> > 
> > Silly question, but have you realized that you don't have to enable
> > SMP in kernel to do multithreading ?
> > 
> 
> That depends on your definition: If you really want to run multiple
> threads simultaneously (as opposed to concurrent i guess) i imagine
> you will either need more than one CPU or one of those new beasties
> which support multiple threads in parallel on their various execution
> units...
> 

Nope. You can run multiple threads "simultaneously" on an uniprocessor,
so simultaneous as the rest of the processes the cpu is running.
Of course the efficiency of multi-threading drops on an uni-processor
if your threads only do hard math work and no IO, but a thread can
be crunchin numbers at the same time one other is waiting for IO even
on a one cpu box. Think on an app that does read-process-write in loop.
Two parallel threads on an uniprocessor can overlap IO and process
and be more efficient than a non-threaded version.

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre6 #1 SMP Wed Jan 3 21:28:10 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
