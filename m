Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262103AbRENOfl>; Mon, 14 May 2001 10:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262105AbRENOfb>; Mon, 14 May 2001 10:35:31 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:62944 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262103AbRENOfP>; Mon, 14 May 2001 10:35:15 -0400
Message-Id: <5.1.0.14.2.20010514153419.00a7cec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 May 2001 15:35:22 +0100
To: Linus Torwalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] 2.4.5-pre1: tiny NLS include fix
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.3.96.1010514152513.13662A-200000@libra.cus.cam.ac
 .uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:30 14/05/01, Anton Altaparmakov wrote:
>Please apply attached patch. It puts a #ifndef;#define;#endif block around
>the contents of linux/include/linux to allow for multiple #includes of

s#linux/include/linux#linux/include/linux/nls.h#

Anton

><linux/nls.h>.
>
>Best regards,
>
>         Anton
>--
>Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
>Linux NTFS maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
>ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
>
>--- linux/include/linux/nls.h.old       Mon May 14 15:20:16 2001
>+++ linux/include/linux/nls.h   Mon May 14 15:24:41 2001
>@@ -1,3 +1,6 @@
>+#ifndef _LINUX_NLS_H
>+#define _LINUX_NLS_H
>+
>  #include <linux/init.h>
>
>  /* unicode character */
>@@ -28,3 +31,6 @@
>  extern int utf8_mbstowcs(wchar_t *, const __u8 *, int);
>  extern int utf8_wctomb(__u8 *, wchar_t, int);
>  extern int utf8_wcstombs(__u8 *, const wchar_t *, int);
>+
>+#endif /* _LINUX_NLS_H */
>+

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

