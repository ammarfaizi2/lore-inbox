Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbRAaSeG>; Wed, 31 Jan 2001 13:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbRAaSd4>; Wed, 31 Jan 2001 13:33:56 -0500
Received: from md.aacisd.com ([64.23.207.34]:10001 "HELO md.aacisd.com")
	by vger.kernel.org with SMTP id <S130113AbRAaSdo>;
	Wed, 31 Jan 2001 13:33:44 -0500
Message-ID: <8FED3D71D1D2D411992A009027711D671880@md>
From: Nathan Black <NBlack@md.aacisd.com>
To: "'bert hubert'" <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
Subject: RE: drive/block device write scheduling, buffer flushing?
Date: Wed, 31 Jan 2001 13:29:05 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is what I wanted to do...Write directly to the disk. But the
kernel(2.4.1) is caching the io...



-----Original Message-----
From: bert hubert [mailto:ahu@ds9a.nl]
Sent: Wednesday, January 31, 2001 12:51 PM
To: Nathan Black
Cc: linux-kernel@vger.kernel.org
Subject: Re: drive/block device write scheduling, buffer flushing?


On Wed, Jan 31, 2001 at 11:52:25AM -0500, Nathan Black wrote:
> I was wondering if there is a way to make the kernel write to disk faster.

> I need to maintain a 10 MB /sec write rate to a 10K scsi disk in a
computer,
> but it caches and doesn't start writing to disk until I hit about 700 MB.
At
> that point, it pauses(presumably while the kernel is flushing some of the
> buffers) and I will have missed data that I am trying to capture.

try opening with O_SYNC, or call fsync() every once in a while. Otherwise,
this sounds like an application for a raw device, whereby you can write
directly to the disk, with no caching in between.

Regards,

bert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
