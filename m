Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVHXNZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVHXNZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 09:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbVHXNZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 09:25:29 -0400
Received: from [202.125.80.34] ([202.125.80.34]:62282 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1750951AbVHXNZ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 09:25:28 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: The Linux FAT issue on SD Cards.. maintainer support please
Date: Wed, 24 Aug 2005 18:48:20 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B03CBF7@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The Linux FAT issue on SD Cards.. maintainer support please
Thread-Index: AcWorNrH92GQLMQAS4Syi6T317h8FQAAQxbw
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: <hirofumi@mail.parknet.co.jp>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Lenneart,

>Most common for disk devices is XXYZ where XX is some name for the
>driver (hd for ide, sd for scsi, other things for other drive types), Y
>is a letter (a for first, b for second, c for third, etc) and Z is the
>partition number.  So in your case you could have:
>
>tfaa for first slot
>tfaa1 for first partition on first slot.
>tfab for second slot
>tfab4 for 4th partition on second slot.
>Or call it tf and use tfa1 tfb4 etc.

That's fine.
My controller itself alone handle FOUR device at a time (u mea these
should be (tfa, b , c d)
But how do I represent if I have more than one such controller i.e. it
is more 4 devices each with more parttions again.

Thanks & Regards,
Mukund Jampala


>
>> I have four sockets on which I have to support individual device with
>> partitions on them. Is there a better conventional way to represent
all
>> the four devices? My driver also supports 4 such controllers. To
support
>> first socket device on the second controller I am using tfb0, tfb0p1,
>> tfb0p2...
>
>Well at least ide and scsi don't care which controller, they still just
>name them in order.  You could just use tfa up to tfp for the devices.
>That is what I would do unless the seperate controllers really make
more
>sense to users (counting to slot 16 might be a bit much using letters
>for some users).
>
>Maybe tf1a2 for controller 1 slot a partition 2 would be nicer to the
>user.  Some raid cards do use /dev/raidname/c1d2p3 for card 1 device 2
>partition 3.  Maybe you prefer that arangement.
>
>> I have left with handling lot of generalization in the code.
>
>Len Sorensen
