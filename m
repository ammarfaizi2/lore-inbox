Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbQKFNlX>; Mon, 6 Nov 2000 08:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130022AbQKFNlN>; Mon, 6 Nov 2000 08:41:13 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:23285 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129704AbQKFNlD>;
	Mon, 6 Nov 2000 08:41:03 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <00110613370501.01541@dax.joh.cam.ac.uk> 
In-Reply-To: <00110613370501.01541@dax.joh.cam.ac.uk>  <3A0698A8.8D00E9C1@mandrakesoft.com> <28752.973510632@redhat.com> <29788.973511264@redhat.com> 
To: "James A. Sutherland" <jas88@cam.ac.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Dan Hollis <goemon@anime.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 13:40:03 +0000
Message-ID: <10109.973518003@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jas88@cam.ac.uk said:
>  So autoload the module with a "dont_screw_with_mixer" option. When
> the kernel first boots, initialise the mixer to suitable settings
> (load the module with  "do_screw_with_mixer" or whatever); thereafter,
> the driver shouldn't change the mixer settings on load. 

Not reliable. You can't read back the current mixer state from all 
hardware, even if you _are_ willing to assume that it has remained in a 
sensible state while the driver has been unloaded. 

The driver needs to reset the card to the desired levels. 

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
