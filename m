Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289910AbSAPJpS>; Wed, 16 Jan 2002 04:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289907AbSAPJpC>; Wed, 16 Jan 2002 04:45:02 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:35767 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S289906AbSAPJoi>;
	Wed, 16 Jan 2002 04:44:38 -0500
Message-Id: <5.1.0.14.2.20020116094806.04f00380@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 16 Jan 2002 09:50:11 +0000
To: Norbert Preining <preining@logic.at>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [BUG] 2.4.18.3, ide-patch, read_dev_sector hangs in
  read_cache_page
Cc: linux-kernel@vger.kernel.org, andre@linuxdiskcert.org
In-Reply-To: <20020116102738.A21977@alpha.logic.tuwien.ac.at>
In-Reply-To: <20020116094935.A20738@alpha.logic.tuwien.ac.at>
 <E16QU3F-0005g6-00@libra.cus.cam.ac.uk>
 <20020115160315.A2515@alpha.logic.tuwien.ac.at>
 <20020116094935.A20738@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:27 16/01/02, Norbert Preining wrote:
>On Mit, 16 Jan 2002, preining wrote:
> > I have tried to follow the trace of the kernel but it looks to me as
> > read_cache_page is never called or printk in it are not executed. I filled
>
>Stupid me, somehow KERN_DEBUG was not shown.
>
>I traced it down from
>read_cache_page -> lock_page -> __lock_page -> schedule
>
>There it hangs and I was not able with my stupid methods or printk-ing
>to find the place where it hangs in sched.c (Maybe because of recursive
>calls to sched by printk).
>
>One more thing: Taking off hdf from the ide controller and everything
>works.
>Another: same with 2.4.18-pre4

You mean 2.4.18-pre4 (without any patches) dies in the same way on hdf?

If so that is very interesting...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

