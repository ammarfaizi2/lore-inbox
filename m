Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130587AbRBARjp>; Thu, 1 Feb 2001 12:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131065AbRBARje>; Thu, 1 Feb 2001 12:39:34 -0500
Received: from kashiwa9-147.ppp-1.dion.ne.jp ([210.157.148.147]:31762 "EHLO
	ask.ne.jp") by vger.kernel.org with ESMTP id <S130587AbRBARjX>;
	Thu, 1 Feb 2001 12:39:23 -0500
Date: Fri, 2 Feb 2001 02:39:23 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Admin Mailing Lists <mlist@intergrafix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rlim_t and DNS?
Message-Id: <20010202023923.4fce856c.bruce@ask.ne.jp>
In-Reply-To: <Pine.LNX.4.10.10102010939230.18810-100000@athena.intergrafix.net>
In-Reply-To: <3A7130EE.E314F4A5@megapathdsl.net>
	<Pine.LNX.4.10.10102010939230.18810-100000@athena.intergrafix.net>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.6; Linux 2.2.17; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001 09:53:35 -0500 (EST)
Admin Mailing Lists <mlist@intergrafix.net> wrote:
> 
> Trying to compile bind 9.1.0 here.
> Kernel is 2.2.18, gcc 2.7.2.1.
> It failed trying to find the type for rlim_t.
> The C file says BSD/OS is the only OS they found not to have rlim_t.
> Am I missing something?
> Where can i find this in linux? I looked in all the include
> files, including resource.h

Are you sure you looked in ALL the include files? I seem to have it as:

/usr/include/bits/resource.h:typedef __rlim_t rlim_t;

where __rlim_t is

/usr/include/bits/types.h:typedef long int __rlim_t;

so you could try including those two in the appropriate places.

> For now i jsut typedefed it as a long.
> 
> Also, it's looking for a setting for SYS_capset to pass to syscall()
> and can't that either. Again, I looked in the include files without
> success.

I have this:

/usr/include/bits/syscall.h:#define SYS_capset __NR_capset

Hope that helps (although l-k probably isn't the best place for this...)

--
Bruce Harada
bruce@ask.ne.jp

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
