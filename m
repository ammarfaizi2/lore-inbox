Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUEQPx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUEQPx6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUEQPx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:53:58 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:38535 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261718AbUEQPxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:53:54 -0400
In-Reply-To: <1084808421.7410.0.camel@laptop.fenrus.com>
References: <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org> <20040517.085640.30175416.wscott@bitmover.com> <20040517151738.GA4730@thunk.org> <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org> <1084808421.7410.0.camel@laptop.fenrus.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6349F004-A81A-11D8-A7EA-000A95CC3A8A@lanl.gov>
Content-Transfer-Encoding: 7bit
Cc: hugh@veritas.com, elenstev@mesatop.com, linux-kernel@vger.kernel.org,
       support@bitmover.com, Linus Torvalds <torvalds@osdl.org>,
       Wayne Scott <wscott@bitmover.com>, adi@bitmover.com, akpm@osdl.org,
       wli@holomorphy.com, lm@bitmover.com, "Theodore Ts'o" <tytso@mit.edu>
From: Steven Cole <scole@lanl.gov>
Subject: Re: 1352 NUL bytes at the end of a page?
Date: Mon, 17 May 2004 09:53:49 -0600
To: arjanv@redhat.com
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 17, 2004, at 9:40 AM, Arjan van de Ven wrote:

>
>>
>> Who came up with that braindead idea? Is it some crazed Mach developer
>> that infiltrated the glibc development
>
> afaik it's optional and off by default, for reads it sort of kinda 
> makes
> sense but it can't be on by default otherwise a truncate would cause
> fscanf() to throw a sigbus, that's not legal posix wise.
>
>

For what it's worth, here is the glibc information on a system which
has the same distribution as the system at home which hits this bug:

[steven@spc2 testing-2.6]$ /lib/libc.so.6
GNU C Library stable release version 2.3.3, by Roland McGrath et al.
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk).
Compiled on a Linux 2.6.0 system on 2004-02-16.
Available extensions:
         GNU libio by Per Bothner
         crypt add-on version 2.1 by Michael Glad and others
         linuxthreads-0.10 by Xavier Leroy
         BIND-8.2.3-T5B
         libthread_db work sponsored by Alpha Processor Inc
         NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
Thread-local storage support included.
Report bugs using the `glibcbug' script to <bugs@gnu.org>.

	Steven

------------------------------------------------------------------------
Steven Cole <scole@lanl.gov>
MacOS X 10.3.3 Panther

