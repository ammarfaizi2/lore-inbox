Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVG2In0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVG2In0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVG2InS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:43:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262547AbVG2Imx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:42:53 -0400
Date: Fri, 29 Jul 2005 01:41:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: sclark46@earthlink.net
Cc: stephen.clark@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 sound problem
Message-Id: <20050729014150.6e97dfd2.akpm@osdl.org>
In-Reply-To: <42E7A8D8.1030809@earthlink.net>
References: <42E6C8DB.4090608@earthlink.net>
	<s5hr7dklko4.wl%tiwai@suse.de>
	<42E7A8D8.1030809@earthlink.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please do reply-to-all when dealing with kernel stuff)

Stephen Clark <stephen.clark@earthlink.net> wrote:
>
> Takashi Iwai wrote:
> 
> >At Tue, 26 Jul 2005 19:35:55 -0400,
> >Stephen Clark wrote:
> >  
> >
> >>Hello List,
> >>
> >>
> >>I recently upgraded my laptop, HP Pavilion N5430, from a 2.4.21 kernel
> >>to 2.6.12. As a result of
> >>doing this my sound no longer works correctly. It plays the same thing
> >>repeatedly some number
> >>of times - if it plays at all.
> >>
> >>Any ideas on how to debug this would be appreciated.
> >>
> >>Additional info I don't see any interrupts in /proc/interrupts for the
> >>Allegro which is on int 5.
> >>I just tried the same laptop with knoppix and a 2.4.27 kernel and sound
> >>works great and I do
> >>see interrupts for Allegro on int 5.
> >>    
> >>
> >
> >The irq problem is likely related with ACPI.
> >Try to boot once with pci=noacpi.
> >
> >
> >Takashi
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >  
> >
> Hi Takashi,
> 
> I have boot the 2.6.12 kernel with acpi=off pci=noacpi,usepirqmask or I
> get a panic or a hang.

It's just really awful that 2.4 simply worked and 2.6 requires a sprinkle
of obscure kernel parameters.  I shudder to think how long it took you to
work them out.

> I don't have to do this with 2.4.27, anybody know why?
> 

Perhaps you could send the `dmesg -s 1000000' output?
