Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAIWEP>; Tue, 9 Jan 2001 17:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130348AbRAIWEG>; Tue, 9 Jan 2001 17:04:06 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:19729 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129436AbRAIWDw>;
	Tue, 9 Jan 2001 17:03:52 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101092203.f09M3oY327528@saturn.cs.uml.edu>
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode
To: doug@wireboard.com (Doug McNaught)
Date: Tue, 9 Jan 2001 17:03:50 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, shane@agendacomputing.com
In-Reply-To: <m37l44ert9.fsf@belphigor.mcnaught.org> from "Doug McNaught" at Jan 09, 2001 09:14:10 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug writes:
> "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

>> If you need to steal a bit, grab one that won't hurt.
>> Take the owner's read bit. (owner may read own files)
>
> Er,
>
> bash-2.03$ cd /tmp
> bash-2.03$ cat >foo
> This is a test.
> bash-2.03$ chmod u-r foo

No, you zeroed the owner's read bit. When the bit isn't
implemented it must be always set.

By "(owner may read own files)" I refer to what happens
after you steal the bit, causing it to always appear set.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
