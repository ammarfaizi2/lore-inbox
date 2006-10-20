Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992512AbWJTG3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992512AbWJTG3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 02:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992516AbWJTG3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 02:29:10 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:8685 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S2992513AbWJTG3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 02:29:07 -0400
Date: Fri, 20 Oct 2006 10:30:04 +0400
Message-Id: <200610200630.k9K6U4RU031798@vass.7ka.mipt.ru>
From: Vasily Tarasov <vtaras@openvz.org>
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
CC: Jan Kara <jack@suse.cz>
CC: Dmitry Mishin <dim@openvz.org>
CC: Vasily Averin <vvs@sw.ru>
CC: Kirill Korotaev <dev@openvz.org>
CC: OpenVZ Developers List <devel@openvz.org>
References: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru> <p73hcy0b83k.fsf@verdi.suse.de>
In-Reply-To: <p73hcy0b83k.fsf@verdi.suse.de>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Fri, 20 Oct 2006 10:28:32 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

<snip>
> Thanks. But the code should be probably common somewhere in fs/*, not
> duplicated.
<snip>

Thank you for the comment!
I'm not sure we should do it. If we move the code in fs/quota.c for example,
than this code will be compiled for _all_ arhitectures, not only for x86_64 and ia64.
Of course, we can surround this code by #ifdefs <ARCH>, but I thought this is 
a bad style... Moreover looking through current kernel code, I found out that
usually code is duplicated in such cases.

However, if you insist I'll modify the code! :)

Thank you.

