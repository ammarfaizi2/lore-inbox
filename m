Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSFTUzo>; Thu, 20 Jun 2002 16:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315528AbSFTUzn>; Thu, 20 Jun 2002 16:55:43 -0400
Received: from [195.63.194.11] ([195.63.194.11]:62736 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315525AbSFTUzl> convert rfc822-to-8bit; Thu, 20 Jun 2002 16:55:41 -0400
Message-ID: <3D124149.6010901@evision-ventures.com>
Date: Thu, 20 Jun 2002 22:55:37 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: James Bottomley <James.Bottomley@steeleye.com>,
       Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
References: <Pine.LNX.4.44.0206201115460.8225-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Linus Torvalds napisa³:

> For example, to be useful, every driver that knows about disks should make
> sure they show up with some standard name (the old "disk" vs "disc" war
> ;), exactly so that you _should_ be able to do something like
> 
> 	find /devices -name disk*

Not good. find /devices -name "/sd@* -- will be unambigious.
There are good reaons they do it like they do on the "other unix OS"...

> and be able to enumerate every disk in the whole system.

> 
> 	/devices/disks/disk0 -> ../../pci0/00:02.0/02:1f.0/03:07.0/disk0
                  ^^^^^^^^^^ You notice the redundancy in naming here :-).

> 	               disk1 -> ../../pci0/00:02.3/usb_bus/001000/dev1
> 
> the same way that Pat already planned to do the mappings for network
> devices in /devices/network/eth*.

Boah the chierachies are already deep enough. /devices/net/eth@XX
will cut it.

> Is this done? No. But is it fundamentally hard? Nope. Useful? You be the
> judge.  Imagine yourself as a installer searching for disks. Or imagine
> yourself as a initrd program that runs at boot, setting up irq routings
> etc before the "real boot".

Yes but again the most content files found there are already inventing
interfaces on the heap. /name /irq /resources /power this will end the same
as similar attempts ended already - in a mess.

