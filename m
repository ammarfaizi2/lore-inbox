Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265502AbUFCEzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUFCEzb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 00:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265503AbUFCEza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 00:55:30 -0400
Received: from main.gmane.org ([80.91.224.249]:19387 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265502AbUFCEz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 00:55:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Calvin Spealman <calvin@ironfroggy.com>
Subject: Re: Possible bug: ext3 misreporting filesystem usage
Date: Thu, 03 Jun 2004 00:49:40 +0000
Message-ID: <1707149.1mCcARGuB2@ironfroggy.com>
References: <1275157.LnyMtzroWT@ironfroggy.com> <c9l0me$cf1$1@news.cistron.nl>
Reply-To: calvin@ironfroggy.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-069-132-046-251.carolina.rr.com
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:

> In article <1275157.LnyMtzroWT@ironfroggy.com>,
> Calvin Spealman  <calvin@ironfroggy.com> wrote:
>>I've been getting a possible bug after running my system a few weeks. The
>>ext3 partition's usage is being misreported. Right now, df -h says ive got
>>no space left, but according to du /, I'm only using 17 gigs of my 40 gig
>>drive. Restarting fixes the problem, so I'm thinking it might be some
>>mis-handled variable in memory, not something on the disc itself? And,
>>yes, I do know that du is right, not df, because I keep good track of my
>>disc usage. This is pretty serious, it killed a 40+ hour process that i'll
>>have to start over again from the beginning!
> 
> There's a process holding on to a 23 GB logfile that has been
> deleted. Try "ls -l /proc/*/fd/* 2>&1 | grep deleted" . Kill the
> process and you'll have your space back.
> 
> Mike.

All that shows is a couple things from konq's http cache, nothing adding
nearly to the 23 gigs.

If i delete some files, i have more space, but then the used space steadily
increases until i have nothing left again. i am running a 2.6.6_rc1 kernel.

