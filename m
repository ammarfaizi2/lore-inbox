Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316034AbSEUIaE>; Tue, 21 May 2002 04:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSEUIaD>; Tue, 21 May 2002 04:30:03 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:50559 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316034AbSEUIaC>; Tue, 21 May 2002 04:30:02 -0400
Message-Id: <5.1.0.14.2.20020521092734.01fe4d30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 21 May 2002 09:29:54 +0100
To: ivangurdiev@linuxfreemail.com
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: Compiler question....
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <02052019404000.15624@cobra.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:40 21/05/02, Ivan Gyurdiev wrote:
>Kernel 2.5.17
>
>Should the compiler be blamed or the code?
>gcc 2.96 compiles it. 3.1 won't.
>Before people yell at me to use the recommended compiler, I would like to say
>that it really wouldn't solve the problem. Compilers move forward, the code
>has to comply. Therefore I'm excersing my right to ignore all warnings about
>my compiler and use it. If this is a bug in the compiler, I'd agree and
>switch back to 2.96. Otherwise I'd suggest the code be changed.
>Comments or advice?

I consider it a bug in the compiler. The gcc folk have not replied to my 
filed bug report yet so I have no idea if they agree or not...

The error messages the compiler is generating are completely bogus because 
the unnamed fields ARE of type struct or union. It's just that they are 
typedeffed so that the words "struct" and "union" do not appear. IMO that 
is a screwup by gcc...

Best regards,

         Anton

>In file included from attrib.h:31,
>                  from debug.h:31,
>                  from ntfs.h:40,
>                  from aops.c:29:
>layout.h:299: unnamed fields of type other than struct or union are not
>allowed
>layout.h:1450: unnamed fields of type other than struct or union are not
>allowed
>layout.h:1466: unnamed fields of type other than struct or union are not
>allowed
>layout.h:1715: unnamed fields of type other than struct or union are not
>allowed
>layout.h:1892: unnamed fields of type other than struct or union are not
>allowed
>layout.h:2052: unnamed fields of type other than struct or union are not
>allowed
>layout.h:2064: unnamed fields of type other than struct or union are not
>allowed




-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

