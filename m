Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131994AbRAWXZn>; Tue, 23 Jan 2001 18:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132001AbRAWXZd>; Tue, 23 Jan 2001 18:25:33 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:51889 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S131994AbRAWXZ1>; Tue, 23 Jan 2001 18:25:27 -0500
Message-ID: <3A6E282E.89053126@home.com>
Date: Tue, 23 Jan 2001 19:56:14 -0500
From: John Kacur <jkacur@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en, ru, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sigcontext on Linux-ppc in user space
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know how to get at the struct sigcontext in a signal handler
on Linux for powerpc? sigaction of course lets you create a signal
handler as a function with the prototype void(*)(int, siginfo_t *, void
*)
where the last argument, a pointer to void, is the sigcontext. I believe
that the last argument is NOT defined by POSIX and so is implementation
dependent.

On Intel it seems sufficient to use #include <asm/sigcontext.h>
to get the definition of struct sigcontext, and then get the values
you'd like out of the signal handler. But on Linux for powerpc, the same
thing doesn't work. Does anyone know what the trick is here to
accomplish this?

Thanks in advance
John Kacur
jkacur@home.com
jekacur@ca.ibm.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
