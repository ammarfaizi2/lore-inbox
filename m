Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313120AbSDIKGc>; Tue, 9 Apr 2002 06:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313835AbSDIKGb>; Tue, 9 Apr 2002 06:06:31 -0400
Received: from violet.setuza.cz ([194.149.118.97]:10255 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S313120AbSDIKGb>;
	Tue, 9 Apr 2002 06:06:31 -0400
Subject: Re: syscals
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020409021047.518A53ECC@sitemail.everyone.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Apr 2002 12:06:30 +0200
Message-Id: <1018346790.680.10.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-09 at 04:10, mark manning wrote:
> ok - according to unistd.h we now have exactly 256 syscalls allocated (unless im missing something).  my code needs to be able to account for every single possible syscall and so i need to be able to store the syscall number in a standard way.  not all syscalls are catered for on the outset by at any time the user can say "i need to use syscall x which takes y parameters" and the code will be able to take care of it.
> 
> the problem is that i am currently reserving only 8 bits for the syscall number.  this is ok for now but if we ever get another syscall its going to be unuseable by my existing code :) - should i be reserving 16 bits now in preperation for some new syscalls being added ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
Hmm...

dunno if you got this right. There are maximal 256 syscalls possible,
and, right -- exactly this amount of syscalls is in the entrytable. But
alotalotalot of them are defined as sys_ni_syscall (not yet
implemented).
I think there is still some space for enhancements. See
arch/i386/kernel/entry.S.

Regards
Frank


