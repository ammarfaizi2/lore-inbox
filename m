Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316173AbSEQNZd>; Fri, 17 May 2002 09:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316190AbSEQNZc>; Fri, 17 May 2002 09:25:32 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:39524 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316173AbSEQNZa>; Fri, 17 May 2002 09:25:30 -0400
Message-Id: <5.1.0.14.2.20020517141805.049c1b60@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 17 May 2002 14:25:47 +0100
To: root@chaos.analogic.com
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: Just an offer
Cc: Halil Demirezen <halild@bilmuh.ege.edu.tr>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020517085300.4551A-100000@chaos.analogic.co
 m>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:01 17/05/02, Richard B. Johnson wrote:
>The remaining problem is how one trips a reboot if the remote machine
>doesn't come up correctly. That problem can be handled by temporarily
>changing panic() to a hard reset.

As long as you have a second machine colocated with the first one, you can 
connect an optocoupler to one of the data lines on the parallel port of the 
"stable" machine and to the motherboard reset connector on the "unstable" 
machine. You then raise the appropriate data line on the "stable" machine 
and lower it again (I keep it at high for 100msecs) and the "unstable" 
machine is hard reset... So you just need an old 386 with a parallel port 
and a network card that will never be reset and that can reboot multiple 
machines (each data line can connect to another machine, etc...).

Best regards,

         Anton

ps. Kudos for the idea go to Rogier Wolff and not to me... I just 
implemented his idea locally and can only say it works wonders. (-:


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

