Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289246AbSAII0S>; Wed, 9 Jan 2002 03:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289255AbSAII0B>; Wed, 9 Jan 2002 03:26:01 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:13266
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S289246AbSAIIZ4>; Wed, 9 Jan 2002 03:25:56 -0500
Message-ID: <3C3BFE6D.1000602@dplanet.ch>
Date: Wed, 09 Jan 2002 09:25:17 +0100
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: esr@thyrsus.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <Pine.LNX.4.33.0201070955480.867-100000@segfault.osdlab.org> <Pine.LNX.4.33.0201071908580.16327-100000@Appserv.suse.de> <20020107185001.GK7378@kroah.com> <20020107185813.GL7378@kroah.com> <3C3AA7FE.2060304@dplanet.ch> <20020108183635.GG14410@k
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> What about devices that are supported by more than one driver?  How do
> you handle that?  (see the USB keyspan_pda and keyspan drivers for an
> example.)

I check the devices supported by multiple drivers, and normally
I comment both probes (This is why I have so much probes commented.
These drivers are marked in my db '## 2x').
Sometime I arbitrary choice a device.
I.e. in FS 'autofs4' is prefered to 'autofs'.
In the case of USB, two driver 'register' the uhci cards.
I prefer USB_UHCI_ALT to USB_UHCI (arbitrary choice).

I would like comments and correction to these choices.
(The kernel is to big to know all, and the sources are not
usefull in some cases)


BTW the database is available to all. If somebody need it
I can confirm that the database is complete (for MODULES_TABLE
items).
The database have these informations:
- type (pci, usb, pnp,...)
- device ID (ev. with class) or class ID, or interface ID or function ID, or both
- configuration variable
- source (the kernel file where the device is defined)
(for non autoprobe use, you should discard the ev. first '#', CONFIG = "_" means 'always',
in pci the "!" before the source means from MODULES_TABLE, the other pci are detected by other
methods (no so accurate)



	giacomo

