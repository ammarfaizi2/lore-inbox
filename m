Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263703AbUCXOTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 09:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbUCXOTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 09:19:22 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:30716 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263703AbUCXOTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 09:19:21 -0500
Date: Wed, 24 Mar 2004 22:15:01 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Karol Kozimor" <sziwan@hell.org.pl>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Cc: ncunningham@users.sourceforge.net,
       "Dmitry Torokhov" <dtor_core@ameritech.net>,
       "Pavel Machek" <pavel@suse.cz>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Swsusp mailing list" <swsusp-devel@lists.sourceforge.net>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <200403232352.58066.dtor_core@ameritech.net> <1080104698.3014.4.camel@calvin.wpcb.org.au> <opr5cry20s4evsfm@smtp.pacific.net.th> <20040324093231.GA15061@hell.org.pl>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5ddvbra4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040324093231.GA15061@hell.org.pl>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004 10:32:31 +0100, Karol Kozimor <sziwan@hell.org.pl> wrote:

> Thus wrote Michael Frank:
>> Which reminds me of the "failed to read a chunk" message, the guys who
>> reported
>> it got all quiet after telling them to do more badblocks testing without
>> diskcaching or
>> using dd to write random data and read them back, so  likely was caused by
>> media problems.
>
> I'm not so sure, at least in my case. Sure, badblocks /dev/hda1 reports an
> access beyond end, but neither badblocks /dev/hda1 $SIZEOF_HDA1 nor SMART
> do. Anyway, the alleged bad blocks are at the end of a 400 MB partition, so
> unless swsusp allocated swap randomly, there's hardly any chance I could
> hit them with 256 MB RAM and LZF on. But then, this failure was a single
> event in my case, while others reported some regularity.
> Best regards,
>

Badblocks error reading beyond the end of the partition is irrelevant,
it is a primitive bug somewhere unrelated to media condition.

Also Badblocks without disabling drive cache is _utterly_useless_.

It will not be a bare swsusp bug, I would have hit that in 20K+ cycles
since using LZF and a thousand or so  of other 2.4 users would have
hit it too.

Please help indentify the actual problem  by running some decent  tests.

Regards
Michael
