Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130184AbRBZHBc>; Mon, 26 Feb 2001 02:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130186AbRBZHBX>; Mon, 26 Feb 2001 02:01:23 -0500
Received: from ns1.bmlv.gv.at ([193.171.152.34]:33548 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S130184AbRBZHBU>;
	Mon, 26 Feb 2001 02:01:20 -0500
Message-Id: <3.0.6.32.20010226080053.00914d80@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Mon, 26 Feb 2001 08:00:53 +0100
To: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@mail.bmlv.gv.at>
Subject: Re: some char * optimizations in kernel
In-Reply-To: <20010223222141.A563@bug.ucw.cz>
In-Reply-To: <3.0.6.32.20010222123207.009138d0@pop3.bmlv.gv.at>
 <3.0.6.32.20010222123207.009138d0@pop3.bmlv.gv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Furthermore, in the "char *"-case the pointer is stored in memory.
>
>It has to be, no matter of optimalization level. Some other module
>might access that variable. You _could_ do static const char *..., but
>it would probably not help.
I know that the pointer is NEEDED (from the compilers pov); what I don't
know is whether it has any ill side-effects to change it to a char [].
Most of this stuff is a version-string outputted at initialization time and
is not needed any more (afaik) but, as you noted, sometimes it could be
used by modules.

IIRC it doesn't matter if a symbol points to a pointer or an array - the
symbol is resolved either way.
BUT, if there is something that absolutly EXPECTS this as a pointer - is
this replaced in memory by insmod/modprobe on every occasion?


Well, just as well, I'll make a patch and post it.


>> And, btw too, where can I find a maintainer of a specific file? eg., one of
>> these cases is in init/version.c which has "Copyright (C) 1992  Theodore
>> Ts'o" - but I have to guess it's tytso@valinux.com.
>> Is there something like Documentation/maintainers?
>
>It is something like MAINTAINERS in root.
Thanks!
