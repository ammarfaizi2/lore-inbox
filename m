Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbSJ2LCn>; Tue, 29 Oct 2002 06:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbSJ2LCm>; Tue, 29 Oct 2002 06:02:42 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:4795 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261801AbSJ2LCl>; Tue, 29 Oct 2002 06:02:41 -0500
To: <chris@scary.beasts.org>
Cc: <linux-kernel@vger.kernel.org>, <drepper@redhat.com>, <agruen@suse.de>
Subject: Re: [PATCH][RFC] 2.5.44 (1/2): Filesystem capabilities kernel patch
References: <Pine.LNX.4.33.0210282327520.8990-100000@sphinx.mythic-beasts.com>
	<87elaanlhx.fsf@goat.bogus.local> <877kg2njbi.fsf@goat.bogus.local>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Tue, 29 Oct 2002 12:08:31 +0100
Message-ID: <87smypmrio.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:

> Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:
>
>> <chris@scary.beasts.org> writes:
>>
>>> On Mon, 28 Oct 2002, Olaf Dietsche wrote:
>>>
>>>> If you're careful with giving away capabilities however, this patch
>>>> can make your system more secure as it is. But this isn't fully
>>>> explored, so you might achieve the opposite and open new security
>>>> holes.
>
> Famous last words :-(
>
>>>
>>> Have you checked how glibc handles an executable with filesystem
>>> capabilities? e.g. can an LD_PRELOAD hack subvert the privileged
>>> executable?
>>
>> No, I didn't check. Thanks for this hint, I will look into this.

Executables with inheritable sets only are not affected. A regular
user may use LD_PRELOAD, but he is not able to gain additional
privileges.

> I just downloaded glibc 2.3.1 and would say you can subvert a
> privileged executable with LD_PRELOAD. There's no mention of
> PR_GET_DUMPABLE anywhere and __libc_enable_secure is set according to
> some euid/egid tests.

This means setting the executable to SGID nogroup or a similar hack
would close at least some of the security holes for now.

Regards, Olaf.
