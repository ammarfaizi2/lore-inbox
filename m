Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVGTDmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVGTDmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 23:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGTDmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 23:42:15 -0400
Received: from smtpout.mac.com ([17.250.248.45]:53968 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261555AbVGTDls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 23:41:48 -0400
In-Reply-To: <20050714011208.22598.qmail@science.horizon.com>
References: <20050714011208.22598.qmail@science.horizon.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FD559B50-FB1E-4478-ACF4-70E4DB7A0176@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: kernel guide to space
Date: Tue, 19 Jul 2005 23:41:35 -0400
To: linux@horizon.com
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 13, 2005, at 21:12:08, linux@horizon.com wrote:
>>> I don't think there's a strict 80 column rule anymore.  It's 2005...
>
>> Think again.  There are a lot of people who use 80 column windows so
>> that we can see two code windows side-by-side.
>
> Agreed.  If you're having trouble with width, it's a sign that the  
> code
> needs to be refactored.
>
> Also, my personal rule is if that a source file exceeds 1000 lines,  
> start
> looking for a way to split it.  It can go longer (indeed, there is  
> little
> reason to split the fs/nls/nls_cp9??.c files), but
> (I will refrain from discussing drivers/scsi/advansys.c)

A simple set of code refactoring rules that I try to abide by:

1)  If a function is more than a few 25 or 40 line screens, it's likely
too big (unless a big switch statement or a list of initialization calls
or something).  If necessary, use static inline functions to factor out
repetitive behavior.

2)  If a file is more than 30-40 functions, it's likely too big, and you
should try to split it.  It's _ok_ to have 4 source files implementing
code for manipulating a single struct.

3)  If a normal line of code is more than 80 characters, one of the
following is probably true: you need to break the line up and use temps
for clarity, or your function is so big that you're tabbing over too
far.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E
W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+++) 5  
X R?
tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


