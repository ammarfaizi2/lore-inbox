Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbTATNTt>; Mon, 20 Jan 2003 08:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbTATNTt>; Mon, 20 Jan 2003 08:19:49 -0500
Received: from oak.sktc.net ([208.46.69.4]:220 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S265791AbTATNTs>;
	Mon, 20 Jan 2003 08:19:48 -0500
Message-ID: <3E2BF992.4030406@sktc.net>
Date: Mon, 20 Jan 2003 07:28:50 -0600
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021201
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexandre April <alexandre.april@sympatico.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: CD Changer
References: <Pine.LNX.4.33L2.0301192027510.26490-100000@dragon.pdx.osdl.net> <00da01c2c083$7d70fa00$0500000b@shiva.com>
In-Reply-To: <00da01c2c083$7d70fa00$0500000b@shiva.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre April wrote:
> I'm using kernel 2.4.x and to be able to use that patch I'll have do modify
> some compatibility issue, and I don't have time righht now to to that !

The problem is that Linus did not see fit to make the IDE changer code 
present an IDE changer as multiple block devices, as a SCSI changer is. 
As a result, you cannot mount each disk in the changer seperately - all 
you have is a tool to change which disk is accessed by the single block 
device.

Linus's stated position is that since a disk change takes a fair amount 
of time, in a situation where multiple users are accessing different 
disks the system could thrash between the disks and go nowhere, slowly. 
If you search old LKML posts of about three years ago you should be able 
to find his exact post.

Now, I would dispute the logic, since the SCSI changer behavior is 
identical - I have both a SCSI changer and an IDE changer, and the SCSI 
changer will thrash if multiple processes are accessing different disks. 
Since SCSI does it, I see no reason why IDE cannot be allowed the same 
behavior. However, it's called "Linux" not "Davix"...

However, given that you can buy a 120G drive for US$120 or so, a changer 
has a lot less utility now-a-days. Just buy a cheap hard disk and copy 
the CDs onto it. That way, you have faster access, switch time is 
eliminated, and wear-and-tear on the disks and the changer are eliminated.

You could even DD the disk to a file, and mount that file as an ISO9660 
file system using loopback, thus preserving all the "CD-ishness" of the 
data.

Even if users wish to change disks - you can store a lot of disks in 
120G of storage - just copy the disk over and mount the copy.


