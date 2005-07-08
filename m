Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVGHUTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVGHUTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVGHURW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:17:22 -0400
Received: from bay103-f15.bay103.hotmail.com ([65.54.174.25]:3270 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262864AbVGHUQE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:16:04 -0400
Message-ID: <BAY103-F15735CB496F2075E4B9494C4DB0@phx.gbl>
X-Originating-IP: [65.54.174.201]
X-Originating-Email: [jonschindler@hotmail.com]
In-Reply-To: <p734qb5p04e.fsf@verdi.suse.de>
From: "Jon Schindler" <jonschindler@hotmail.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of RAM
Date: Fri, 08 Jul 2005 16:16:02 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 08 Jul 2005 20:16:03.0744 (UTC) FILETIME=[DD934A00:01C583F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just thought that I would add, USB works fine if I boot with knoppix 3.9, 
or with Windows XP, even with 3GB's of RAM installed.  It's only if I try to 
use USB mass storage devices, Fedora Core 4 64 bit, and 3GB's of RAM at the 
same time that I get this issue with USB.  If I change the OS to XP, but 
keep the RAM at 3GB, it works fine.  If I remove some RAM and only run 2GB's 
of RAM, then FC4 with the 2.6.12.1 64 bit kernel works fine.
So, to sum things up:
       RAM amount                OS            64or32bit               USB 
storage works?
            3GB                    FC4 2.6.12.1        64                    
          no
            2GB                    FC4 2.6.12.1        64                    
          yes
            3GB                         XP SP2           32                  
            yes
            2GB                         XP SP2           32                  
            yes
            3GB                  Knoppix 3.9           32                    
          yes
            2GB                  Knoppix 3.9           32                    
          yes

Thanks again,

Jon


>From: Andi Kleen <ak@suse.de>
>To: "Jon Schindler" <jonschindler@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of 
>RAM
>Date: 08 Jul 2005 21:29:37 +0200
>
>"Jon Schindler" <jonschindler@hotmail.com> writes:
> >
> > This mainly seems to be an issue with USB mass storage devices like
> > USB memory sticks and USB hard drives (I've tried both, and neither is
> > assigned a scsi device properly).  I am still able to use my USB mouse
> > when I have 3GB installed.  I'm not sure if that makes it a USB 1.1
> > issue or a USB storage issue, but hopefully someone will have some
> > insight after looking at the logs.  Thanks in advance for any help.
>
>It sounds like the Nvidia EHCI controller has trouble DMAing to high
>addresses. Would be a bad bug if true.
>
>Does it work when you disable EHCI and only enable OHCI? (this will
>limit you to USB 1.1)
>
>-Andi


