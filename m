Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269170AbUIHVzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269170AbUIHVzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 17:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUIHVzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 17:55:31 -0400
Received: from smtp.terra.es ([213.4.129.129]:4812 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id S269182AbUIHVzU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 17:55:20 -0400
Date: Wed, 8 Sep 2004 23:55:03 +0200
From: Diego Calleja <diegocg@teleline.es>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: riel@redhat.com, raybry@sgi.com, marcelo.tosatti@cyclades.com,
       kernel@kolivas.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, piggin@cyberone.com.au
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-Id: <20040908235503.3f01523a.diegocg@teleline.es>
In-Reply-To: <36100000.1094677832@flay>
References: <5860000.1094664673@flay>
	<Pine.LNX.4.44.0409081403500.23362-100000@chimarrao.boston.redhat.com>
	<20040908215008.10a56e2b.diegocg@teleline.es>
	<36100000.1094677832@flay>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 08 Sep 2004 14:10:32 -0700 "Martin J. Bligh" <mbligh@aracnet.com> escribió:

> I really don't see any point in pushing the self-tuning of the kernel out
> into userspace. What are you hoping to achieve?

Well your own words explain it, I think. "it's all dependant on the workload",
which means that only the user knows what he is going to do with the machine
and that the kernel doesn't knows that, so the algoritms built in the kernel
may be "not perfect" in their auto-tuning job. The point would be to
be able to take decisions the kernel can't take because userspace would
know better how the system should behave, say stupids things like "I want
to have this set of tunables which make compile jobs 0.01% faster at 12:00
because at that time a cron job autocompiles cvs snapshots of some project,
and at 6:00 those jobs have already finished so at that time I want a set
of tunables optimized for my everyday desktop work which make everthing 0.01%
slower but the system feels a 5% more reponsive". (well, for that a shell script
is enought) Kernel however could try to adapt itself to those changes, and do
it well...I don't really know. This came to my mind when I was thinking about
irqbalance case, which was somewhat similar, I also remember a discussion
about a "ktuned" in the mailing lists...I guess it's a matter of coding it
and get some numbers :-/
