Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130674AbQKGAog>; Mon, 6 Nov 2000 19:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130662AbQKGAo1>; Mon, 6 Nov 2000 19:44:27 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:32688 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130212AbQKGAoH>; Mon, 6 Nov 2000 19:44:07 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jas88@cam.ac.uk (James A. Sutherland)
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Tue, 7 Nov 2000 00:38:54 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: goemon@anime.net (Dan Hollis), dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <E13swbR-0006pk-00@the-village.bc.nu>
In-Reply-To: <E13swbR-0006pk-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <00110700431704.00940@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2000, Alan Cox wrote:
> > changing settings. If I plug in a hotplug soundcard and load the driver, I do
> > NOT want the driver to decide to set some settings. If I want settings set,
> > I'll do it myself (or have a script to do it).
> 
> How about if your stuff is already nicely set up and you remove then replug
> a device,

When I plug it in and modprobe is triggered to load the driver, a script then
runs to feed the device appropriate configuration info. Since the driver only
resets the hardware when it is given the correct configuration, there's no
problem.

> or remove and swap for an identical replacement part. Most people then
> want the configuration preserved.

Hmm... define "identical". I take a laptop home, use a USB NIC to talk to my
LAN at home (using NAT) with a 192.168.* address. Then I take it elsewhere and
use the same model of NIC on the college LAN. All of a sudden, I get myself
banging on the door complaining about misconfigured NICs :-)
   
> And guess what the simple modutils solution using an ELF section solves that
> too Want to go to default configuration ?
> 
> 	rm /var/run/modules/eth0.data
> 
> or wrap it in a GUI.

That sounds a lot like what I've been advocating all along, if that file is
created/updated by a script when eth0's driver is unloaded, then fed back to
eth0 on load.

> [BTW windows gets the USB speaker state management right, seems they store all
> the module persistent data in the registry!]

Yes, that's what we need. A registry, so configuration problems can be
persistent across boots, and even reinstallations... ;-)


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
