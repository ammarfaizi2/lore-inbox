Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVEXLUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVEXLUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 07:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVEXLTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 07:19:34 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:25021 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261537AbVEXJOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:14:55 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091453.EBF28FA17@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:14:53 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 1C84EFB6B

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:41 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261200AbVEXG0J (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:26:09 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVEXG0J

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:26:09 -0400

Received: from mail.dvmed.net ([216.237.124.58]:4813 "EHLO mail.dvmed.net")

	by vger.kernel.org with ESMTP id S261200AbVEXGZ5 (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:25:57 -0400

Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])

	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))

	id 1DaSrU-0001Og-4d; Tue, 24 May 2005 06:25:56 +0000

Message-ID: <4292C8EF.3090307@pobox.com>

Date:	Tue, 24 May 2005 02:25:51 -0400

From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5

X-Accept-Language: en-us, en

MIME-Version: 1.0

To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates

References: <4292BA66.8070806@pobox.com> <Pine.LNX.4.58.0505232253160.2307@ppc970.osdl.org>

In-Reply-To: <Pine.LNX.4.58.0505232253160.2307@ppc970.osdl.org>

Content-Type: text/plain; charset=us-ascii; format=flowed

Content-Transfer-Encoding: 7bit

X-Spam-Score: 0.0 (/)

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



Linus Torvalds wrote:
> 
> On Tue, 24 May 2005, Jeff Garzik wrote:
> 
> 
>>Please pull the 'for-linus' branch from
>>
>>rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
> 
> 
> Is this really what you meant to do? There's seven merges there, none of
> which have _any_ information about _what_ you merged, because you've mixed
> everything up in one tree, so that there's absolutely no record of the
> fact that you actually had seven different repositories that you pulled..
> 
> That sucks, Jeff.
> 
> I don't understand why you don't use different trees, like you did with
> BK. You can share the object directory with the different trees, but the
> way you work now, it all looks like mush.
> 
> Even if you don't get confused youself, you sure are confusing everybody 
> else with it..

You are getting precisely the same thing you got under BitKeeper:  pull 
from X, you get my tree, which was composed from $N repositories.  The 
tree you pull was created by my running 'bk pull' locally $N times.

Ultimately, you appear to be complaining about:

* your own git-pull-script, which doesn't record the $2 (branch) 
argument in the commit message.

* the fact that my changelog includes the merge csets that were 
present-but-invisible by my BitKeeper submissions.  i.e. I lack a 
shortlog that filters out merge csets.



> Anyway, if you really want to work this way, with one big mushed-together
> thing that has different heads that you keep track of, can you _please_ at
> least make the commit message tell what you're doing. It's not a complex 

Hey, I didn't write git-pull-script, I just use it :)


> script, and you're definitely mis-using it as things stand now by 
> switching heads around inside one repository, and not telling other people 
> about it.

Switching heads around?  It sounds like you did not pull from the branch 
I mentioned.  This is how git-pull-script pulls from a branch:

git-pull-script \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git\
  refs/heads/for-linus

	Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

