Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUCNOP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 09:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbUCNOPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 09:15:25 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:25052 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262456AbUCNOPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 09:15:18 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 14 Mar 2004 14:15:15 -0000
MIME-Version: 1.0
Subject: Re: Build problem smbfs/file.c
Message-ID: <405468F3.13851.28874B86@localhost>
In-reply-to: <Pine.LNX.4.44.0403131452150.2749-100000@cola.local>
References: <40530C9D.31619.23368E43@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > PARANOIA("%s/%s validation failed, error=%zd\n"
> > 
> > Ummm.  I removed the `z' from error=%zd\n" - it appears to be rogue, 
> > but what do I know ;)
> 
> I think someone meant to change my %d into a %Zd, like in smb_file_read.
> Or not, since my gcc's understand them both.
> 
> Compiler version?

I installed the recommended kernel GCC as per the docs:

[root@Linux233 linux-2.6.1]# gcc -v
Reading specs from /usr/local/lib/gcc-lib/i586-pc-linux-
gnu/2.95.3/specs
gcc version 2.95.3 20010315 (release)

OK, after some research it is a GCC problem - but I need to ask why 
this is now become a problem.

Googling, Andrew Morton pulled this up in the lkml found here:

http://lkml.org/lkml/2003/7/7/225

Now, I am a bit worried if the lower case version `z' is to be used, 
that it will be a bit of a problem if there are lots of files using 
it.

Also, although GCC reports this as a warning, it also seems to say "I 
don't know what this is, so am ignoring it" sort of thing?

Or am I PARANOIA...

Thanks,

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

