Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVKZVEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVKZVEl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 16:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVKZVEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 16:04:41 -0500
Received: from web36914.mail.mud.yahoo.com ([209.191.85.82]:53944 "HELO
	web36914.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750748AbVKZVEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 16:04:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NSFHafyz97g43Q5IQWi1608vZn6fJSvijW/Al7pr8dJ73Jr47jmOgh79/Slv8rYkfZJSO8DUMmK5UUrbcNbk596G/Ua9A1eicf9yMiVxFdL2wKxZqo7E/q0Uv1b7Du1ed5Y4G0FDi8lXkfMMSqdxXMV7vVcQ9CO8osniTTz/sls=  ;
Message-ID: <20051126210437.76662.qmail@web36914.mail.mud.yahoo.com>
Date: Sat, 26 Nov 2005 21:04:37 +0000 (GMT)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: pxa27x_udc -- support for usb gadget for pxa27x?
To: Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>
Cc: David Vrabel <dvrabel@cantab.net>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, dkrivoschokov@dev.rtsoft.ru
In-Reply-To: <20051126192436.GC17663@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > Pavel Machek wrote:
> > > > 
> > > > ...for the spitz. Do you think I can just copy this one? ...eh, no,
> > > > will not fly, there's no SPITZ_GPIO_USB_PULLUP.
> > > 
> > > There are internal pull-ups (and pull-downs) perhaps you can use those?
> > > 
> > > Hmmm. Though the C5 stepping might be different -- best to check the
> > > "specification update".
> > 
> > I can confirm that you'll need to use the internal pxa27x pullups
> > for
> 
> How can I use pxa27x pullups?
> 
> > this. You'll probably also need to make sure GPIO 35 is low to ensure
> > the usb Vcc line isn't powered (as it would be in usb host mode.
> 
> Are you sure? spitz_ohci_init() seems to play with GPIO 37.
> 
> (Perhaps spitz_ohci_init should disable the other GPIO?)
> 
> > Ultimately, it would be nice to have the Zaurus detect whether a usb
> > host or client was present (using gpio 41 maybe?) and then activate the
> > host (ohci) or client (pxa27x_udc) driver as appropriate.
> 
> Unfortunately, that would make ohci unfunctional for me. I have normal
> usb device cable, connected to "USB gender changer" -- basically two
> female connectors -- so that I can plug USB network card into that.
> 

Just a thought. How about a sysfs entry which you can use to jam the device into either slave or
host mode?

Mark

> 								Pavel
> 
> -- 
> Thanks, Sharp!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
