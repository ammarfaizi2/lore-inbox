Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262502AbSJAR3r>; Tue, 1 Oct 2002 13:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262509AbSJAR2y>; Tue, 1 Oct 2002 13:28:54 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:39850 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262502AbSJAR1f>; Tue, 1 Oct 2002 13:27:35 -0400
Date: Tue, 1 Oct 2002 12:30:38 -0500 (CDT)
From: Kent Yoder <key@austin.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] pcnet32 cable status check
In-Reply-To: <3D99D923.5080200@pobox.com>
Message-ID: <Pine.LNX.4.44.0210011222520.14661-100000@ennui.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus Spake Jeff Garzik:
>
>Looks good ;-)

 Thanks,

>
>One small thing -- since you appear to test all cases for (lp->mii) 
>before calling mod_timer, I don't think you need to test lp->mii inside 
>the timer...

  Well, the reason I left that in there was so that another person could add 
functionality to the watchdog if they wanted on a non-mii enabled card 
without having to know that the check would need to be added. If that's not 
that big a deal, I can remove it...

>As Felipe mentioned, using the link interrupt instead of a timer is 
>preferred -- but my own preference would be to apply your patch with the 
>small remove-lp->mii-check fixup, and then investigate the support of 
>link interrupts.  The reasoning is that, pcnet32 covers a ton of chips, 
>and not all may support a link interrupt.
>
>	Jeff
>
>
>

