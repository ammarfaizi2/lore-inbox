Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266579AbUAWQDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 11:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266580AbUAWQDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 11:03:38 -0500
Received: from monsoon.he.net ([64.62.221.2]:16269 "HELO monsoon.he.net")
	by vger.kernel.org with SMTP id S266579AbUAWQD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 11:03:29 -0500
Date: Fri, 23 Jan 2004 08:03:23 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp vs  pgdir
In-Reply-To: <20040123075451.GB211@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0401230759180.11276-100000@monsoon.he.net>
References: <1074833921.975.197.camel@gaston> <20040123073426.GA211@elf.ucw.cz>
 <1074843781.878.1.camel@gaston> <20040123075451.GB211@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > swapper_pgdir is left intact. This is the case ? (I also suppose you
> > mean the entire linear mapping, not just the kernel, is mapped with
> > 4M pages)
>
> Yes.

Not necessarily. Just kernel text and data. I don't have the code in front
of me ATM, but there are simple checks you can do to determine the
type/size of page.

We don't have to care about userspace, though, once all processes are
frozen, so we don't have to deal with the 4k pages.

And the thing is, the only reason we require PSE and 4 MB pages is because
it provides a 2-level page table instead of a 3-level, which by
definition is easier to manage. :)


	Pat
