Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263398AbVCEBT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbVCEBT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 20:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbVCEBR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 20:17:57 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:20431 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S263575AbVCEBGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:06:19 -0500
Subject: Re: swsusp: allow resume from initramfs
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, mjg59@scrf.ucam.org, hare@suse.de,
       "Barry K. Nathan" <barryn@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304225556.GA2647@elf.ucw.cz>
References: <20050304101631.GA1824@elf.ucw.cz>
	 <20050304030410.3bc5d4dc.akpm@osdl.org>
	 <20050304175038.GE9796@ip68-4-98-123.oc.oc.cox.net>
	 <1109971327.3772.280.camel@desktop.cunningham.myip.net.au>
	 <20050304214329.GD2385@elf.ucw.cz>
	 <1109973035.3772.291.camel@desktop.cunningham.myip.net.au>
	 <20050304220709.GE2385@elf.ucw.cz>
	 <1109975474.3772.305.camel@desktop.cunningham.myip.net.au>
	 <20050304225556.GA2647@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1109984867.3772.322.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 05 Mar 2005 12:07:47 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-03-05 at 09:55, Pavel Machek wrote:
> > All that to say "Bitmaps were a definite win!". Perhaps I can sell you
> > on the advantages of using them :>
> 
> Not sure, if one bit goes wrong you put everything in the wrong places
> :-). Linklist seems just okay to me, no > 4K allocations. I'm not sure
> why recalculation is that big problem.

So you make sure all the bits are right :> I can understand you being
happy with linked lists; it's just that they're really inefficient
spacewise. Since you're freeing far more memory at the moment, it's not
an issue.

Regarding recalculation being a problem, I want Suspend to always work.
If you have unpredictable variation, you have a potential source of
failure.

> > By the way, did you see the effect of the memory eating patch? I didn't
> > think about it until someone emailed me, but the improvement was 50x
> > speed in the best case!
> 
> Well, more interesting was that you actually freed much more memory
> with your patch. *You actually made memory freeing to work*. So yes, I
> like that one.

You might be misreading me. When you set the image size limit setting in
Suspend2, it's a soft limit. The image size wouldn't actually get down
to 2 meg; Suspend would just aim for that and eat memory until it saw it
wasn't getting anywhere.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


