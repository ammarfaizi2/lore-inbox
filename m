Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbSJ2BCE>; Mon, 28 Oct 2002 20:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSJ2BCE>; Mon, 28 Oct 2002 20:02:04 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:52187 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261403AbSJ2BCD>; Mon, 28 Oct 2002 20:02:03 -0500
To: <chris@scary.beasts.org>
Cc: <linux-kernel@vger.kernel.org>, <drepper@redhat.com>
Subject: Re: [PATCH][RFC] 2.5.44 (1/2): Filesystem capabilities kernel patch
References: <Pine.LNX.4.33.0210282327520.8990-100000@sphinx.mythic-beasts.com>
	<87elaanlhx.fsf@goat.bogus.local>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Tue, 29 Oct 2002 02:08:01 +0100
In-Reply-To: <87elaanlhx.fsf@goat.bogus.local> (Olaf Dietsche's message of
 "Tue, 29 Oct 2002 01:20:58 +0100")
Message-ID: <877kg2njbi.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:

> <chris@scary.beasts.org> writes:
>
>> On Mon, 28 Oct 2002, Olaf Dietsche wrote:
>>
>>> If you're careful with giving away capabilities however, this patch
>>> can make your system more secure as it is. But this isn't fully
>>> explored, so you might achieve the opposite and open new security
>>> holes.

Famous last words :-(

>>
>> Have you checked how glibc handles an executable with filesystem
>> capabilities? e.g. can an LD_PRELOAD hack subvert the privileged
>> executable?
>
> No, I didn't check. Thanks for this hint, I will look into this.

I just downloaded glibc 2.3.1 and would say you can subvert a
privileged executable with LD_PRELOAD. There's no mention of
PR_GET_DUMPABLE anywhere and __libc_enable_secure is set according to
some euid/egid tests.

Hopefully, someone more fluent in glibc issues can shed some light?
Is there a way to switch LD_PRELOAD off completely or on a needed
basis?

Regards, Olaf.
