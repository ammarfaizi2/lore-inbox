Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262835AbVEHKOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbVEHKOk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 06:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVEHKOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 06:14:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21443 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262835AbVEHKOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 06:14:31 -0400
Subject: Re: [RFC] (How to) Let idle CPUs sleep
From: Arjan van de Ven <arjan@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: vatsa@in.ibm.com, schwidefsky@de.ibm.com, jdike@addtoit.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <1115524211.17482.23.camel@localhost.localdomain>
References: <20050507182728.GA29592@in.ibm.com>
	 <1115524211.17482.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 08 May 2005 12:13:50 +0200
Message-Id: <1115547230.5998.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-08 at 13:50 +1000, Rusty Russell wrote:
> My preference would be the second: fix the scheduler so it doesn't rely
> on regular polling.  However, as long as the UP case runs with no timer
> interrupts when idle, many people will be happy (eg. most embedded).

alternatively; if a CPU is idle a long time we could do a software level
hotunplug on it (after setting it to the lowest possible frequency and
power state), and have some sort of thing that keeps track of "spare but
unplugged" cpus that can plug cpus back in on demand.

That also be nice for all the virtual environments where this could
interact with the hypervisor etc



