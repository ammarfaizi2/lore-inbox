Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129264AbQKFPZI>; Mon, 6 Nov 2000 10:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129263AbQKFPY6>; Mon, 6 Nov 2000 10:24:58 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:18677 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129053AbQKFPYs>; Mon, 6 Nov 2000 10:24:48 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Mon, 6 Nov 2000 15:23:14 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Dan Hollis <goemon@anime.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <00110613370501.01541@dax.joh.cam.ac.uk> <29788.973511264@redhat.com> <10109.973518003@redhat.com>
In-Reply-To: <10109.973518003@redhat.com>
MIME-Version: 1.0
Message-Id: <00110615242102.01541@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, David Woodhouse wrote:
> jas88@cam.ac.uk said:
> >  So autoload the module with a "dont_screw_with_mixer" option. When
> > the kernel first boots, initialise the mixer to suitable settings
> > (load the module with  "do_screw_with_mixer" or whatever); thereafter,
> > the driver shouldn't change the mixer settings on load. 
> 
> Not reliable. You can't read back the current mixer state from all 
> hardware, even if you _are_ willing to assume that it has remained in a 
> sensible state while the driver has been unloaded. 

Irrelevant. The current mixer settings don't matter: what matters is that the
driver does not change them.

> The driver needs to reset the card to the desired levels. 

What desired levels? The only desired levels are the current ones, which
the driver does not and (sometimes) cannot know. Leave well alone.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
