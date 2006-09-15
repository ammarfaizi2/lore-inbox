Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWIOLTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWIOLTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 07:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWIOLTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 07:19:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53151 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751218AbWIOLTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 07:19:00 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <4509B03A.3070504@am.sony.com>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>
	 <20060914135548.GA24393@elte.hu>
	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>
	 <20060914171320.GB1105@elte.hu>
	 <Pine.LNX.4.64.0609141935080.6761@scrub.home>
	 <20060914181557.GA22469@elte.hu>  <4509B03A.3070504@am.sony.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 12:40:06 +0100
Message-Id: <1158320406.29932.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-14 am 12:40 -0700, ysgrifennodd Tim Bird:
> It's only zero maintenance overhead for you.  Someone has to
> maintain it. The party line for years has been that in-tree
> maintenance is easier than out-of-tree maintenance.

That misses the entire point. If you have dynamic tracepoints you don't
have any static tracepoints to maintain because you don't need them.
They may be a clock or three slower but you are then going to branch
into the trace tool code paths, take tlb misses, take cache misses, and
eventually get back, so the cost of it being dynamic is so close to zero
in the biger picture it doesn't matter.

Alan

