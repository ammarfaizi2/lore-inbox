Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293598AbSCEEpo>; Mon, 4 Mar 2002 23:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293605AbSCEEpf>; Mon, 4 Mar 2002 23:45:35 -0500
Received: from [202.135.142.196] ([202.135.142.196]:58887 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293598AbSCEEpU>; Mon, 4 Mar 2002 23:45:20 -0500
Date: Tue, 5 Mar 2002 15:48:38 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: davidel@xmailserver.org, rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fast Userspace Mutexes III.
Message-Id: <20020305154838.66c82118.rusty@rustcorp.com.au>
In-Reply-To: <20020304154848.A1055@elinux01.watson.ibm.com>
In-Reply-To: <1015271393.15277.112.camel@phantasy>
	<Pine.LNX.4.44.0203041208310.1561-100000@blue1.dev.mcafeelabs.com>
	<20020304154848.A1055@elinux01.watson.ibm.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002 15:48:48 -0500
Hubertus Franke <frankeh@watson.ibm.com> wrote:

> Also, the check on PROT_SEM is missing. I tried this before and glibc filtered
> these flags out when set. But effectively, one still needs to check
> whether semaphores are allowed during the sys_futex call.

Neither arch I care about (ppc, x86) needs to do anything with PROT_SEM, so it's
OK.  glibc will have to be fixed on any architectures which require help here,
and a hook will be needed somewhere in the kernel for them.

I didn't implement it because I don't *know* which archs will need something,
and what they will need.  Hence my request for arch maintainers to step
forward (Linus said they exist, and I believe him).

Hope that clarifies this particular wart...
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
