Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319560AbSIMIaO>; Fri, 13 Sep 2002 04:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319561AbSIMIaO>; Fri, 13 Sep 2002 04:30:14 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:28340 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S319560AbSIMIaL>; Fri, 13 Sep 2002 04:30:11 -0400
Message-Id: <5.1.0.14.2.20020913093230.00b1db50@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 13 Sep 2002 09:35:57 +0100
To: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: NTFS errors
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020913093529.517f6d14.Gregor.Fajdiga@telemach.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:35 13/09/02, Grega Fajdiga wrote:
>Good day,
>
>I am using lk 2.4.19 + a NTFS 2.1.0 patch. Once in a while I get
>lots of these errors:
>
>Sep 10 09:24:27 mujo kernel: NTFS-fs error (device 03:01): 
>ntfs_ucstonls(): Unicode name contains characters that cannot be converted 
>to character set iso8859-1.
>Sep 12 09:39:29 mujo kernel: NTFS-fs error (device 03:01): 
>ntfs_ucstonls(): Unicode name contains characters that cannot be converted 
>to character set iso8859-1.
>Sep 13 09:19:28 mujo kernel: NTFS-fs error (device 03:01): 
>ntfs_ucstonls(): Unicode name contains characters that cannot be converted 
>to character set iso8859-1.
>Sep 13 09:20:22 mujo kernel: NTFS-fs error (device 03:01): 
>ntfs_ucstonls(): Unicode name contains characters that cannot be converted 
>to character set iso8859-1.
>
>
>Are these errors serious? How can I get rid of them?

The errors mean that there are one or more file names containing characters 
that cannot be displayed with the ISO8859-1 character set. This means that 
you cannot see that those files exist and you cannot access them.

To get rid of the messages and to display the affected file names, you need 
to use the appropriate character set (which depends on what characters are 
in the file names).

The only character set that can work with all characters is UTF8, so I 
would highly recommend to always use UTF8 and you will never see these errors.

Best regards,

         Anton


-- 
   "I haven't lost my mind... it's backed up on tape." - Peter da Silva
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

