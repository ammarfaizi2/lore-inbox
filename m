Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbUBZQuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbUBZQuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:50:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4737 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262840AbUBZQs0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:48:26 -0500
Date: Thu, 26 Feb 2004 11:50:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Willy Tarreau <willy@w.ods.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.4] /proc/kcore is a random generator ?
In-Reply-To: <20040226161637.GA4201@alpha.home.local>
Message-ID: <Pine.LNX.4.53.0402261148080.3152@chaos>
References: <200402181337.i1IDbsXU010467@hera.kernel.org>
 <20040226161637.GA4201@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Willy Tarreau wrote:

> Hi all,
>
> I'm encountering a rather strange behaviour here with 2.4.25 on a P4 HT,
> even when I boot it with "nosmp" :
>   - du /proc/kcore says '525255' (I have 512 MB RAM)
>   - if I do it again many several times, sometimes it says '0'
>   - after a moment (or several tests, I don't know), it stabilizes to some
>     value (either 0 or 525255).
>   - then, just starting vmstat, or logging into the system is enough to
>     make it switch to the other value.
>
> At first, I had the feeling that it displayed '0' when I have an even number
> of processes, and 525255 when I have an odd number, but it's not even the case.
> Once it doesn't move by itself, a few fork/exec are enough to switch the value.
>
> If I boot in HT mode, sometimes I can reliably make it display 0 and 525255
> alternatively, just as if the pid parity or CPU number was involved in the
> result.
>
> Update: same results with 2.4.26-pre1. du from coreutils 4.5.4 and 5.0.
>
> This is amazing. Did anyone notice this ? A friend just told me that plain
> 2.4.22 on his notebook does the same !
>
> Regards,
> Willy
>

Well with 'older' utilities on 2.4.24, I always get '0' with `du`!

Script started on Thu Feb 26 11:48:23 2004
# du /proc/kcore
0	/proc/kcore
# ls -la /proc/kcore
-r--------   1 root     root     335536128 Feb 26 11:48 /proc/kcore
# exit
exit
Script done on Thu Feb 26 11:48:43 2004

Probably moon-phase.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


