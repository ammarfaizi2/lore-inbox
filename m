Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129096AbQKFPf7>; Mon, 6 Nov 2000 10:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbQKFPfs>; Mon, 6 Nov 2000 10:35:48 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:766 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129125AbQKFPfh>;
	Mon, 6 Nov 2000 10:35:37 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <00110615242102.01541@dax.joh.cam.ac.uk> 
In-Reply-To: <00110615242102.01541@dax.joh.cam.ac.uk>  <00110613370501.01541@dax.joh.cam.ac.uk> <29788.973511264@redhat.com> <10109.973518003@redhat.com> 
To: "James A. Sutherland" <jas88@cam.ac.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Dan Hollis <goemon@anime.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 15:34:54 +0000
Message-ID: <23007.973524894@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jas88@cam.ac.uk said:
>  Irrelevant. The current mixer settings don't matter: what matters is
> that the driver does not change them.

It does matter. The sound driver needs to be able to _read_ the current 
levels. Almost all mixer programs will start by doing this, to set the 
slider to the correct place.

> > The driver needs to reset the card to the desired levels. 

> What desired levels? The only desired levels are the current ones,
> which the driver does not and (sometimes) cannot know. Leave well
> alone.

It does not know them. Correct. But with persistent module storage, it 
_could_ know them. It cannot know them the _first_ time the module is 
loaded after booting. That's fine. On subsequent loads, it can and 
should DTRT.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
