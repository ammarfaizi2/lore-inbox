Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVGRLlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVGRLlN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVGRLlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:41:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49372 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261335AbVGRLlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:41:11 -0400
Date: Mon, 18 Jul 2005 13:41:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1
Message-ID: <20050718114113.GA1869@elf.ucw.cz>
References: <20050715013653.36006990.akpm@osdl.org> <20050717013248.GA10673@nineveh.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050717013248.GA10673@nineveh.rivenstone.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     I'm getting this (on ppc32, though I don't think it matters):
> 
>   CC      drivers/video/chipsfb.o
> drivers/video/chipsfb.c: In function `chipsfb_pci_suspend':
> drivers/video/chipsfb.c:465: error: invalid operands to binary ==
> drivers/video/chipsfb.c:467: error: invalid operands to binary !=
> make[3]: *** [drivers/video/chipsfb.o] Error 1
> make[2]: *** [drivers/video] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory
> `/usr/src/linux-ctesiphon/linux-2.6.13-rc3-mm1'
> make: *** [stamp-build] Error 2
> 
>     The above-quoted patches seem to be the culprit, but my feeble
> attempts at making a patch didn't work out.

Should be easy. Just add .event at right places...

>     But I can't help but notice that every linux-suspend HOWTO tells
> you to patch in swsusp2 as a first step -- the consensus seems to be
> that it you want clean and conservative code, use swsusp1; if you want
> suspending to *work*, use swsusp2.  How many people are actually able
> to make use of swsusp1?  Is anyone testing it besides Mr. Machek?

SuSE ships it in production, so I believe we have at least as many
users as suspend2...
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
