Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278275AbRKSLdV>; Mon, 19 Nov 2001 06:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278085AbRKSLdN>; Mon, 19 Nov 2001 06:33:13 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:44766 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S278364AbRKSLdB>;
	Mon, 19 Nov 2001 06:33:01 -0500
Message-Id: <5.1.0.14.2.20011119112724.0508e6b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 19 Nov 2001 11:32:38 +0000
To: David Chow <davidchow@rcn.com.hk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Important, Memory padding in kernel using 1byte
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1006160395.1198.0.camel@star9.planet.rcn.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:59 19/11/01, David Chow wrote:
>I notice using gcc compiling the kernel has the padding default set to
>32-bit (4 bytes) on IA32's. This cause lots of trouble when doing file
>system developments where a couple of data structures are not multiple
>of 4 bytes. This cause lots of errors, I think this should be notified
>to all developers when trying to deal with data structures not are
>multiple of 4 bytes. Is it worth while to compile the kernel with the
>padding set to 1 byte or will it cause any trouble? I know most of the
>compiled programs or even modules are default to use the 32bit padding.
>Please give advice.

That's what __attribute__ ((__packed__)) is for. All places in the kernel 
requiring that specific structure/union members are not padded should use 
this to tell gcc so.

And there is __attribute__ ((aligned (size))); where size is the minimum 
alignment.

Have a look at "info gcc" sometime under C extensions , "Type attributes"...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

