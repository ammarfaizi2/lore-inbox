Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318090AbSGMEjZ>; Sat, 13 Jul 2002 00:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318091AbSGMEjY>; Sat, 13 Jul 2002 00:39:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19461 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318090AbSGMEjX>;
	Sat, 13 Jul 2002 00:39:23 -0400
Message-ID: <3D2FAF94.7070100@mandrakesoft.com>
Date: Sat, 13 Jul 2002 00:41:56 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt_Domsch@Dell.com
CC: alan@lxorguk.ukuu.org.uk, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Removal of pci_find_* in 2.5
References: <F44891A593A6DE4B99FDCB7CC537BBBB0724D1@AUSXMPS308.aus.amer.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:
> In both these cases, the pci_find_device() functions use an explict ordering
> to make it far more likely we can still boot the system after adding new
> hardware.  Unless/until there's a method for telling the kernel/modules that
> a particular device is the boot device (ala BIOS EDD 3.0 if vendors were to
> get around to implementing such) explict ordering in the drivers is the only
> way we can build complex storage solutions and boot reliably.


IMO what devices are boot devices is a policy decision.  Depending on 
pci_find_device() use in a driver's kernel code, or kernel link 
ordering, is simply hard-coding something that should really be in 
userspace.  Depending on pci_find_device logic / link order to 
still-boot-the-system after adding new hardware sounds like an 
incredibly fragile hope, not a reliable system users can trust.

	Jeff



