Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317322AbSFLVPa>; Wed, 12 Jun 2002 17:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSFLVP3>; Wed, 12 Jun 2002 17:15:29 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:52022 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317322AbSFLVP2>; Wed, 12 Jun 2002 17:15:28 -0400
Message-Id: <5.1.0.14.2.20020612221233.045aa5a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 12 Jun 2002 22:15:19 +0100
To: Andreas Dilger <adilger@clusterfs.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Rusty Russell <rusty@rustcorp.com.au>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20020612210356.GD682@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:03 12/06/02, Andreas Dilger wrote:
>On Jun 12, 2002  21:41 +0100, Anton Altaparmakov wrote:
> > But if doing something like that I might as well use the present
> > approach and just allocate all buffers at once if they haven't been
> > allocated yet and be done with it. Then no vfree()s are needed either and
> > then it really does work. (-;
>
>But then you may be allocating a lot of memory for CPUs that don't
>even exist, which is the whole point of this exercise.  Better to do
>it on-demand and loop for the very few times needed.

Sorry I ommitted a step from my trend of thought when writing the above. I 
was assuming that I would be using the cpu_possible() macro that is to be 
introduced so that only buffers for actually existing cpu sockets get 
allocated.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

