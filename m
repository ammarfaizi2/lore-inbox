Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261775AbREPDHZ>; Tue, 15 May 2001 23:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261776AbREPDHP>; Tue, 15 May 2001 23:07:15 -0400
Received: from smtp.mountain.net ([198.77.1.35]:47111 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S261775AbREPDG6>;
	Tue, 15 May 2001 23:06:58 -0400
Message-ID: <3B01EE71.A4162981@mountain.net>
Date: Tue, 15 May 2001 23:05:21 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: English/United, States, en-US, English/United, Kingdom, en-GB, English, en, French, fr, Spanish, es, Italian, it, German, de, , ru
MIME-Version: 1.0
To: mirabilos <eccesys@topmail.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: rwsem, gcc3 again
In-Reply-To: <20010515125759.19134A5ABC2@www.topmail.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mirabilos wrote:
> 
> Hi,
> I have got that patch with "movl %2,%%edx" and removing the tmp
> and still cannot compile with the same error message I posted yesterday.
> The problem seems to be that, with or without "inline", it seems to
> put a reference into main.o of arch/i386/boot/compressed.
> So I cannot test -ac9 :(
> 
> If anyone could find a (final or at least until gcc is fixed temporarily)
> solution please please could either post or mail me?
> Please no Cc: as I am on the list.
> 
> -mirabilos
> --

Hi,

Petr Vandrovic's patch works for me.
$ cat /proc/version
Linux version 2.4.5-pre1 (tleete@mercury) (gcc version 3.0 20010423
(prerelease)) #6 Tue May 15 07:13:10 EDT 2001
You don't mention the constraint changes, did you apply them too?

I posted a simpler patch which miscompiled on gcc3 and 2.95.3. Still trying
to understand why, it was Obviously Correct. It was also the cause of my
boot hangs.

Cheers,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
