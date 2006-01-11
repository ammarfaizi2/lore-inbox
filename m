Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWAKO1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWAKO1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWAKO1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:27:42 -0500
Received: from picard.linux.it ([213.254.12.146]:60623 "EHLO picard.linux.it")
	by vger.kernel.org with ESMTP id S1751536AbWAKO1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:27:41 -0500
Message-ID: <15632.83.103.117.254.1136989660.squirrel@picard.linux.it>
In-Reply-To: <20060110170037.4a614245.akpm@osdl.org>
References: <20060110235554.GA3527@inferi.kami.home>
    <20060110170037.4a614245.akpm@osdl.org>
Date: Wed, 11 Jan 2006 15:27:40 +0100 (CET)
Subject: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)
From: "Mattia Dongili" <malattia@linux.it>
To: "Andrew Morton" <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linux-acpi@vger.kernel.org, "Pavel Machek" <pavel@ucw.cz>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, January 11, 2006 2:00 am, Andrew Morton said:
> Mattia Dongili <malattia@linux.it> wrote:
[...]
>> 3- This laptop experienced 2 long stalls (20~25 sec) during boot,
>>    apparently after scanning usb_storage devices and starting portmap.
>
> You mean before starting portmap?

well, _while_ starting portmap. As you can see from the traces I have
portmap sleeping in sys_poll, consider my reflexes are not that fast
so the trace might be well more than 10 secs after the /etc/init.d/portmap
was run.
Trying to stop and start it again didn't have any delay.

>>    Is it time for me to learn to git bisect? (Tomorrow morning I'll try
>>    (CET) if plain 2.6.15 also shows the same stalls).
>
> Please test the next Linus git tree (2.6.15-git7) and see if we've
> propagated it into there too.
>
> There's not much point in fiddling with -mm2.  If git7 is OK then please
> test the next -mm and if it still fails then yes, doing a bisection would
> really help.
>
> <types madly>
>
> See http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

ooooh :) really really thanks!!
I was starting to script something that just some hours later revealed to
be like stGit (well at least had the same base idea).

Anyway I'm currently using -git7 and building -mm3, -git7 is OK:
no stalls, no reiser3 oops (yet) and no ACPI misaligned pointer.

Will report on -mm3 as soon as possible

-- 
mattia
:wq!


