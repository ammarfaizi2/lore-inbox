Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWATQ7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWATQ7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWATQ7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:59:53 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:13475 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751092AbWATQ7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:59:52 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Fri, 20 Jan 2006 17:59:02 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benoit Boissinot <bboissin@gmail.com>,
       Harald Welte <laforge@netfilter.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "David S.Miller" <davem@davemloft.net>
Subject: Re: Iptables error [Was: 2.6.16-rc1-mm2]
In-reply-to: <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
References: <20060120031555.7b6d65b7.akpm@osdl.org> 
 <20060120162317.5F70722B383@anxur.fi.muni.cz>  <20060120163619.GK4603@sunbeam.de.gnumonks.org>
 <40f323d00601200843m32e8f5cbv5733209ce82b8a13@mail.gmail.com>
Message-Id: <20060120165901.0793E22AEFA@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>On Fri, 20 Jan 2006, Benoit Boissinot wrote:
>> 
>> On x86 (32bits), i have the same i think:
>
>Interestingly, __alignof__(unsigned long long) is 8 these days, even 
>though I think historically on x86 it was 4. Is this perhaps different in 
>gcc-3 and gcc-4?
>
>Or do I just remember wrong?

$ cat c.c
#include <stdio.h>

int main()
{
	printf("%d\n", __alignof__(unsigned long long));

	return 0;
}
$ gcc --version
gcc (GCC) 4.0.2 20051125 (Red Hat 4.0.2-8)
$ gcc32 --version
gcc32 (GCC) 3.2.3 20030502 (Red Hat Linux 3.2.3-47.fc4)
$ gcc c.c -occ -Wall && ./cc
8
$ gcc32 c.c -occ -Wall && ./cc
8

If it helps...

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
