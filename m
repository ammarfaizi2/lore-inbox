Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbWBNGF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWBNGF4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWBNGF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:05:56 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:7676 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1030404AbWBNGFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:05:55 -0500
Message-ID: <43F1733E.8010300@cfl.rr.com>
Date: Tue, 14 Feb 2006 01:05:50 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
References: <200602131116.41964.david-b@pacbell.net> <43F0E724.6000807@cfl.rr.com> <200602131910.50304.david-b@pacbell.net>
In-Reply-To: <200602131910.50304.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> No, not "AFAIK" ... since when I told you explicitly that was untrue,
> you then ignored that statement.  And didn't look at the specs that
> I pointed you towards, which provide the details.  (USB 2.0 spec re
> hubs; and of course the Linux-USB hub driver ... www.usb.org)

I ignored nothing.  I fully accepted your explanation as true and 
pointed out that it changes nothing; data loss in this perfectly valid 
use case just because the kernel can not be absolutely certain the user 
did not do something stupid while suspended is unacceptable.

> 
> The events that a hub receives say pretty exactly what happened.
> You should know that already, since USB behaves that way even
> when the system is _not_ suspended ... 
> 

How it behaves while running and how it behaves while suspended are 
usually two very different things.

> The full mechanism for USB is more like wakeup signaling on USB triggering
> hub wakeup (possibly cascading through a few layers of external hub), at
> some point triggering root hub wakeup, which maps to a PME# signal.  That
> relies on no more than VBUS being powered at a fraction of a milliAmpere,
> and the equivalent of a pair of voltage comparators triggering wakeup when
> USB signaling changes from J to K states for something like 10 msec.
> 
> 
> 
> Did you read about the PME# signal in the PCI PM spec?  www.pci-sig.com
> Maybe you could try that. 
> 

No, I took your word for it without protest as it doesn't change my main 
argument: data loss in the face of normal usage is not acceptable. 
Claiming that it has to be this way because the alternative _might_ 
result in data loss in the worst (mis)use case is an untenable position.


> Also the ACPI spec ... the early chapters give a decent overview of the
> different components of that model.  (ISTR two chapters try that, with
> the second being more to-the-point despite some duplicated graphics.)
> 
> - Dave
> 
>  
> 

