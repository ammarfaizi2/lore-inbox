Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264119AbUE2Iml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbUE2Iml (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 04:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbUE2Iml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 04:42:41 -0400
Received: from mo.optusnet.com.au ([203.10.68.101]:742 "EHLO
	mo.optusnet.com.au") by vger.kernel.org with ESMTP id S264119AbUE2Imb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 04:42:31 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
References: <7F740D512C7C1046AB53446D372001730182BB40@scsmsx402.amr.corp.intel.com>
	<2750000.1085769212@flay>
	<20040528184411.GE9898@devserv.devel.redhat.com>
From: michael@optusnet.com.au
Date: 29 May 2004 18:41:46 +1000
In-Reply-To: <20040528184411.GE9898@devserv.devel.redhat.com>
Message-ID: <m1zn7r7hh1.fsf@mo.optusnet.com.au>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:
> On Fri, May 28, 2004 at 11:33:32AM -0700, Martin J. Bligh wrote:
[...]
> > Also, we may well have more than 1 CPU's worth of traffic to
> > process in a large network server.
> 
> One NIC? I've yet to see that ;)

Oh, and another corner case. 

Say you have a cpu-bound process on an SMP box.
Say you're also using a large chunk of a CPU processing
interrupts from a single IRQ.

What stops the cpu-bound process being scheduled onto
the same CPU as the interrupt handlers?

Now you've got one idle CPU, and one seriously overloaded
CPU.

Michael.
