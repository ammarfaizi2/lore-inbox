Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289018AbSAIVQQ>; Wed, 9 Jan 2002 16:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSAIVQG>; Wed, 9 Jan 2002 16:16:06 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:1689 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S289018AbSAIVPv>;
	Wed, 9 Jan 2002 16:15:51 -0500
Date: Wed, 09 Jan 2002 21:15:46 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Anton Altaparmakov <aia21@cam.ac.uk>, Greg KH <greg@kroah.com>
Cc: felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <1382203430.1010610946@[195.224.237.69]>
In-Reply-To: <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Here's what I want to have in my initramfs:
>>         - /sbin/hotplug
>>         - /sbin/modprobe
>>         - modules.dep (needed for modprobe, but is a text file)
>>
>> What does everyone else need/want there?
>
> It is planned to move partition discovery to userspace which would then
> instruct the kernel of the positions of various partitions.
>
> The program(s) to do this will need to be in pretty much everyones
> initramfs...

What with mounting root via NFS, hence having to set up
IP et al, mounting various different
partition types, avoiding the kludge of fsck etc.,
being able to recover from a corrupted root, you
might as well just cpio up your /sbin and stick
that in, and be able to run single user mode without
a 'normal' root. <FX: ducks & runs>

seriously point: ls /sbin gives a /maximum/ range I'd
have thought.

--
Alex Bligh
