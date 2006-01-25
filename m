Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWAYLst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWAYLst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWAYLst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:48:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21223 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751126AbWAYLss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:48:48 -0500
Subject: Re: [PATCH 06/16] Mark Typhoon cards as Lifeview OEM's
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Peter Missel <peter.missel@onlinehome.de>
Cc: "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>, video4linux-list@redhat.com,
       Ricardo Cerqueira <v4l@cerqueira.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200601242159.24747.peter.missel@onlinehome.de>
References: <20060123202404.PS66974000000@infradead.org>
	 <200601232155.44036.peter.missel@onlinehome.de>
	 <1138135687.16005.6.camel@localhost.localdomain>
	 <200601242159.24747.peter.missel@onlinehome.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 25 Jan 2006 09:15:32 -0200
Message-Id: <1138187732.5727.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

	This patch stayed for some time at CVS, the way it was commited to
-git. The changes did by nshm are trivial and generally we fold this
kind of change with the original patch, since:
	1) it is trivial;
	2) doesn't change technically;
	3) helps to keep Linux logs cleaner;
	4) it is susbystem maintainers task to make sure that patches are
correct and follows v4l and Linux CodingStyle.
	I think  the subject could be better. In fact, this patch subject
should be to add other Lifeview OEM PCI IDs. To use current naming
convention is a consequence of the patch.

Em Ter, 2006-01-24 às 21:59 +0100, Peter Missel escreveu:
> Hi Nickolay!
> 
> > 1. User should be able to find if his card is supported (no matter OEM
> > it or not) by searching his card name in CARDLIST
> 
> From my example, you should have a taster of where that would take us with the 
> popular OEM cards like LifeView's.
> You wouldn't believe just how many "brand" cards are actually made by them. 
> How many "brands" of LR50 cards does the BT878 driver record?
	We need to have just one convention. All patches should bound the
convention whatever it is. Of course, we can discuss the better
convention for board names at v4l mailing list, but, once defined, we
won't accept (or we should fix) newer patches that will not follow it.
> 
> > 2. We haven't invented better way to mark OEM cards yet.
> 
> I have made a suggestion on how to solve the naming problem - put the names 
> where they logically belong, into the PCI ID structure, not the card data 
> structure. That way, we get a 1:1 relation between each card incarnation 
> (original or OEM) and its name.
	This doesn't solve. There are several boards that don't have its own
PCI ID (They shares the original OEM vendor ID or chipset vendor ID).
Also, CARDLIST.foo are generated based on .name field at cards struct.
> 
> > But I understand your point, we can just remove that patch for now if
> > you are really against this change.
> 
> We need the patch I made because it solves an actual technical problem, and 
> I'd prefer to see it included the way I made it. Thank you.
	We have two options:

	1) Revert the patch from -git and start a discussion at V4L mailing
list about name convention. After archieving an agreement with this, you
can resubmit the patch, with the decided name;

	2) Keep this patch as is and start that discussion. After we archieve
an agreement, you can submit a patch just renaming it.

	As you said this patch solves a problem, I would prefer (2).
> 
> regards,
> Peter
Cheers, 
Mauro.

