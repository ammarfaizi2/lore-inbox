Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbTHZF6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbTHZF6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:58:54 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:36361 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S262629AbTHZF6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:58:52 -0400
Message-ID: <3F4AF424.1070502@boxho.com>
Date: Tue, 26 Aug 2003 01:46:12 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test4] VFS: Cannot open root device
References: <20030825130331.GA20696@vinku.pingviini.net>
In-Reply-To: <20030825130331.GA20696@vinku.pingviini.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think that is a kernel problem. I've seen those errors with 2.6 
yesterday and today
but it was a messed up lilo situation and root in need of fsck and once 
due to switching
drives/controller positions so root wasn't the same root. devfs, moving 
drives, bios
settings to boot offboard disk controllers, somehow the root isn't the 
same as for the
lilo op.

Sounds like you could just boot an install disk or an old kernel, open a 
shell, fsck, then lilo.
Just make sure your new kernel lists /dev/ide/host?/bus? the same so 
your lilo root= is
pointing to the disk you think it is.

-Bob

Niklas Vainio wrote:

>I get this at boot with 2.6.0-test[3,4]:
>
>VFS: Cannot open root device "341" or unknown-block(3,65) for ext3 error=-6
>Please append a correct "root=" boot option
>Kernel panic: VFS: Unable to mount root fs on unknown-block(3,65)
>
>Before this, kernel seems to detect hard disks just fine.
>
>This system boots fine with 2.2 and 2.4 kernels. I have tried setting
>root=/dev/hdb1 and rootfstype=ext2 (hdb1 is ext2) but this doesn't help.
>Config below. Is something missing?
>
>Thanks a lot for suggestions,
>    - Nikke
>  
>

