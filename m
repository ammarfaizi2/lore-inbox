Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTKQETq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 23:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTKQETq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 23:19:46 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:7918 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261522AbTKQETo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 23:19:44 -0500
Message-ID: <3FB84C5A.3000705@cyberone.com.au>
Date: Mon, 17 Nov 2003 15:19:38 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: Andrew Morton <akpm@osdl.org>, Gawain Lynch <gawain@freda.homelinux.org>,
       prakashpublic@gmx.de, linux-kernel@vger.kernel.org, cat@zip.com.au
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
References: <20031116192643.GB15439@zip.com.au> <1069035604.1916.3.camel@frodo.felicity.net.au> <20031116184925.43c8b481.akpm@osdl.org> <200311162254.23043.gene.heskett@verizon.net>
In-Reply-To: <200311162254.23043.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Gene Heskett wrote:

>On Sunday 16 November 2003 21:49, Andrew Morton wrote:
>
>>Gawain Lynch <gawain@freda.homelinux.org> wrote:
>>
>>>On Mon, 2003-11-17 at 08:42, Andrew Morton wrote:
>>>
>>>>Two things to try, please:
>>>>
>>>>a) Is the problem from Linus's tree?  Try 2.6.0-test9 plus
>>>>	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2
>>>>.6.0-test9/2.6.0-test9-mm3/broken-out/linus.patch
>>>>
>>>>b) The only significant scheduler change in mm3 was
>>>>	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2
>>>>.6.0-test9/2.6.0-test9-mm3/broken-out/context-switch-accounting-f
>>>>ix.patch
>>>>
>>>>   So please try -mm3 with the above patch reverted with
>>>>
>>>>	patch -R -p1 < context-switch-accounting-fix.patch
>>>>
>>>Hi Andrew,
>>>
>>>This is also easily reproducible here with just a kernel compile.
>>>
>>>I have tried both a) and b) with b) not changing anything, but a)
>>>seems to work...  Anything more to try?
>>>
>>Your report has totally confused me.  Are you saying that the
>>jerkiness is caused by linus.patch?  Or not?  Pleas try again ;)
>>
>
>In defense of this code, I ran -mm3 with the deadline elevator for 
>about 3 days and was very happy with the interactivity.  Now I've 
>been running with the elevator=cfq for most of the day, and it also 
>seems to be pretty responsive.  The default as wasn't, at least for 
>-mm2, and I haven't tried it yet for -mm3.  Should I, and report back 
>in a day or so so that you've got reports from an otherwise identical 
>system to compare?
>

I think you might have confused Andrew a bit more ;)

To start with, you are talking about IO schedulers, while the thread
is about CPU interactivity.

The problem here looks like something that is caused by something in mm3,
not in mm2, not linus.patch, and not context-switch-accounting-fix.patch.


Off topic: it would be good if you could try the as disk scheduler in mm3.
I recall you had some problems with it earlier, but they should be fixed in
mm3. Thanks.

>
>We need a test suite for this :)
>

Subjective reports from our base of beta testers has proven to be the
best thing.


