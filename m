Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272901AbTG3OFb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272902AbTG3OFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:05:30 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56963 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272901AbTG3OFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:05:24 -0400
Date: Wed, 30 Jul 2003 15:05:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The well-factored 386
Message-ID: <20030730140522.GA21665@mail.jlokier.co.uk>
References: <03072809023201.00228@linux24> <20030728093245.60e46186.davem@redhat.com> <20030728194127.GA10673@mail.jlokier.co.uk> <20030729111423.GA5320@hh.idb.hist.no> <20030729161951.GA15889@mail.jlokier.co.uk> <20030730071131.GA6282@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730071131.GA6282@hh.idb.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> So you can probably use paging in "forreal" mode too. I believe
> you only get the page table's memory mapping capabilities
> though, I don't think you get protection of "kernel" pages
> without protection enabled.  
> 
> You could still "hide" kernel memory by giving userspace another
> page table, but that means page table switching on each
> syscall which kills performance worse than interrupt handling
> in protecxted mode.

Yes, that's exactly what I had in mind.

You say that page table switching kills performance, but consider
Ingo's latest 64G patches do exactly that, and performance, though
degraded, is not too bad.

Whether it's worth doing that would depend on the balance of
interrupts vs. syscalls.  Some embedded applications are dominated by
interrupts, and there are apps which avoid syscalls altogether during
the main part of their running.

-- Jamie
