Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262434AbREXW1F>; Thu, 24 May 2001 18:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262436AbREXW0z>; Thu, 24 May 2001 18:26:55 -0400
Received: from zeus.kernel.org ([209.10.41.242]:63713 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262434AbREXW0o>;
	Thu, 24 May 2001 18:26:44 -0400
Message-Id: <5.1.0.14.2.20010524232316.0518c7a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 24 May 2001 23:26:35 +0100
To: Dawson Engler <engler@csl.Stanford.EDU>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [CHECKER] null bugs in 2.4.4 and 2.4.4-ac8
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <200105242109.OAA29748@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:09 24/05/2001, Dawson Engler wrote:
[snip]
>---------------------------------------------------------
>[BUG]
>/u2/engler/mc/oses/linux/2.4.4-ac8/fs/ntfs/support.c:244:ntfs_dupuni2map: 
>ERROR:NULL:243:244: Passing unknown ptr "buf"! as arg 0 to call "memcpy"! 
>set by 'kmalloc':244 [nbytes = 1]
>                         wchar_t uni = in[i];
>                         if ((chl = nls->uni2char(uni, charbuf,
>                                                 NLS_MAX_CHARSET_SIZE)) > 0) {
>                                 /* adjust result buffer */
>                                 if (chl > 1) {
>Start --->
>                                         buf = ntfs_malloc(*out_len + chl 
> - 1);
>Error --->
>                                         memcpy(buf, result, o);
>                                         ntfs_free(result);
>                                         result = buf;
>                                         *out_len += (chl - 1);
>---------------------------------------------------------

Thanks. I was just about to submit a large patch anyway, so I will fix this 
and submit shortly.

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

