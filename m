Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTKWVZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 16:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTKWVZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 16:25:16 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33010 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263472AbTKWVZM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 16:25:12 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: modular IDE in 2.4.23
Date: Sun, 23 Nov 2003 22:26:08 +0100
User-Agent: KMail/1.5.4
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311231502530.1292-100000@logos.cnet> <200311232123.06635.bzolnier@elka.pw.edu.pl> <20031123205635.GA20672@devserv.devel.redhat.com>
In-Reply-To: <20031123205635.GA20672@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311232226.08882.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 of November 2003 21:56, Alan Cox wrote:
> > Uh. Oh. 2.4.23 IDE changes are obscure...  Modular IDE breakage is caused
> > by Alan's hotplug changes and is not easy to fix properly.
>
> The fixing is simply a matter of linkage ordering and function execution.
>
> Simple thought experiment
>
> 	Merge ide-probe into ide-core
> 	Export a symbol for the second initializer function if used modular
> 	Create a mini module that just invokes the exported function on init

Update ide_probe_module() for new name of probe module.

> You now have the same execution sequence but with the link problem removed.

Hmm, actually you are right.  Sorry :-).

> > I would like to have these changes removed:
> > (a) they break modular IDE
> > (b) such changes should be first added to 2.6 and then backported to 2.4
> >    (otherwise you are magically creating regression in 2.6)
>
> Its not my fault the 2.6 code is lagging badly, and I wrote the code

2.6 is not "lagging badly", this is a false statement.

> because people using laptops, and people using ATA and SATA for business
> expect basic functionality like hotplug to work. For most of them 2.6
> doesn't really matter and won't for another 6 months, but 2.4 matters right
> now.

I assume you will fix it 6 months from now in 2.6, right? :-)

--bart

