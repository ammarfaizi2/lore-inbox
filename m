Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131479AbRCWW3h>; Fri, 23 Mar 2001 17:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131488AbRCWW32>; Fri, 23 Mar 2001 17:29:28 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8465 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131480AbRCWW2y>; Fri, 23 Mar 2001 17:28:54 -0500
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
To: viro@math.psu.edu (Alexander Viro)
Date: Fri, 23 Mar 2001 22:29:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        sct@redhat.com (Stephen C. Tweedie), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bcrl@redhat.com (Ben LaHaise),
        cr@sap.com (Christoph Rohland)
In-Reply-To: <Pine.GSO.4.21.0103231721120.10092-100000@weyl.math.psu.edu> from "Alexander Viro" at Mar 23, 2001 05:23:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ga44-0005Zq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 	+       page = find_lock_page(mapping, idx);
> > > 
> > > Ehh.. Sleeping with the spin-lock held? Sounds like a truly bad idea.
> > 
> > Umm find_lock_page doesnt sleep does it ?
> 
> It certainly does. find_lock_page() -> __find_lock_page() -> lock_page() ->
> -> __lock_page() -> schedule().

Ok I missed the lock page one. Yep.

Alan

