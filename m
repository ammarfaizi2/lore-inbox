Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVBGECI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVBGECI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 23:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVBGECI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 23:02:08 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:48023 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261343AbVBGECE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 23:02:04 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6: USB disk unusable level of data corruption
Date: Sun, 6 Feb 2005 20:01:59 -0800
User-Agent: KMail/1.7.1
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
References: <1107519382.1703.7.camel@localhost.localdomain> <16900.5586.511772.651559@smtp.charter.net> <MPG.1c7037c9d0a0407989711@news.gmane.org>
In-Reply-To: <MPG.1c7037c9d0a0407989711@news.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502062001.59546.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 February 2005 7:59 am, Giuseppe Bilotta wrote:
> 
> I have a MAGNEX/ViPower USB/FirWire external HD enclosure. I 
> found that it works pretty fine (albeit slowly) when connected 
> to the USB 1.1 ports built in my Dell Inspiron 8200, but trying 
> to connect it via the Hamlet PCMCIA USB2 Card Adapter doesn't 
> work (it seems it gets assigned minors 1,2,3,4,5,6,... and so 
> on forever until I unplug it).

What do you mean "minors"?  Addresses or actual /dev/sdN numbers?

If it's addresses, that would be an an enumeration problem.  Some
recent changes have caused prolems there, 2.6.11-rc3-mm2 ought to
have a patch making it better.  (Well, working around one of the
two problems that'd suggest.)

If it's actual /dev/sdN numbers, that would seem to be an issue
more at the level of usb-storage.  Quite possibly related to the
bugs you didn't exactly detail (below).

- Dave


> OTOH, I'm not sure if it's a PCMCIA adapter problem or USB2 
> enclosure problem. Indeed, if I don't load the EHCI modules, 
> and thus limit myself to the USB1.1 capabilities of the PCMCIA 
> adapters, I get other errors (I'll have to write a cleaner bug 
> report on this. And try the PCMCIA card with some other USB 
> device. Wish I could use my softmodem under Linux :(). (Using 
> kernel 2.6.10-3 from Debian.)

 
