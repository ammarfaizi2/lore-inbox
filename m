Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRCFOjD>; Tue, 6 Mar 2001 09:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129305AbRCFOix>; Tue, 6 Mar 2001 09:38:53 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:13075 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129164AbRCFOii>; Tue, 6 Mar 2001 09:38:38 -0500
Message-Id: <200103061438.f26EcXO03994@aslan.scsiguy.com>
To: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
cc: LK <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.3 and new aic7xxx 
In-Reply-To: Your message of "Tue, 06 Mar 2001 00:08:22 EST."
             <3AA470C6.1A2BD379@neuronet.pitt.edu> 
Date: Tue, 06 Mar 2001 07:38:33 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This is just to report on a the behavior of this driver. I've a dual
>channel Adaptec 7895 controller. The adapter BIOS is configured to boot
>from devices in channel B. I boot from  a disk connected to channel B
>and when the kernel loads the driver the disks from channel A are seen
>first, resulting in the drive names changing from, say sda to sdb. This
>does not happen with 2.2.18 or 2.4.2. Is there an option to reverse the
>order? I saw some of the options in the code, but none about this.
>
>In any case, booting halts since the root file system can't be mounted.
>It didn't fry my disks, either :)

There is code in the driver to handle the channel B primary setting,
but I must have broken it recently.  I'll reproduce this today
and get you a patch.

--
Justin
