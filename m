Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSEGNPr>; Tue, 7 May 2002 09:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315441AbSEGNPq>; Tue, 7 May 2002 09:15:46 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:6443 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315440AbSEGNPp>; Tue, 7 May 2002 09:15:45 -0400
Message-Id: <5.1.0.14.2.20020507140736.022aed90@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 07 May 2002 14:16:04 +0100
To: Martin Dalecki <dalecki@evision-ventures.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.14 IDE 57
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD7BA24.9050205@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:27 07/05/02, Martin Dalecki wrote:
>Tue May  7 02:37:49 CEST 2002 ide-clean-57
>
>Nuke /proc/ide. For explanations why, please see the frustrated comments 
>in the previous change log.

This is a big mistake IMO.

Nuking the ability to change settings, fair enough, but only if alternative 
interface is provided for userspace to tweak everything, otherwise provide 
the interface before you remove the existing one. (There may be already 
another interface, I don't know...I am sure someone will tell me if there is!)

Removing the information provided by /proc/ide is very bad! It is very 
useful to diagnose one's ide setup, to see what the host is configured as, 
what all settings are set to, etc. This is the first place I look to check 
whether the interfaces are configured as I expect them to be and in case of 
problems, this is again the first place I look.

What alternatives are you going to present to give all the information that 
/proc/ide gives? If the answer is none IMHO your patch is not acceptable...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

