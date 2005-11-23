Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVKWPjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVKWPjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVKWPjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:39:36 -0500
Received: from [85.8.13.51] ([85.8.13.51]:17312 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751032AbVKWPjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:39:36 -0500
Message-ID: <43848D37.4080007@drzeus.cx>
Date: Wed, 23 Nov 2005 16:39:35 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>, Jon Smirl <jonsmirl@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <438488A0.8050104@drzeus.cx> <20051123152950.GC15449@flint.arm.linux.org.uk>
In-Reply-To: <20051123152950.GC15449@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Nov 23, 2005 at 04:20:00PM +0100, Pierre Ossman wrote:
>   
>> But if no hardware is connected to those devices, then where does the 
>> driver route the setserial stuff?
>>     
>
> setserial /dev/ttyS2 port 0x200 irq 5 autoconfig
>
> and you might then end up with another serial port detected.  If
> /dev/ttyS2 and above do not exist, you can't do that.  That would
> in turn effectively prevent folk with some serial cards using them
> with Linux without editing and rebuilding their kernel.
>
>   

Ah. But why is this not done through module parameters? That would be 
more consistent with how you specify resources for other drivers.

> As for the rest of the "setserial stuff" it gets recorded against
> the port and remembered for when the hardware turns up, which it
> may do if it's your PCMCIA modem card.
>
>   

This could be a bit more questionable. Setting the initial state of 
hardware is better done (IMHO) by reacting to some hotplug event. E.g. 
fedora uses an 'install' line in modprobe.conf to restore mixer state 
for sound cards.

Rgds
Pierre

