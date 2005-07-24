Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVGXTmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVGXTmC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 15:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVGXTmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 15:42:02 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:45274 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261170AbVGXTmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 15:42:00 -0400
Message-ID: <42E3EEFD.8090907@ens-lyon.org>
Date: Sun, 24 Jul 2005 21:41:49 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ciprian <cipicip@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6 speed
References: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
In-Reply-To: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24.07.2005 21:12, Ciprian a écrit :
> while((testTime-initialTime) < 30)
> {
> time(&testTime);
> test /= 10;
> test *= 10;
> test += 10;
> test -= 10;
> 
> counter ++;
> 
> }

> In windows were performed about 300 millions cycles,
> while in Linux about 10 millions. This test was run on
> Fedora 4 and Suse 9.2 as Linux machines, and Windows
> XP Pro with VS .Net 2003 on the MS side. My CPU is a
> P4 @3GHz HT 800MHz bus.

Hi,

This test gives you the price of the time function on each OS
since the 4 arithmetical operations are shorter to compute
(several cycles against tons of cycles). It appears that the time
function costs about 3 us on Linux against 0.1 us on Windows.
This function is probably very OS-dependant since it depends on
how the kernel handles timing. You can't compare anything as small
as these arithmetical operations like this.  Using rdtsc would be
much better.

Anyway, if you just want to measure the cost of arithmetic
operations, there shouldn't be any difference in the results
between Linux and Windows (with a safe timing method).

Brice
