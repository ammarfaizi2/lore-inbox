Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131135AbRAIOO0>; Tue, 9 Jan 2001 09:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131156AbRAIOOQ>; Tue, 9 Jan 2001 09:14:16 -0500
Received: from [216.151.155.116] ([216.151.155.116]:16659 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S131135AbRAIOON>; Tue, 9 Jan 2001 09:14:13 -0500
To: linux-kernel@vger.kernel.org
Cc: shane@agendacomputing.com
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode
In-Reply-To: <200101091116.f09BGN7281436@saturn.cs.uml.edu>
From: Doug McNaught <doug@wireboard.com>
Date: 09 Jan 2001 09:14:10 -0500
In-Reply-To: "Albert D. Cahalan"'s message of "Tue, 9 Jan 2001 06:16:23 -0500 (EST)"
Message-ID: <m37l44ert9.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> Shane Nay writes:
> 
> > but the bits are useless in the "normal interpretation" of it,
> ...
> > But then you pull out the write bits,
> 
> If you need to steal a bit, grab one that won't hurt.
> Take the owner's read bit. (owner may read own files)

Er,

bash-2.03$ cd /tmp
bash-2.03$ cat >foo
This is a test.
bash-2.03$ chmod u-r foo
bash-2.03$ cat foo
cat: foo: Permission denied
bash-2.03$ ls -l foo
--w-r--r--    1 doug     doug           16 Jan  9 09:16 foo
bash-2.03$ 

This is Linux 2.4.0.

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
