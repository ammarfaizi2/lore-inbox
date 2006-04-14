Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWDNWMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWDNWMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 18:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWDNWMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 18:12:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030203AbWDNWML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 18:12:11 -0400
Date: Fri, 14 Apr 2006 15:06:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       tglx@linutronix.de, ak@suse.de, mj@atrey.karlin.mff.cuni.cz,
       bjornw@axis.com, schwidefsky@de.ibm.com, benedict.gaster@superh.com,
       lethal@linux-sh.org, chris@zankel.net, marc@tensilica.com,
       joe@tensilica.com, davidm@hpl.hp.com, rth@twiddle.net, spyro@f2s.com,
       starvik@axis.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       ralf@linux-mips.org, linux-mips@linux-mips.org,
       grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       linuxppc-dev@ozlabs.org, paulus@samba.org, linux390@de.ibm.com,
       davem@davemloft.net
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Message-Id: <20060414150625.3ba369d2.akpm@osdl.org>
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Example:
> 
>  DEFINE_PER_CPU(int, myint);
> 
>  would now create a variable called per_cpu_offset__myint in
> the .data.percpu_offset section.

Suppose two .c files each have

	DEFINE_STATIC_PER_CPU(myint)

Do we end up with two per_cpu_offset__myint's in the same section?
