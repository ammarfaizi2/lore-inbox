Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281023AbRKTLW0>; Tue, 20 Nov 2001 06:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281024AbRKTLWQ>; Tue, 20 Nov 2001 06:22:16 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:8387 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281023AbRKTLWK>; Tue, 20 Nov 2001 06:22:10 -0500
Message-Id: <5.1.0.14.2.20011120111439.04d42380@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 20 Nov 2001 11:20:06 +0000
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: x bit for dirs: misfeature?
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <01112012582101.00810@nemo>
In-Reply-To: <200111191814.fAJIEPlQ019878@pincoya.inf.utfsm.cl>
 <200111191814.fAJIEPlQ019878@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:58 20/11/01, vda wrote:
>I'm asking for ability to make a tree _world-readable_ (and
>browsable), i.e. a+r on files and a+rx on dirs.
>There is currently no chmod flag which will do that.

So what? The following two commands do exactly that:

find . -type d -exec chmod a+rx "{}" \;
find . -type f -exec chmod a+r "{}" \;

Just stick them in a shell script and call the script chmod-world-readable 
and stop complaining...

You would obviously want to change the "." to be $1 so it is the 1st 
argument to the script...

It will be a bit slow and can be optimized endlessly but it will do the 
trick and you probably won't be running it that often so speed is not an 
issue... And if it is then grab the chmod sources and add the wanted 
functionality with a new swich and be done with it.

This is WAY Off Topic for Linux kernel!

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

