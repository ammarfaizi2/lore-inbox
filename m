Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWKCL7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWKCL7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 06:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWKCL7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 06:59:34 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:52944 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751781AbWKCL7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 06:59:33 -0500
Date: Fri, 3 Nov 2006 12:59:32 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.64.0611031248030.17174@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.64.0611031257400.17174@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <454A71EB.4000201@googlemail.com> <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
 <454AA4C5.3070106@googlemail.com> <Pine.LNX.4.61.0611030911540.13091@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0611031248030.17174@artax.karlin.mff.cuni.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Nov 2006, Mikulas Patocka wrote:

>>> This error looks fixed, now I have a new one here :)
>>> 
>>> cc -D__NOT_FROM_SPAD -D__NOT_FROM_SPAD_TREE -Wall
>>> -fdollars-in-identifiers -O2 -fomit-frame-pointer -c -o MKSPADFS.o -x c
>>> MKSPADFS.C
>>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before
>>> '_llseek'
>>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 
>>> 'fd'
>>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 
>>> 'hi'
>>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 
>>> 'lo'
>>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 
>>> 'res'
>>> MKSPADFS.C:146: error: expected declaration specifiers or '...' before 
>>> 'wh'
>>> MKSPADFS.C:146: warning: type defaults to 'int' in declaration of
>>> '_syscall5'
>> 
>> Ugh this syscall 'crap' is butt-ugly.
>
> Yes, it is.
>
>> So anyway, why do you need _llseek? Can't you just use lseek() like
>> everyone else?
>
> Because I want it to work with glibc 2.0 that I still use on one machine.

BTW. is it some interaction with symbols defined elsewhere or were 
_syscall macros dropped altogether? Which glibc symbol should I use in 
#ifdef to tell if glibc has 64-bit support?

Mikulas
