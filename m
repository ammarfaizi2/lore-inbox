Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbRLGNzN>; Fri, 7 Dec 2001 08:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281322AbRLGNzD>; Fri, 7 Dec 2001 08:55:03 -0500
Received: from ns.suse.de ([213.95.15.193]:12043 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281255AbRLGNyv>;
	Fri, 7 Dec 2001 08:54:51 -0500
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <p73r8q86lpn.fsf@amdsim2.suse.de.suse.lists.linux.kernel> <Pine.LNX.4.33.0112070710120.747-100000@mikeg.weiden.de.suse.lists.linux.kernel> <9upmqm$7p4$1@penguin.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Dec 2001 14:54:49 +0100
In-Reply-To: torvalds@transmeta.com's message of "7 Dec 2001 07:22:55 +0100"
Message-ID: <p73n10v6spi.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds) writes:
> 
> "putc()" is a standard function.  If it sucks, let's get it fixed.  And
> instead of changing bonnie, how about pinging the _real_ people who
> write sucky code?

It is easy to fix. Just do #define putc putc_unlocked
There is just a slight problem: it'll fail if your application is threaded
and wants to use the same FILE from multiple threads.

It is a common problem on all OS that eventually got threadsafe stdio. 
I bet putc sucks on Solaris too.

-Andi

