Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130222AbQKGIop>; Tue, 7 Nov 2000 03:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130206AbQKGIof>; Tue, 7 Nov 2000 03:44:35 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:48328 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129919AbQKGIoV>; Tue, 7 Nov 2000 03:44:21 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Gerhard Mack <gmack@innerfire.net>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Tue, 7 Nov 2000 08:41:47 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011061717560.31473-100000@innerfire.net>
In-Reply-To: <Pine.LNX.4.10.10011061717560.31473-100000@innerfire.net>
MIME-Version: 1.0
Message-Id: <00110708441200.01218@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2000, Gerhard Mack wrote:
> > Then none of this is relevant to you, since you can't unload any modules! And
> > now you're the one doing the trolling... WTF do you think module code is
> > supposed to do when you don't use modules?!
> > 
> 
> Simple ... I'd rather the hardware was set to 0 on startup but I know what
> problems that presents to modules..
> 
> And no it wasn't the driver doing it afik. Sound card starts on max volume
> as soon as it's initialised.

Which is why I want the driver to initialise the card to "known-good" settings.
Defaulting to 0 is not good enough.

With my approach, the driver is loaded as part of the kernel, but does NOT
initialise the card, it just confirms it is there. Then, during boot, a script
will initialise the sound card with the correct settings explicitly. That way,
the delay between card init and the card getting the correct settings is
minimal, even on broken hardware like this.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
