Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129693AbQKGMRr>; Tue, 7 Nov 2000 07:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129662AbQKGMRh>; Tue, 7 Nov 2000 07:17:37 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:37107 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129355AbQKGMR3>; Tue, 7 Nov 2000 07:17:29 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jas88@cam.ac.uk (James A. Sutherland)
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Tue, 7 Nov 2000 12:13:08 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jas88@cam.ac.uk (James A. Sutherland),
        goemon@anime.net (Dan Hollis), dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <E13t7Wv-0007Jm-00@the-village.bc.nu>
In-Reply-To: <E13t7Wv-0007Jm-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <00110712163100.01343@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2000, Alan Cox wrote:
> > When I plug it in and modprobe is triggered to load the driver, a script then
> > runs to feed the device appropriate configuration info. Since the driver only
> > resets the hardware when it is given the correct configuration, there's no
> > problem.
> 
> Thats another 100 lines of race prone network kernel code you dont need

Getting rid of 100 lines of code would certainly be worth doing...

Assuming I want the same configuration for the hardware as I did the last time
I used it is OK - provided that assumption is NOT in the kernel. As a default
behaviour in userspace, it's fine.

In the NIC example, I might well want the DHCP client to run whenever I
activate the card. Bringing the NIC up with the old configuration - which, with
dynamic IP addresses, could now include someone else's IP address! - is worse
than useless.

> > Hmm... define "identical". I take a laptop home, use a USB NIC to talk to my
> 
> Same Mac address or same serial number.

So if I take the NIC with me, Linux automagically misconfigures it for me. No
thanks.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
