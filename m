Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263115AbVF3UaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbVF3UaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbVF3U3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:29:36 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:5290 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263115AbVF3U1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:27:51 -0400
Message-ID: <42C455C1.30503@free.fr>
Date: Thu, 30 Jun 2005 22:27:45 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS +
 empty /dev
References: <42C30CBC.5030704@free.fr> <20050629224040.GB18462@kroah.com> <1120137161.42c3efc93b36c@imp1-q.free.fr> <20050630155453.GA6828@kroah.com>
In-Reply-To: <20050630155453.GA6828@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Jun 30, 2005 at 03:12:41PM +0200, eric.valette@free.fr wrote:
> 
>>Quoting Greg KH <greg@kroah.com>:
>>
>>
>>>On Wed, Jun 29, 2005 at 11:03:56PM +0200, Eric Valette wrote:
>>>
>>>>For years now my /dev has been empty. When upgrading to 2.6.13-rc1 from
>>>>2.6.12, and updating my kernel config file via "make oldconfig" I got no
>>>>visible warning about CONFIG_DEVFS_FS options being set (or at least did
>>>>no see it).
>>>
>>>devfs has been marked OBSOLETE for a year now.  It has also been
>>>documented as going away.  Because of this, you should not have been
>>>supprised at all.
>>
>>I knew it! I just the announce for 2.6.13-rc1 did not contain this fact and I
>>did not realize booting this new kernel will fail on my machine which is bad for
>>a stable serie.
> 
> 
> As there is no longer a "development series" calling 2.6 a "stable
> series" isn't really true :)

Curious to wait until 2.6.13 pops up to see how much people will end up
having non working systems either because :
	1) They removed entries in their /dev
	2) Did not maintain their /dev for years because anyway it was not
directly accessed
	3) modified their /etc/fstab to put devfs names rather than FHS/LSB
compliant names...
	4) other weird /dev-devfs interaction I cannot imagine yet

BTW speaking of initramfs to hold the minimal /dev, in the embedded
world initramfs has to be stored in flash as udev binary and eventually
additionnal scripts, this represent flash memory (OK very little I have
to admit but when you need to find 10K of flash or change the flash
size...).

I hope someone will pick-up your nano defvs proposal and enhance it to
support a  version enabling to boot a system without anything in /dev.
Unfortunately no time yet on my side.

Thanks for all the things you have done in linux,

-- eric




