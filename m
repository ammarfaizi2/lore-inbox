Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270711AbTGNRSw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270688AbTGNRPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:15:54 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:28351 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S270736AbTGNRLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:11:16 -0400
Date: Tue, 15 Jul 2003 03:25:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: sizeof (siginfo_t) problem
Message-Id: <20030715032552.672d21ea.sfr@canb.auug.org.au>
In-Reply-To: <20030714131400.N15481@devserv.devel.redhat.com>
References: <20030714084000.J15481@devserv.devel.redhat.com>
	<20030715025252.17ec8d6f.sfr@canb.auug.org.au>
	<20030714130024.M15481@devserv.devel.redhat.com>
	<20030715031123.5c8e0c96.sfr@canb.auug.org.au>
	<20030714131400.N15481@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 13:14:01 -0400 Jakub Jelinek <jakub@redhat.com> wrote:
>
> __s390x__ is defined when doing 64-bit compile targetted to s390.
> Ie. gcc -m64 defines it, gcc -m31 does not.

That makes sense (since I now see that CONFIG_ARCH_S390X => -m64).

> Then that pad needs to be #ifdef __s390x__ as well.

But why pad at all since we have now increased the size of the siginfo
structure in the 64bit case (maybe I am being thick as it is 3:25am here
:-)).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
