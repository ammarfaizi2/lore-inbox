Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbTK0HaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 02:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbTK0HaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 02:30:05 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:8116 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264441AbTK0HaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 02:30:00 -0500
Message-ID: <3FC5A7F0.8080507@cyberone.com.au>
Date: Thu, 27 Nov 2003 18:29:52 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Robert White <rwhite@casabyte.com>
CC: "'Jesse Pollard'" <jesse@cats-chateau.net>,
       "'Florian Weimer'" <fw@deneb.enyo.de>, Valdis.Kletnieks@vt.edu,
       "'Daniel Gryniewicz'" <dang@fprintf.net>,
       "'linux-kernel mailing list'" <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAilRHd97CfESTROe2OYd1HQEAAAAA@casabyte.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAilRHd97CfESTROe2OYd1HQEAAAAA@casabyte.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert White wrote:

>(Among the other N objections, add things like the lack of any sort of
>control or option parameters)
>...
>N += 1: Sparse Copying (e.g. seeking past blocks of zeros)
>N += 1: Unlink or overwrite or what?
>N += 1: In-Kernel locking and resolution for pages that are mandatory
>lock(ed)
>N += 1: No fine-grained control for concurrency issues (multiple writers)
>
>Start with doing a cp --help and move on from there for an unbounded list of
>issues that sys_copy(int fd1, int fd2) does not even come close to
>addressing.
>
>

To be fair, sys_copy is never intended to replace cp or try to be
very smart. I don't think it is semantically supposed to do much more
than replace a read, write loop (of course, the syscall also has an
offset and count).

sparse copying would be implementation dependant. If cp wanted to do
something special it would not use one big copy call. I think unlink
/ overwrite is irrelevant if its semantically a read write loop.


