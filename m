Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266428AbRGYUH5>; Wed, 25 Jul 2001 16:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267515AbRGYUHs>; Wed, 25 Jul 2001 16:07:48 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:54993 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266574AbRGYUHg>; Wed, 25 Jul 2001 16:07:36 -0400
Message-Id: <5.1.0.14.2.20010725204755.00b12980@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 25 Jul 2001 21:07:42 +0100
To: Gabriel Rocha <grocha@neutraldomain.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Status of NTFS support was Re: [PATCH] 2.4.7 More tiny
  NTFS fixes
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010723162636.E36051@neutraldomain.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

At 00:26 24/07/2001, Gabriel Rocha wrote:
>,----[ On Tue, Jul 24, at 12:14AM, Anton Altaparmakov wrote:
>| Please apply below patch. It is against 2.4.7 and adds three more
>|return checks (it is orthogonal to the one sent on Sunday).
>`----[ End Quote ]---------------------------
>
>Not that I understand what this means, I have no idea. But, I know that
>NTFS used to be really poorly supported in the kernel. I have seen a few
>patches to it ove rthe past couple of weeks and makes me wonder what the
>status of it is now. Anyone care to comment? --gabe

I will comment as the current maintainer. (-:

If you by "poorly supported" mean that it was a more or less abandoned 
project then that has changed a lot indeed. NTFS is now under active 
development, both kernel and user space side. I am happy to receive patches 
and forward them for inclusion if appropriate or integrate them in my local 
development tree and submit as larger patch later (depends on the 
triviality of the patches). And I try to respond asap to requests/bug 
reports/etc. Currently my personal response times are between 5mins and a 
week or so depending on how busy I am.

If by "poorly supported" you mean it doesn't work very well, then that has 
improved as well. We have a fully functional mkntfs program already on the 
userspace side and ntfsfix which repairs some of the damage done by the 
ntfs driver making it a bit somewhat safer to use. The driver itself has 
much improved in recent months, writing is now relatively ok as long as it 
happens on a UP system, to simple files and directories. There is still a 
lot not implemented so only the simple case works for now. Reading is 
relatively stable and most things are implemented wrt to reading the normal 
data attribute of both uncompressed and compressed files. We now can cope 
with large files to the full potential of NTFS (i.e. we cope with 2^63 byte 
sized files) for example to mention one of the improvements.

So to summarize: we are working on it but don't hold your breath. NTFS is 
highly complex and extremely poorly documented. Most of our knowledge is 
based on reverse engineering and looking at on-disk structures with 
hex/disk editors and it will take considerable time to have a fully working 
fully featured NTFS implementation...

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

