Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267411AbSKPXvX>; Sat, 16 Nov 2002 18:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbSKPXvX>; Sat, 16 Nov 2002 18:51:23 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:16403 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S267411AbSKPXvW>; Sat, 16 Nov 2002 18:51:22 -0500
Message-ID: <20021116235725.10323.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: linux-kernel@vger.kernel.org
Cc: mnalis-umsdos@voyager.hr, smatch-kbugs@lists.sf.net
Date: Sat, 16 Nov 2002 18:57:25 -0500
Subject: declaring large variables
X-Originating-Ip: 67.112.121.27
X-Originating-Server: ws3-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a program (smatch.sf.net) that checks for certain types of kernel coding errors.  I'm working on one that checks for functions that possibly put too much data on the 8kB local variable stack.  The function UMSDOS_ioctl_dir puts less than 2kB of data so it's probably not a problem.  Especially since it doesn't do that for all code paths.  

What should be the upper limit for how much data a function can put on the stack.

linux-2.5.44/fs/umsdos/ioctl.c 439 UMSDOS_ioctl_dir (14432 bits)

Line            Variable                                 Size
79         struct umsdos_ioctl data;                    (4736 bits) 
177                         struct umsdos_dirent entry; (2048 bits)
178                         struct umsdos_info info;    (2304 bits)
250                 struct umsdos_info info;            (2304 bits)
305                 struct umsdos_info info;            (2304 bits)

Regards,
dan carpenter

-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Single & ready to mingle? lavalife.com:  Where singles click. Free to Search!
http://www.lavalife.com/wp.epl?a=2716

