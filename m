Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSLMOYo>; Fri, 13 Dec 2002 09:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSLMOYo>; Fri, 13 Dec 2002 09:24:44 -0500
Received: from almso2.att.com ([192.128.166.71]:38133 "EHLO
	almso2.proxy.att.com") by vger.kernel.org with ESMTP
	id <S264686AbSLMOYn>; Fri, 13 Dec 2002 09:24:43 -0500
Message-ID: <000a01c2a2b4$551e7e70$7b4bd287@ugd.att.com>
From: "Wayne Willson" <wwillson@il05037a.bns.att.com>
To: "Rusty Russell" <rusty@rustcorp.com.au>, <akpm@zip.com.au>,
       <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>
References: <20021213035016.339092C24F@lists.samba.org>
Subject: Re: [2.5.51] Failure to mount ext3 root when ext2 compiled in
Date: Fri, 13 Dec 2002 08:31:30 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen the exact same problem.  Turning off CONFIG_EXT2_FS fixes it for
me as well.



----- Original Message -----
From: "Rusty Russell" <rusty@rustcorp.com.au>
To: <akpm@zip.com.au>; <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 12, 2002 9:48 PM
Subject: [2.5.51] Failure to mount ext3 root when ext2 compiled in


> Just noticed this (usually ext2 is compiled as a module, but was
> testing a patch with CONFIG_MODULES=n).  Reverted to plain 2.5.51, and
> it's still there:
>
> VFS: Cannot open root device "301" or 03:01
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 03:01
>
> Now, I have an ext3 root, but when CONFIG_EXT3_FS=y and
> CONFIG_EXT2_FS=y, I get this failure.  Turning off CONFIG_EXT2_FS
> "fixes" it.
>
> Hope this helps,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

