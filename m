Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbQKFRJy>; Mon, 6 Nov 2000 12:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129635AbQKFRJj>; Mon, 6 Nov 2000 12:09:39 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:31218 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129115AbQKFRJP>;
	Mon, 6 Nov 2000 12:09:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <00110616471600.01646@dax.joh.cam.ac.uk> 
In-Reply-To: <00110616471600.01646@dax.joh.cam.ac.uk>  <00110615242102.01541@dax.joh.cam.ac.uk> <10109.973518003@redhat.com> <23007.973524894@redhat.com> 
To: "James A. Sutherland" <jas88@cam.ac.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Dan Hollis <goemon@anime.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 17:08:52 +0000
Message-ID: <6786.973530532@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jas88@cam.ac.uk said:
>  Yippee. As we all know, implementing GUI volume controls and putting
> the slider in the right place is a kernel function, and nothing to do
> with userspace... 

Don't troll, James. The kernel needs to provide the functionality required 
by userspace. The functionality required in this case is the facility to 
read the current mixer levels.


jas88@cam.ac.uk said:
>  The right thing in this context is not to screw with hardware
> settings unless and until it is given settings to set. Do not set
> values arbitrarily: set only the values you are explicitly given.
> Anything else is simply a bug in your driver. 

It is unwise to assume that the hardware is in a sane state when the driver 
has been unloaded and reloaded. I agree that you should set the values that 
were explicitly given. That's why we should remember them.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
