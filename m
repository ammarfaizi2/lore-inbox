Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265629AbTIEQMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 12:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbTIEQMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 12:12:50 -0400
Received: from [65.172.181.6] ([65.172.181.6]:29069 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265629AbTIEQLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 12:11:32 -0400
Date: Fri, 5 Sep 2003 08:54:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test4 bk1 and
Message-Id: <20030905085419.6ea00d78.akpm@osdl.org>
In-Reply-To: <200309051559.18910.arekm@pld-linux.org>
References: <200309051559.18910.arekm@pld-linux.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz <arekm@pld-linux.org> (by way of Arkadiusz Miskiewicz <arekm@pld-linux.org>) wrote:
>
> On Monday 25 of August 2003 15:35, Arkadiusz Miskiewicz wrote:
> > Hi,
> >
> > Yesterday I've changed kernel from test3 to test4 with bk1 patch applied
> > and such error appeared (and it's showning all the time):
> >
> > bad: scheduling while atomic!
> > Call Trace:
> >  [<c0105000>] _stext+0x0/0x60
> >  [<c011ccd0>] schedule+0x3b0/0x3c0
> >  [<cf8c1257>] acpi_processor_idle+0xe9/0x1e5 [processor]
> >  [<c0105000>] _stext+0x0/0x60
> >  [<c01090eb>] cpu_idle+0x3b/0x40
> >  [<c0328734>] start_kernel+0x184/0x1b0
> >  [<c0328480>] unknown_bootoption+0x0/0x100
> 
> Nothing about this has changed in test4bk3 nor test4bk6. Still yells about
> ,,scheduling while atomic''.
> 
> No one has idea what's happening here? Some change between test3 and test4
>  did this.

Grab the latest snapshot from
http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/ (the very first
link) and see if it's still happening.

If so then please add the `initcall_debug' option to the kernel boot command line and see if any messages such as 

	error in initcall at 0xNNNNNNNN: returned with preemption imbalance

come out.  If they do, look up 0xNNNNNNNN in System.map.

If none of this sheds any light, please send your full .config.

Thanks.
