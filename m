Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311424AbSDMXz2>; Sat, 13 Apr 2002 19:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311433AbSDMXz1>; Sat, 13 Apr 2002 19:55:27 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:32517 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311424AbSDMXz0>; Sat, 13 Apr 2002 19:55:26 -0400
Message-ID: <3CB8C55F.ECD143F7@zip.com.au>
Date: Sat, 13 Apr 2002 16:55:11 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: -aa VM updates for 2.5
In-Reply-To: <20020413233906.GB10807@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> Why haven't any of the -aa VM updates gone into 2.5?  Especially after Andrew
> Morton has split it up this is surprising...

I don't think there's really any point in doing that.

None of the regular VM guys are really working 2.5 at this time.

VM has a close relationship with buffers, so tinkering
with the VM while I'm busily driving a truck through the
buffer layer and setting up new writeback mechanisms
would represent some wasted effort.

We don't know yet whether 2.5 will have a reverse-mapping
VM.  If it does, then maintenance work against the current
one is wasted effort and more patching pain.

(I'd also like to investigate the option of not throttling
 page allocators by making them wait on I/O - make them
 wait on pages coming free instead).

So.  My vote would be that unless the VM is actually impeding
developers who are working on other parts of the kernel (it
is not) then just leave it as-is for the while.

-
