Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270173AbUJTJbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270173AbUJTJbA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270121AbUJTJ1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:27:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35847 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270262AbUJTJBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:01:16 -0400
Date: Wed, 20 Oct 2004 10:01:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: New consolidate irqs vs . probe_irq_*()
Message-ID: <20041020100103.G1047@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Anton Blanchard <anton@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com> <20041020083358.GB23396@elte.hu> <1098261745.6263.9.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1098261745.6263.9.camel@gaston>; from benh@kernel.crashing.org on Wed, Oct 20, 2004 at 06:42:26PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 06:42:26PM +1000, Benjamin Herrenschmidt wrote:
> I really don't want to mess with that racy mecanism that makes sense for
> ISA only afaik, and it seems some drivers are trying to use it now that
> it's there (/me looks toward yenta_socket) and I'm afraid of the
> consequences since I cannot see how that thing can work properly in the
> first place ;)

yenta_socket has always used it.  Its rather fundamental to the way
that the PCMCIA core has worked for the last I don't know how many
years.

Nothing new.  Maybe something in PPC64 land broke recently?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
