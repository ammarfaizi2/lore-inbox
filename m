Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbTIPNyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTIPNyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:54:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23687 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261811AbTIPNyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:54:07 -0400
Date: Tue, 16 Sep 2003 09:55:36 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
In-Reply-To: <20030916153658.3081af6c.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.53.0309160948460.27601@chaos>
References: <20030916102113.0f00d7e9.skraw@ithnet.com>
 <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Stephan von Krawczynski wrote:

> On Tue, 16 Sep 2003 10:11:49 -0300 (BRT)
> Marcelo Tosatti <marcelo.tosatti@cyclades.com.br> wrote:
>
> > Oh... Jens just pointed bounce buffering is needed for the upper 2Gs.
> >
> > Maybe you have a SCSI card+disks to test ? 8)
>
> Well, I do understand the bounce buffer problem, but honestly the current way
> of handling the situation seems questionable at least. If you ever tried such a
> system you notice it is a lot worse than just dumping the additional ram above
> 4GB. You can really watch your network connections go bogus which is just
> unacceptable. Is there any thinkable way to ommit the bounce buffers and still
> do something useful with the beyond-4GB ram parts?
> We should not leave the current bad situation as is...
>
> Regards,
> Stephan

Can you explain what you mean by "network connections go bogus". Whether
or not you have more that 4GB or RAM and therefore have to page it
into lower virtual addresses has nothing at all to do with networking
unless you have a network device driver that did not allocate memory
properly. If so, that should be checked out.

Since there is only 32 bits of address space in the Intel machines,
the virtual memory seen by a process can't exceed that, including
the kernel itself. However, the physical memory can come from anywhere
and that's what the extended-memory specification attempts to provide.
If something is hurting the network, it shouldn't be so.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


