Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289026AbSAIVe6>; Wed, 9 Jan 2002 16:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289027AbSAIVes>; Wed, 9 Jan 2002 16:34:48 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:15541 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S289026AbSAIVek>; Wed, 9 Jan 2002 16:34:40 -0500
Message-Id: <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 09 Jan 2002 21:34:34 +0000
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Cc: Greg KH <greg@kroah.com>, felix-dietlibc@fefe.de,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <1382203430.1010610946@[195.224.237.69]>
In-Reply-To: <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:15 09/01/2002, Alex Bligh - linux-kernel wrote:
>>>Here's what I want to have in my initramfs:
>>>         - /sbin/hotplug
>>>         - /sbin/modprobe
>>>         - modules.dep (needed for modprobe, but is a text file)
>>>
>>>What does everyone else need/want there?
>>
>>It is planned to move partition discovery to userspace which would then
>>instruct the kernel of the positions of various partitions.
>>
>>The program(s) to do this will need to be in pretty much everyones
>>initramfs...
>
>What with mounting root via NFS, hence having to set up
>IP et al, mounting various different
>partition types, avoiding the kludge of fsck etc.,
>being able to recover from a corrupted root, you
>might as well just cpio up your /sbin and stick
>that in, and be able to run single user mode without
>a 'normal' root. <FX: ducks & runs>
>
>seriously point: ls /sbin gives a /maximum/ range I'd
>have thought.

Partition discovery is currently done within the kernel itself. The code 
will effectively 'just' move out into user space. As such it is not present 
in /sbin now but it will be in initramfs. The same is true for various 
other code I can imagine moving out of kernel mode into initramfs...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

