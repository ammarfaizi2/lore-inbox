Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422935AbWKHU3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422935AbWKHU3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423146AbWKHU3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:29:41 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:35741 "EHLO
	smtp151.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1422935AbWKHU3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:29:41 -0500
Message-ID: <45523848.7010709@gentoo.org>
Date: Wed, 08 Nov 2006 15:04:24 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci quirks: Sort out the VIA mess once and for all	(hopefully)
References: <1163003156.23956.40.camel@localhost.localdomain>
In-Reply-To: <1163003156.23956.40.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Thanks for spending time working on this. Sorry that I never followed up 
after my previous attempt, I've been really busy having starting a 
proper job.

Alan Cox wrote:
> Boots for me but going by history this wants quite a bit of testing
> before anyone can be sure it actually fixes all the cases we have to
> deal with. If you have a VIA board (problem or otherwise) try this patch
> versus 2.6.19-rc4-mm (and probably rc5-mm once it appears) and let me
> know if it sorts out your box.

I just noticed that my earlier patch is included as of 2.6.19-rc, so 
actually your patch applies there and results can be compared. (if 
you're in strong objection to it's mainline inclusion, I could ask for 
it to be reverted, but it at does solve a lot of problems for users over 
the previous state with no reported problems...)

I now have access to a VIA system. It's not really an indicative test, 
as with my patch, no devices get quirked (due to some being outside the 
legacy IRQ range and others failing the new_irq != irq test). However I 
could at least confirm that your patch didn't cause any devices to be 
quirked again.

Thanks,
Daniel
