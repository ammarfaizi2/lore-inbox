Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbQKIWl7>; Thu, 9 Nov 2000 17:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQKIWlt>; Thu, 9 Nov 2000 17:41:49 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:60456 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129740AbQKIWl2>; Thu, 9 Nov 2000 17:41:28 -0500
Message-ID: <3A0B27E3.7D10AB64@linux.com>
Date: Thu, 09 Nov 2000 14:40:36 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Dunlap, Randy" <randy.dunlap@intel.com>
CC: Greg KH <greg@wirex.com>, linux-kernel@vger.kernel.org
Subject: Re: [bug] usb-uhci locks up on boot half the time
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC82@orsmsx31.jf.intel.com>
Content-Type: multipart/mixed;
 boundary="------------6622813134C9328FE0841C49"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6622813134C9328FE0841C49
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Dunlap, Randy" wrote:

> > Either.  Currently bus (self) powered.  This hub has worked
> > fine on my other
> > computers without any adverse affect.
>
> Bus-powered != self-powered.

It had been a long day.  I really do know the distinction :)

It is currently bus powered and I've only once had it self powered
several months ago.  It is an SIIG 4 port hub, I hadn't seen any
complaints about it doing a web search when I looked, so I purchased it.

I have found that after unplug/plug the mouse and reboot, If I unplug
the hub then the boot will continue fine, if I unplug the just the mouse
(which is plugged into the hub), the machine will indeed hang.  If I
reset the power on the hub and plug it back in it will still hang.
I must reset the power on the motherboard.

The oddity is that kdb shows the machine to lock up on the popf in
pci_conf_write_word()+0x2c.  I never did get around to digging up this
routine and looking at the code, but I suspect this is a final return
from the routine.  I'm rather confused however, I have no idea why a
flags pop would hang the hardware.

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------6622813134C9328FE0841C49
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------6622813134C9328FE0841C49--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
