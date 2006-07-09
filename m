Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWGIKUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWGIKUZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWGIKUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:20:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:48712 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965003AbWGIKUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:20:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VJQcgOrAEyMJPzUW5GvOteThlAS2SRPU3FF0gvgeB8QkYFc36dVXRsOHzZ6DojfUhUgdJfiyadF+Ty8Jb9X0a7W9cikZ+kfBWVRhfGmNxKK5Anp+XTpuUOucFgdDwdq5ggzjopEMVvAW/pBCP62tjSUkArRSC5HeTM58erR7vBs=
Message-ID: <44B0D86E.3060408@gmail.com>
Date: Sun, 09 Jul 2006 12:20:30 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: 2.6.18-rc1-mm1
References: <20060709021106.9310d4d1.akpm@osdl.org>
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> 
[snip]
> - When reporting bugs, please try to Cc: the relevant maintainer and mailing
>   list on any email.

make headers_install gives the following error

  INSTALL include/linux/wavefront.h
sed: can't read /usr/src/linux-mm/include/linux/wavefront.h: No such file or directory
make[3]: *** [wavefront.h] Error 2
make[2]: *** [linux] Error 2
make[1]: *** [headers_install] Error 2
make: *** [headers_install] Error 2

We don't use this file anymore.


Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-mm/Documentation/dontdiff linux-mm-clean/include/linux/Kbuild linux-mm/include/linux/Kbuild
--- linux-mm-clean/include/linux/Kbuild	2006-07-09 12:07:15.000000000 +0200
+++ linux-mm/include/linux/Kbuild	2006-07-09 12:04:46.000000000 +0200
@@ -28,7 +28,7 @@ header-y += affs_fs.h affs_hardblocks.h
 	sockios.h som.h sound.h stddef.h synclink.h telephony.h		\
 	termios.h ticable.h times.h tiocl.h tipc.h toshiba.h		\
 	ultrasound.h un.h utime.h utsname.h video_decoder.h		\
-	video_encoder.h videotext.h vt.h wavefront.h wireless.h xattr.h	\
+	video_encoder.h videotext.h vt.h wireless.h xattr.h	\
 	x25.h zorro_ids.h

 unifdef-y += acct.h adb.h adfs_fs.h agpgart.h apm_bios.h atalk.h	\
