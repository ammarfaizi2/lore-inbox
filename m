Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUE1UA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUE1UA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUE1T7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:59:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42398 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263826AbUE1T6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:58:54 -0400
Message-ID: <40B799EB.8060000@pobox.com>
Date: Fri, 28 May 2004 15:58:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nivedita Singhvi <niv@us.ibm.com>
CC: Arjan van de Ven <arjanv@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
References: <7F740D512C7C1046AB53446D372001730182BAE2@scsmsx402.amr.corp.intel.com> <40B7797F.2090204@pobox.com> <17750000.1085766378@flay> <20040528175724.GC9898@devserv.devel.redhat.com> <40B7984E.7040208@us.ibm.com>
In-Reply-To: <40B7984E.7040208@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita Singhvi wrote:
> I see networking interrupts requiring fine granularity
> balancing, to avoid the potential for dropped packets and
> long latencies.  That is, given a busy server that is
> seeing a lot of interrupts, fair distribution of the
> interrupts is required within a very small amount of time,
> and we cannot require a user space daemon that parses the /proc
> file system and applies a policy and then rebinds irqs
> to different CPUs to run with that frequency.


Network is one of the areas where you _don't_ want to be constantly 
pointing your NIC's irq to different CPUs.

Cache affinity, packet re-ordering problems, and other fun ensue.

	Jeff


