Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWGJPfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWGJPfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWGJPfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:35:31 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:22666 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964886AbWGJPfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:35:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EGYsBb0KHX8FWZRUq23GeQwfSBFnoOQX9FaIL9hOAcGq/Jrs/nU26W156Hv5cHqdSwMgXIxeewNJSBH+m9xQpDWxQUsAfwfpdKd4gMmD99kG7MvqNnr5BlwOXTWohxvPc6pg9sVRrZW92oNfcKuxmRd+MJoUDrWJTiW4W9FaWeY=
Message-ID: <44B273B9.8050308@gmail.com>
Date: Mon, 10 Jul 2006 23:35:21 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jon Smirl <jonsmirl@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up old names in tty code to current names
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>	 <1152524657.27368.108.camel@localhost.localdomain>	 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>	 <1152537049.27368.119.camel@localhost.localdomain>	 <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com>	 <1152539034.27368.124.camel@localhost.localdomain>	 <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>	 <44B26752.9000507@gmail.com>	 <9e4733910607100757t4ddfaf93l1723580de551529b@mail.gmail.com> <1152544746.27368.134.camel@localhost.localdomain>
In-Reply-To: <1152544746.27368.134.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Llu, 2006-07-10 am 10:57 -0400, ysgrifennodd Jon Smirl:
>>> A few apps do rely on /proc/tty/drivers for the major-minor
>>> to device name mapping. /dev/vc/0 does not exist (unless
>>> created manually) without devfs.
>> This is why I questioned if /proc/tty was really in use, it contains
>> an entry that is obviously wrong for my system.
> 
> Which tools already know about.

True.  I see this code snippet many times:

fd = open("/dev/vc/0", FLAGS);
if (fd == -1)
	fd = open("/dev/tty0", FLAGS);
 
> What is so hard to understand about the
> idea that pointless random changes break stuff and don't fix things.

But since we're killing devfs, changing /dev/vc/0 to /dev/tty0 will be one
of the nails in devfs' coffin :-)

Tony
