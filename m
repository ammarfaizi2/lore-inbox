Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVGBJJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVGBJJs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 05:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVGBJJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 05:09:48 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:27780 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261849AbVGBJJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 05:09:09 -0400
Message-ID: <42C659B2.8010002@free.fr>
Date: Sat, 02 Jul 2005 11:09:06 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS +
 empty /dev
References: <42C30CBC.5030704@free.fr> <20050629224040.GB18462@kroah.com> <1120137161.42c3efc93b36c@imp1-q.free.fr> <20050630155453.GA6828@kroah.com> <42C455C1.30503@free.fr> <20050702053711.GA5635@kroah.com> <42C640AC.1020602@free.fr> <20050702082218.GM8907@alpha.home.local>
In-Reply-To: <20050702082218.GM8907@alpha.home.local>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi Eric,

Hi willy,

> 
> On Sat, Jul 02, 2005 at 09:22:20AM +0200, Eric Valette wrote:
> 
>>Greg KH wrote:
>>
>>
>>>Why?  Why not put it in ROM with your kernel image, look at how the
>>>kernel build process does it with the "built-in" initramfs.
>>
>>Well, nowadays, most system have only flash because ROM does not enable
>>to do firmware upgrade. Second, putting it in the kernel or as a
>>separate flash section or in an initrd does not change the problem :
>>something has to be stored on non volatile memory whereas you do not
>>need that for devfs (except devfs code itself of course) but then you
>>have udev instead of devfs...
> 
> 
> Well, although I've never used udev because I've been using sort of an
> equivalent called "preinit" for 4 years now, I don't totally agree with
> you about the firmware upgrade : when you package your systems to allow
> the customer to perform "firmware" upgrades, your image is already very
> specific to a hardware model, and I don't see why you would need to
> create /dev entries independantly from the kernel or rootfs. 

I beg to disagree. More and more devices have generic connectivity plug
(USB, 1394, ...) and you may update your firmware because you support a
new device connected to this plug that is not a generic device (specific
driver needed) but you may also have provisionned generic devices
drivers for the plug and want devices created only when device is
plugged (usb mass storage comes in mind). If I make a static /dev
provision for a USB disk how many useless partition will I need to
create, and how will I mount the correct number of partition without
hotplug like feature and analysing by hand the partition table?


>>BTW : valette@tri-yann->df /dev
>>Filesystem           1K-blocks      Used Available Use% Mounted on
>>tmpfs                    10240      2876      7364  29% /dev
>>
>>
>>2 MB RAM on my PC???  I must be missing something.
> 
> 
> I think something went wrong, perhaps something like
> 
>    # some_prog >/dev/null 
> 
> while null did not exist. My /dev is a tmpfs too, but mounted with size=0,
> so that I can only create inodes into it, but cannot write any data. One
> other advantage of using size=0 is that "df" does not show it by default.

Not sure. It is a debian sid install.

Thanks anyone who responded. I'll be unable to read mails for a while.


-- eric
