Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbTJFICt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 04:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTJFICs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 04:02:48 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:41746
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262980AbTJFICo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 04:02:44 -0400
Date: Mon, 6 Oct 2003 01:00:26 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Hugo Mills <hugo-lkml@carfax.org.uk>
cc: Devin Henderson <linux@devhen.com>, Pauli Borodulin <boro@fixel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: SiI3112 DMA? (2.6.0-test6)
In-Reply-To: <20031006075359.GQ9052@carfax.org.uk>
Message-ID: <Pine.LNX.4.10.10310060057290.21746-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is an issue with first generation FIS transfer on the wire.

Take the size of the request in sectors and divide by 15 or 7.5K.
Standard FIS packet size is 8K.

Without going into much detail because of NDA's, there needs to be a
special DMA engine build table.

I did it once then lost the code because of lack of sleep.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 6 Oct 2003, Hugo Mills wrote:

> On Sun, Oct 05, 2003 at 10:29:40PM -0700, Andre Hedrick wrote:
> > 
> > I have a scheduled fix prepared for release and review by SiI monday
> > morning 9AM Pacific time.  Once it is cleared by SiI, it will be released
> > out to the masses.
> 
>    That's good news. Thank you.
> 
> > Will attempt to address the mod15b phy issues
> 
>    mod15b phy? Me simple idiot. Me no understand. :)
> 
>    Is that the PATA/SATA converter that the last poster mentioned? Or
> something else?
> 
>    Hugo.
> 
> -- 
> === Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
>   PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
>        --- The early bird gets the worm,  but the second mouse ---       
>                             gets the cheese.                             
> 

