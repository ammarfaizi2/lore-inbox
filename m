Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264170AbUESN2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUESN2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 09:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbUESN2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 09:28:47 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:42330 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264170AbUESN2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 09:28:44 -0400
In-Reply-To: <40AB5639.7060806@yahoo.com.au>
References: <Pine.LNX.4.58.0405180728510.25502@ppc970.osdl.org>	<200405190453.31844.elenstev@mesatop.com>	<1084968622.27142.5.camel@watt.suse.com> <20040519.072009.92566322.wscott@bitmover.com> <40AB5639.7060806@yahoo.com.au>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <70C69E3C-A998-11D8-A7EA-000A95CC3A8A@lanl.gov>
Content-Transfer-Encoding: 7bit
Cc: mason@suse.com, hugh@veritas.com, elenstev@mesatop.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, support@bitmover.com,
       Wayne Scott <wscott@bitmover.com>, adi@bitmover.com, akpm@osdl.org,
       wli@holomorphy.com, Andrea Arcangeli <andrea@suse.de>, lm@bitmover.com
From: Steven Cole <scole@lanl.gov>
Subject: Re: 1352 NUL bytes at the end of a page?
Date: Wed, 19 May 2004 07:28:39 -0600
To: Nick Piggin <nickpiggin@yahoo.com.au>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 19, 2004, at 6:42 AM, Nick Piggin wrote:

> Wayne Scott wrote:
>> From: Chris Mason <mason@suse.com>
>>> Good to hear.  We probably still need Andrew's truncate fix, this 
>>> just
>>> isn't the right workload to show it.  Andrew, that reiserfs fix 
>>> survived
>>> testing here, could you please include it?
>>>
>>> -chris
>> BTW. We have had one other person report a similar failure.
>> http://db.bitkeeper.com/cgi-bin/bugdb.cgi?.page=view&id=2004-05-19-001

I received a report from James H. Cloos Jr. (cc'ed to the rest of you),
but apparently, that report never made it to linux-kernel (I haven't
seen it it the archives or in my lmkl file).  His report was regarding
similar file corruption on xfs.

<OT for this thread>
I also made a report yesterday regarding a compile problem with
lib/kobject.c and no CONFIG_SYSFS.  That post also never made it
to the list. If that happens again, I'll report it to the right folks.
</OT>

>> But if sounds like this problem is now understood.  It was a pleasure
>> to watch you guys, and someone should buy Steven a beer.  Or perhaps
>> order a pizza for his family because I suspect this took some of their
>> time.
>
> Yep. Thanks for your help Steven.
>
> I don't think anyone has cleared up the performance regression
> problem yet though, so I'll have to bug you a bit more.
>
> Steven, with all else being equal, you said you found a 2.6.3 SuSE
> kernel to significantly outperform 2.6.6, is that right? If so can
> you try the same test with plain 2.6.3 please? We'll go from there.

Actually, it was a Mandrake kernel, 2.6.3-4mdk IIRC.  Whatever is
the default with MDK 10.  One salient difference with the vendor
kernel is that everything which can be a module is, and I wasn't
using any modules with my kernels.  BTW, I was careful to have the
same hdparm settings during the performance testing.

The performance difference was very repeatable.  Using the script
provided by Andy Isaacson, the 2.6.3-4mdk did the clone in about
11 minutes total, while the various current kernels took about
15 minutes total.  The user times were the same, and the difference
was in system time.  Those numbers are from memory, the actual
results should be in the archive.

>
> This one isn't urgent, because I suspect it could be something
> specific to the SuSE kernel rather than a regression in Linus' tree
> - we've heard no other complaints... so just whenever you get the
> chance.
>

I may be able to do some some performance testing here at work,
where I have a greater variety (and much faster) machines to use.

	Steven

