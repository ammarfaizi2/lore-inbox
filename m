Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbWIOO7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWIOO7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWIOO7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:59:30 -0400
Received: from [81.2.110.250] ([81.2.110.250]:42887 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751627AbWIOO73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:59:29 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <450ABCBB.4090001@mbligh.org>
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>
	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>
	 <20060915132052.GA7843@localhost.usen.ad.jp>
	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>
	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>
	 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>
	 <20060915142836.GA9288@localhost.usen.ad.jp>  <450ABCBB.4090001@mbligh.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 16:22:03 +0100
Message-Id: <1158333723.29932.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-15 am 07:46 -0700, ysgrifennodd Martin J. Bligh:
> Moreover, subsystem experts know what needs to be traced in order to
> give useful information, and the users may not. It's a damned sight
> easier for them to say "oh, please turn on tracing for VM events
> and send me the output" than custom-construct a set of probes for
> that user, and send them off. There's a barrier to entry that just
> won't happen there.

That has nothing to do with the static or dynamic probe question.
Scriptable dynamic probes do everything your static probes do and more.

> Hell, look at all the debug printks in the kernel for example, and
> the various small add-hoc tracing facilities. If all we do is unite
> those, it'll still be a step forwards.

Look how many there are, look how they spread, tracepoints will do the
same.

> Dynamic probes do NOT reduce maintenance, they increase it.

Thats a logical fallacy to begin with. A dynamic probe can probe
anything a static probe can. So a static probe can be implemented with a
dynamic probe.

In other words if you like static probe lists and your subsystem happens
to be one where it is useful then you can script it with the same effect
and send people the script.

With kprobes you've got a passably good chance (ie if Distros can be
persuaded to package the debug data) that you can say "run this
systemtap script". With static tracepoints its "recompile your vendor
kernel in your vendor manner with your vendor initrd and add it to the
boot loader"

Alan

