Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276646AbRJBTlN>; Tue, 2 Oct 2001 15:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276649AbRJBTlC>; Tue, 2 Oct 2001 15:41:02 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:34788 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S276646AbRJBTk5>;
	Tue, 2 Oct 2001 15:40:57 -0400
Date: Tue, 2 Oct 2001 21:41:24 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110021941.VAA13062@harpo.it.uu.se>
To: lior@netvision.net.il
Subject: Re: Strange CD-writing problem
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001 19:41:53 +0200 (IST), Lior Okman wrote:

>I recently bought a new IDE cd-rw (a Plextor W1610A).
>While trying to burn with it, I had some trouble fixating the disks.
>The burn process would work fine, but when the fixating started, the
>ide-scsi emulation started resetting the IDE bus, or just timing out.
>This is true for every 2.4 kernel, from 2.4.0 to 2.4.10 including selected
>ac versions.
> 
>The cd writer is connected to the computer as a primary device of the
>third IDE bus (an onboard Promise chip) ...

I'd move that ATAPI cd-rw to the primary controller, and reserve
the Promise controller for UDMA(33) and above disks. Promise chips
seem to require explicit driver support for handling ATAPI devices,
and I'm not confident that Linux' driver has that. Quoting from the
box my Promise Ultra100 card came in:

"Supports ATAPI: Yes(*)
 (*) Non-Windows environments require manufacturer device drivers."

which I think says it all.

/Mikael
