Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273832AbRI0TzK>; Thu, 27 Sep 2001 15:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273834AbRI0TzB>; Thu, 27 Sep 2001 15:55:01 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:53041 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273832AbRI0Typ>; Thu, 27 Sep 2001 15:54:45 -0400
Subject: Re: Pentium SSE prefetcht0 instruction... How do you make it work
From: Robert Love <rml@tech9.net>
To: Bulent Abali <abali@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF3A810D97.1605796C-ON85256AD4.0065EDD2@pok.ibm.com>
In-Reply-To: <OF3A810D97.1605796C-ON85256AD4.0065EDD2@pok.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.24.08.08 (Preview Release)
Date: 27 Sep 2001 15:54:24 -0400
Message-Id: <1001620509.4649.23.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-27 at 14:40, Bulent Abali wrote:
> //This should prefetch an L2 line at addr (hence L3 line prefetch)
> inline void L3_prefetch (char * addr)
> {
>      asm volatile("prefetcht1 %0" :: "m" (addr));
> }

There are prefetch instructions already in the kernel.

See include/linux/prefetch.h
and linux/include/asm-i386/processor.h

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

