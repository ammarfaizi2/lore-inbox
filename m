Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131302AbRBARuy>; Thu, 1 Feb 2001 12:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131286AbRBARuo>; Thu, 1 Feb 2001 12:50:44 -0500
Received: from athena.intergrafix.net ([206.245.154.69]:48651 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S130492AbRBARu1>; Thu, 1 Feb 2001 12:50:27 -0500
Date: Thu, 1 Feb 2001 12:50:26 -0500 (EST)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: Bruce Harada <bruce@ask.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rlim_t and DNS?
In-Reply-To: <20010202023923.4fce856c.bruce@ask.ne.jp>
Message-ID: <Pine.LNX.4.10.10102011242380.18810-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Feb 2001, Bruce Harada wrote:

> > The C file says BSD/OS is the only OS they found not to have rlim_t.
> > Am I missing something?
> > Where can i find this in linux? I looked in all the include
> > files, including resource.h
> 
> Are you sure you looked in ALL the include files? I seem to have it as:
> 
> /usr/include/bits/resource.h:typedef __rlim_t rlim_t;
> 
> where __rlim_t is
> 
> /usr/include/bits/types.h:typedef long int __rlim_t;
> 

i have no bits directory, but those definitions are not in my resource.h
or types.h.
I know this is crude, but:
	grep rlim_t /usr/include/*.h /usr/include/*/*.h
	/usr/include/*/*/*.h /usr/include/*/*/*/*.h
returns nothing. /usr/include/linux does link to the linux source too.

Ditto on SYS_capset.
when bind can't find SYS_capset, it does do #define SYS_capset
__NR_capset
the compilation returns that __NR_capset is undeclared.
the only __NR defines i can find are in /usr/include/asm/unistd.h
and capset isn't in there.

*shrug*

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

> so you could try including those two in the appropriate places.
> 
> > For now i jsut typedefed it as a long.
> > 
> > Also, it's looking for a setting for SYS_capset to pass to syscall()
> > and can't that either. Again, I looked in the include files without
> > success.
> 
> I have this:
> 
> /usr/include/bits/syscall.h:#define SYS_capset __NR_capset
> 
> Hope that helps (although l-k probably isn't the best place for this...)
> 
> --
> Bruce Harada
> bruce@ask.ne.jp
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
