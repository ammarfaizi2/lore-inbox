Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129451AbQKJDId>; Thu, 9 Nov 2000 22:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQKJDIN>; Thu, 9 Nov 2000 22:08:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22890 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129061AbQKJDIB>; Thu, 9 Nov 2000 22:08:01 -0500
Subject: Re: [test11-pre2] rrunner.c compiler error
To: fdavis112@juno.com (Frank Davis)
Date: Fri, 10 Nov 2000 03:09:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, fdavis112@juno.com
In-Reply-To: <380442056.973824553984.JavaMail.root@web694-wra.mail.com> from "Frank Davis" at Nov 09, 2000 09:49:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13u4Yp-0001p0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> rrunner.c : In function 'rr_ioctl'
> rrunner.c:1558: label 'out' used but not defined
> make[2]: *** [rrunner.o] Error 1

My fault. Swap that 1158 line pair 

		error = -EPERM;
		goto out;

with 
		return -EPERM

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
