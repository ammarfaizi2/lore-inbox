Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVAONo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVAONo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVAONo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:44:28 -0500
Received: from the.earth.li ([193.201.200.66]:54673 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S262284AbVAONnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:43:11 -0500
Date: Sat, 15 Jan 2005 13:43:10 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: e3-hacking@earth.li
Subject: Re: Possible GPL Violation of Linux in Amstrad's E3 Videophone.
Message-ID: <20050115134310.GS1725@earth.li>
References: <alan@lxorguk.ukuu.org.uk> <1096640407.21940.33.camel@localhost.localdomain> <200410011559.i91FxfH13266@blake.inputplus.co.uk> <35fb2e5904100109246f43ee7b@mail.gmail.com> <1096646380.21962.64.camel@localhost.localdomain> <20050107214852.GI5449@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050107214852.GI5449@earth.li>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 09:48:52PM +0000, Jonathan McDowell wrote:
> On Fri, Oct 01, 2004 at 04:59:44PM +0100, Alan Cox wrote:
> > If anyone has a copy of the emailer source btw (or gets one for review
> > so has a download option ;)) then it would be nice to stick it up for
> > ftp for all.
> No one seems to have done this, and the offer Amstrad makes requires the
> sending off of £25 to them to cover admin and distribution costs rather
> than allowing a download of it. I did this a few days ago so will
> hopefully hear from them in the next week or so.

I've now received this and it's linked from:

http://www.earth.li/~noodles/hardware-e3.html

Interesting (to me at least) points:

* Camera source included and seems to present as a standard v4l device.
* The keyboard driver is a module (not included) - there's a stub
  present presumably so basic init works.
* The Pegasus USB networking module is compiled in; I've confirmed it
  initialises such a device, but see no network traffic (CONFIG_IP_PNP
  and friends are enabled in the .config provided, but I guess this may
  be from a debug tree?)
* There's Belkin USB serial device support in the .config as well, but I
  can't see any output when I hook up such a device.

I've setup a list at:

http://www.earth.li/cgi-bin/mailman/listinfo/e3-hacking

for anyone who wants to discuss the hardware/software of the device.

What I'd really like to see is a dump of the flash from the device, in
the hope that the startup scripts might do something with the ethernet.
However I don't have the appropriate kit to be able to do this.
Alternatively it looks like there's a serial console on ttyS0 (UART1 on
the OMAP?), but I can't see any obvious pads where that's brought out
to.

(Oh, and as a semi related aside; if anyone has GPL contacts in Linksys
I'd be most interested to know about them - I'm completely failing to
get hold of kernel source for the WMA11B, which runs 2.4.17-rmk3-cot1.)

J.

-- 
"I can see an opening for the four lusers of the Apocalypse... 'I
didn't change anything', 'My e-mail doesn't work', 'I can't print' and
'Is the network broken?'." -- Paul Mc Auley, asr
