Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVAEQEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVAEQEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVAEQDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:03:22 -0500
Received: from natjimbo.rzone.de ([81.169.145.162]:53666 "EHLO
	natjimbo.rzone.de") by vger.kernel.org with ESMTP id S262502AbVAEP5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:57:49 -0500
Message-ID: <41DC0E70.4000005@schiggl.de>
Date: Wed, 05 Jan 2005 16:57:36 +0100
From: Lion Vollnhals <webmaster@schiggl.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp: properly suspend and resume *all* devices
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz> <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net> <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net> <loom.20050104T093741-631@post.gmane.org> <20050104214315.GB1520@elf.ucw.cz>
In-Reply-To: <20050104214315.GB1520@elf.ucw.cz>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Obviously, I don't get the APIC errors, but everything else is the same, random
>>devices fail and need to be reloaded (3c59x and uhci-hcd in particular), plus
>>the system appears to panic somewhere along the way to resume occasionally (as I
>>assume from the hung machine and blinking CAPS LOCK), which didn't happen
>>previously (2.6.9, 2.6.8.1, ...). I also see lots of 
>>
>>drivers/usb/input/hid-core.c: input irq status -84 received
>>
>>until I do a 'rmmod uhci_hcd; modprobe uhci_hcd'. This used to happen with 2.6.9
>>as well, but the system would recover after about 20 messages or so like this
>>after a resume.
>>
>>Any suggestions about where to look to track this down?
> 
> 
> Check if 3c59x has suspend/resume support. If not, add it.
> 
> Panic... we really need to know why it panicked. VESAFB does not
> support blanking, just switch to VESAFB and you should be able to see
> the messages. 
> 								Pavel

I have a problem with net-devices, ne2000 in particular, in 2.6.9 and 
2.6.10, too. After a resume the ne2000-device doesn't work anymore. I 
have to restart it using the initscripts.

How do I add suspend/resume support (to ISA devices, like my ne2000)?
Can you point me to some information/tutorial?

Lion Vollnhals
