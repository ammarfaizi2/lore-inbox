Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTFTOlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 10:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTFTOlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 10:41:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:31721 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262361AbTFTOlx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 10:41:53 -0400
content-class: urn:content-classes:message
Subject: AW: Problem unmounting initrd-romfs in 2.4.21
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 20 Jun 2003 16:55:48 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Message-ID: <BDB86409B697CB4DBB8A5BF487B9D61A3934@srv01.losekann.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem unmounting initrd-romfs in 2.4.21
Thread-Index: AcM3Ov3PJDnzqYq8TKWvzX7zdRDp4QAAAzXQ
From: "Tobias Reinhard" <T.Reinhard@losekann.de>
To: "Andreas Haumer" <andreas@xss.co.at>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm booting up with a initrd in a romfs. After loading all needed 
>> modules and pivoting root I unmount the initrd and flush the used 
>> buffers.
>>
>> Since I updated to 2.4.21 I can't unmount the initrd - it says it's 
>> busy, but it's no (or at least lsof does say so).
>>
>> I use kernel 2.4.21 with /drivers/Makefile , /drivers/ide and 
>> /include/linux/ide.h from ac1 to reenable ide-modules.
>>
>> Anyone know the problem?
>>
>Hm, just a guess: do you have devfs mounted to /dev
>on the initial ramdisk (probably automounted by the
>kernel, with config option CONFIG_DEVFS_MOUNT=y)?
Yes, I use DEVFS and this was my first thought too. But even if I
unmount /dev before pivoting it's busy. (btw. it worked that way up to
2.4.20)

>Check the output of "mount", it'll show you if there's
>still something mounted under the "old" root.
After booting up completely I have the devfs at /dev where it should be
and the old root at /mnt. But it's still not umount-able. No other
mounts below it and no open files.

>We use initrd + devfs for ages now (we even use romfs for initrd like
you do), and it works fine with 2.4.21 too.

I just tried with 2.4.21-ac1 and it words perfectly. But I also want
grsecurity- and crypto-patch - so I can't use ac1... :-(

Tobias
