Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRE2XeS>; Tue, 29 May 2001 19:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbRE2Xd6>; Tue, 29 May 2001 19:33:58 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52460 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262436AbRE2Xdx>;
	Tue, 29 May 2001 19:33:53 -0400
Message-ID: <3B1431D6.29A97424@mandrakesoft.com>
Date: Tue, 29 May 2001 19:33:42 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 4 security holes in 2.4.4-ac8
In-Reply-To: <200105292316.QAA00305@csl.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler wrote:
> 
> >  > (Also, are there other functions called
> >  > directly from user space that don't have the sys_* prefix?)
> >
> > Almost certainly, arch/i386/mm/fault.c:do_page_fault is one of
> > many examples.
> 
> Is there any way to automatically find these?  E.g., is any routine
> with "asmlinkage" callable from user space?

Checking the syscall table in each port is the only authoritative way
AFAIK.

And, if we start doing "magic page" type entry points, or if special
traps exist on other arches, then those would have to be
special-cased...

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
