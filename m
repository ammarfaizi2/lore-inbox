Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRDSQJK>; Thu, 19 Apr 2001 12:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRDSQJB>; Thu, 19 Apr 2001 12:09:01 -0400
Received: from ns.caldera.de ([212.34.180.1]:58630 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131191AbRDSQIv>;
	Thu, 19 Apr 2001 12:08:51 -0400
Date: Thu, 19 Apr 2001 18:08:42 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/sound/nm256_audio.c
Message-ID: <20010419180842.A16881@caldera.de>
In-Reply-To: <20010419173502.A13934@caldera.de> <3ADF0A91.F803266F@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3ADF0A91.F803266F@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Apr 19, 2001 at 11:56:01AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 11:56:01AM -0400, Jeff Garzik wrote:
> Marcus Meissner wrote:
> > 
> > Hi,
> > 
> > This updates the nm256_audio driver to the 2.4 PCI API.
> > 
> > Patch is against 2.4.3-ac9, verified on Sony VAIO Laptop.
> 
> "verified" is the really important part with this driver, since its
> really finicky.  I have a patch I would love to bounce to you in
> private, that I have been searching for a tester for -months- because I
> had no test hardware of my own.

Feel free to send (I have a NM256AV card in that VAIO).

> Your patch looks ok to me and I would say apply it.  But I also think it
> is incomplete.
> 
> * there is no need for a linked list of cards, since
> pci_{get,set}_drvdata is used.  This eliminates the list walk in
> nm256_remove

The problem is with device opens, which just pass numbers, most other
sound drivers still use linked lists.

Hmm, but via8xxxx_audio.c doesn't, I will take this as example.

> * the new PCI API has suspend/resume hooks, and those should be used in
> preference to register_pm_...

Ok, will have another look at the other issues.

And I hope my colleague brings his VAIO to work tomorrow ;)

Ciao, Marcus
