Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270696AbTGNQ7L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270683AbTGNQ6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:58:17 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:50366 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S270697AbTGNQ4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:56:45 -0400
Date: Tue, 15 Jul 2003 03:11:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: sizeof (siginfo_t) problem
Message-Id: <20030715031123.5c8e0c96.sfr@canb.auug.org.au>
In-Reply-To: <20030714130024.M15481@devserv.devel.redhat.com>
References: <20030714084000.J15481@devserv.devel.redhat.com>
	<20030715025252.17ec8d6f.sfr@canb.auug.org.au>
	<20030714130024.M15481@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 13:00:24 -0400 Jakub Jelinek <jakub@redhat.com> wrote:
>
> This is not correct for the merged header.
> It needs to be:
> #ifdef __s390x__
> #define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
> #endif

OK, I can see that (although is __s390x__ defined when building a
32 (31?) bit kernel on a 64bit s390?).

> Furthermore, there needs to be a pad inserted fo arch/s390x/kernel/signal.c
                                                        ^^^^^
s390?  (there is no arch/s390x in 2.6.0-test1)

> (rt_sigframe right after info member) to keep binary compatibility.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
