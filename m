Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136082AbRD0PSD>; Fri, 27 Apr 2001 11:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136085AbRD0PRy>; Fri, 27 Apr 2001 11:17:54 -0400
Received: from AMontpellier-201-1-2-100.abo.wanadoo.fr ([193.253.215.100]:65277
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S136082AbRD0PRk>; Fri, 27 Apr 2001 11:17:40 -0400
Subject: Re: Can the kernel access /?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Matt <madmatt@bits.bris.ac.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104271521540.21006-100000@bits.bris.ac.uk>
In-Reply-To: <Pine.LNX.4.21.0104271521540.21006-100000@bits.bris.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10 (Preview Release)
Date: 27 Apr 2001 17:15:03 +0200
Message-Id: <988384505.4081.1.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27 Apr 2001 15:28:04 +0100, Matt a écrit :
> I'm writing a device driver for a DSP card that requires some software
> loaded onto the card for it to function, currently I'm copying the
> software to the /dev node and the driver is doing the magic in it's
> write() handler.
> 
> Can the driver pull the file from the filesystem if I were to pass the
> path of the file as an argument on loading the module?

It's generally considered a better idea to load your firmware with a
userspace app doing an ioctl or a mmap on your driver - no nasty races
to take care of, only proven codepaths used.

Xav

