Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266929AbRG1Qpe>; Sat, 28 Jul 2001 12:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbRG1QpY>; Sat, 28 Jul 2001 12:45:24 -0400
Received: from ns.caldera.de ([212.34.180.1]:43927 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S266929AbRG1QpH>;
	Sat, 28 Jul 2001 12:45:07 -0400
Date: Sat, 28 Jul 2001 18:45:09 +0200
Message-Id: <200107281645.f6SGj9i20662@ns.caldera.de>
From: Marcus Meissner <mm@ns.caldera.de>
To: kiwiunixman@yahoo.co.nz (Matthew Gardiner), linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <01072901450000.02683@kiwiunixman.nodomain.nowhere>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <01072901450000.02683@kiwiunixman.nodomain.nowhere> you wrote:
> Regards to the ReiserFS. Something more spookie, OpenLinux (no boos and 
> hisses please ;) ), they have ReiserFS as a module, yet, when I have the root 
> partition as reiser I have no problems, voo doo magic perhaps? because when I 
> compiled 2.4.7 w/ ReiserFS as a module, the boot forks up.

We have the reiserfs module in the initial ramdisk in such setups. 

You need to recreate the initrd in those cases.
(Run "/usr/libexec/modules/mkinitrd.sh 2.4.7" in the /boot directory, this
 will create /boot/initrd-2.4.7.gz.)

> Regarding the last comment, I think Redhat and Caldera have debugging enable 
> (God knows why?), well, Caldera definately dones, after having a look at 
> their default kernel configuration, hence, when I recompiled my kernel to 
> 2.4.7, threw the reiserFS into the guts of the kernel with debugging turned 
> off, there was a speed increase.

ReiserFS is experimental in the 2.4 series, thats why we ship with a big
disclaimer and with checking enabled.

(And before you argue again, we ship 2.4.2-ac26. Since then several major
 bugs have been found in reiserfs, including the knfsd lossage.)

Ciao, Marcus
