Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSIYBXc>; Tue, 24 Sep 2002 21:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbSIYBXc>; Tue, 24 Sep 2002 21:23:32 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:55234 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261874AbSIYBXb>; Tue, 24 Sep 2002 21:23:31 -0400
Date: Tue, 24 Sep 2002 22:28:23 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
cc: Adam Goldstein <Whitewlf@Whitewlf.net>, <linux-kernel@vger.kernel.org>,
       Adam Taylor <iris@servercity.com>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
In-Reply-To: <200209250259.12810.roger.larsson@skelleftea.mail.telia.com>
Message-ID: <Pine.LNX.4.44L.0209242223040.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Roger Larsson wrote:

> Have you been able to determine if it is I/O bound or CPU bound?
> Or maybe using to much CPU to do I/O?
>
> Does anyone know what virtual memory system does Mandrake uses?

If it's IO bound, it's quite possible the problem is the disk
elevator and Andrew Morton's read-latency2 patch might help
somewhat (if the system is heavy on both reads and writes).

If the system is short on RAM and/or swapping, that might be
a VM thing or just a shortage of RAM...

It would make sense to study the output of top and vmstat for
a few hours to identify exactly what the problem is, instead
of trying to fix all kinds of random things that aren't the
core problem.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

