Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312944AbSCZESJ>; Mon, 25 Mar 2002 23:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312945AbSCZERu>; Mon, 25 Mar 2002 23:17:50 -0500
Received: from smtp.polyu.edu.hk ([158.132.14.103]:26897 "EHLO
	hkpa04.polyu.edu.hk") by vger.kernel.org with ESMTP
	id <S312942AbSCZERi>; Mon, 25 Mar 2002 23:17:38 -0500
Message-ID: <000701c1d47d$31daade0$ccd7fea9@winxp>
From: "Anthony Chee" <anthony.chee@polyu.edu.hk>
To: "Bart Trojanowski" <bart@jukie.net>, <linux-kernel@vger.kernel.org>
Cc: <kbuild-devel@vger.kernel.org>, <kernelnewbies@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <004501c1d34f$32bda110$0100a8c0@winxp> <20020325164535.A5144@jukie.net>
Subject: Re: undefined reference
Date: Tue, 26 Mar 2002 12:17:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or let me say clearly.

The suitution is I want the kernel source use the symbol from module.

What I did in the module code are:
1. EXPORT_SYMBOL(func) in the source code of module
2. Set "extern int func()" in the module header

What I did in the kernel source code are:
1. Insert "func()" in the inode.c
2. Add the module header in the kernel source code

Then I use "make bzImage", I got no error message on compiling inode.c, but
I got

"fs/fs.o(.text+0x1377d): undefined reference to `func'"

in the linking stage.

I also set condition inode.c to check the existing of module before calling
func()

Thanks

Regards,
Anthony

----- Original Message -----
From: "Bart Trojanowski" <bart@jukie.net>
To: "Anthony Chee" <anthony.chee@polyu.edu.hk>;
<linux-kernel@vger.kernel.org>
Cc: <kbuild-devel@vger.kernel.org>; <kernelnewbies@vger.kernel.org>;
<linux-kernel@vger.kernel.org>
Sent: Tuesday, March 26, 2002 5:45 AM
Subject: Re: undefined reference



