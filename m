Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263806AbRFRIaa>; Mon, 18 Jun 2001 04:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263799AbRFRIaL>; Mon, 18 Jun 2001 04:30:11 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:40209 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S263793AbRFRIaE>; Mon, 18 Jun 2001 04:30:04 -0400
Date: Mon, 18 Jun 2001 14:19:06 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: Reg putname() function
In-Reply-To: <Pine.LNX.4.10.10106181403400.9461-100000@blrmail>
Message-ID: <Pine.LNX.4.10.10106181415140.9461-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can anybody please tell me what the following assembly code means:
Tne function put_unused_fd() does FD_CLR() to clear the file descriptor
allocated in case file pointer could not be got. Before returning -1 as
file descriptor it goes to put_unused_fd() which calls FD_CLR() which is
as follows;

#define __FD_CLR(fd,fdsetp) \
                __asm__ __volatile__("btrl %1,%0": \
                        "=m" (*(__kernel_fd_set *) (fdsetp)):"r" ((int)
(fd)))

This is in asm/posixtypes.h. Please decipher this for me.

Thanks in advance,
Regards,
sathish


