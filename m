Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271006AbRIFOsO>; Thu, 6 Sep 2001 10:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271018AbRIFOsF>; Thu, 6 Sep 2001 10:48:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25871 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271006AbRIFOrp>; Thu, 6 Sep 2001 10:47:45 -0400
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
To: wietse@porcupine.org (Wietse Venema)
Date: Thu, 6 Sep 2001 15:51:38 +0100 (BST)
Cc: saw@saw.sw.com.sg (Andrey Savochkin), ak@suse.de (Andi Kleen),
        matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        linux-kernel@vger.kernel.org, wietse@porcupine.org (Wietse Venema)
In-Reply-To: <20010906140444.75DC1BC06C@spike.porcupine.org> from "Wietse Venema" at Sep 06, 2001 10:04:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15f0VG-0008Et-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Even if it checked the address it would not be unique because you can have multiple
> > > interfaces with the same addresses but different netmasks.
> 
> The same IP address with different netmasks on the same hardware
> interface? The mind boggles. How does one handle broadcasts?

Same as before. You have two for a single IP address/netmask
(255.255.255.255 and the local one). You have another per address/mask pair
you add.

The application supplies a target broadcast address so there isnt any real
problem
