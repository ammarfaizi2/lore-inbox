Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293544AbSCXQQP>; Sun, 24 Mar 2002 11:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293705AbSCXQQF>; Sun, 24 Mar 2002 11:16:05 -0500
Received: from smtp.polyu.edu.hk ([158.132.14.103]:26629 "EHLO
	hkpa04.polyu.edu.hk") by vger.kernel.org with ESMTP
	id <S293544AbSCXQP6>; Sun, 24 Mar 2002 11:15:58 -0500
Message-ID: <004501c1d34f$32bda110$0100a8c0@winxp>
From: "Anthony Chee" <anthony.chee@polyu.edu.hk>
To: <kbuild-devel@vger.kernel.org>, <kernelnewbies@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: undefined reference
Date: Mon, 25 Mar 2002 00:16:04 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The case is quite complicated.

I am now developing a module. This module need communicate with the kernel.
So I exported a function func(), by using EXPORT_SYMBOL(func). In the header
file, I set "extern int func()".

I also modified the kernel source code, which is inode.c, and insert the
func() and the module header file.

After the above procedure, I use "make bzImage" to build the kernel. At the
compile stage, it does not appear warning message, but it appears in the
linking object stage, which is

fs/fs.o(.text+0x1377d): undefined reference to `func'

How can I solve this issue? Or any parameter for "ld" to avoid checking the
undefined reference?
Thanks.

