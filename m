Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130082AbQKFRlq>; Mon, 6 Nov 2000 12:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130080AbQKFRlk>; Mon, 6 Nov 2000 12:41:40 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:42390 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129923AbQKFRlZ>; Mon, 6 Nov 2000 12:41:25 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jas88@cam.ac.uk (James A. Sutherland)
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Mon, 6 Nov 2000 17:38:44 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik), goemon@anime.net (Dan Hollis),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <E13spou-0006P0-00@the-village.bc.nu>
In-Reply-To: <E13spou-0006P0-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <00110617405001.24534@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, Alan Cox wrote:
> > So autoload the module with a "dont_screw_with_mixer" option. When the kernel
> > first boots, initialise the mixer to suitable settings (load the module with 
> > "do_screw_with_mixer" or whatever); thereafter, the driver shouldn't change
> > the mixer settings on load.
> 
> Which is part of what persistent module data lets you do. And without having
> to mess with dont_screw_with_mixer (which if you get it wrong btw can be 
> fatal and hang the hardware)

Eh? You just load the driver once, probably on boot, to configure sane values.
This time round, you use an argument (or an ioctl or whatever) to specify the
values you want. (cat /etc/sysconfig/sound/defaultvolume > /dev/sound/mixer or
whatever). After that, the module can be unloaded and loaded as needed, without
any need to touch the mixer settings except in response to *explicit* "set
volume" commands from userspace.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
