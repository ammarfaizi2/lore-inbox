Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130207AbRADIJk>; Thu, 4 Jan 2001 03:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130319AbRADIJa>; Thu, 4 Jan 2001 03:09:30 -0500
Received: from ns1.netbauds.net ([194.207.240.11]:20486 "EHLO ns1.netbauds.net")
	by vger.kernel.org with ESMTP id <S130207AbRADIJW>;
	Thu, 4 Jan 2001 03:09:22 -0500
Message-ID: <3A542F83.4BD3B30B@netbauds.net>
Date: Thu, 04 Jan 2001 08:08:36 +0000
From: Darryl Miles <darryl@netbauds.net>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hugang <linuxbest@sina.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Abort x86 assemble code
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hugang <linuxbest@sina.com> wrote:
>	I have following code ,and I can not understand the mark line,who can tell me.thanks.
> 00000ec7 xorl   0x400dec(,%eax,4),%ecx		????<-----------------What it to do.

extern u_int32_t eax;
extern u_int32_t ecx;

{
	u_int32_t *ptr;

	ptr = (u_int32_t *)((eax * 4) + 0x400dec);

	ecx ^= *ptr;
}


Commonly used in the above form (with a fixed displacement) to access a
32bit value within an array of 32bit values.

The array start offset would be hardwired at 0x400dec, the zero based
index into the array is provided by eax.


-- 
Darryl Miles
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
