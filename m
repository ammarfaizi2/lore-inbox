Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTJVDqj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 23:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTJVDqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 23:46:39 -0400
Received: from mail.storm.ca ([209.87.239.66]:7080 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id S263397AbTJVDqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 23:46:38 -0400
Message-ID: <3F95FE2E.7000404@storm.ca>
Date: Wed, 22 Oct 2003 11:49:02 +0800
From: Sandy Harris <sandy@storm.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net> <bn40oa$i4q$1@gatekeeper.tmr.com> <bn46q9$1rv$1@cesium.transmeta.com> <bn4aov$jf7$1@gatekeeper.tmr.com> <bn4l5q$v73$1@cesium.transmeta.com>
In-Reply-To: <bn4l5q$v73$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> No, I mean that putting a piece of code in the kernel "so it can be
> accessed from shell scripts" is idiotic.  Make a binary of it and put
> it in the filesystem.

I posted one of those here during a previous discussion.
http://www.geocrawler.com/archives/3/35/2000/8/0/4192943/
The version I posted was first draft code, quite likely buggy,
but the general idea  was sound.

This was a while back, before the /dev/random code was
rewritten into a two-stage generator. Since my code
was to add a second stage to old /dev/random, I doubt it
is now a good idea.

If the problem is that /dev/urandom is too slow, then
we need to look at speeding it up, not adding a PRNG,
let alone one in the kernel.

Would a block cipher second stage as in Yarrow or my
example be faster than the hashing 2nd stage Ted used?
Can we use a block cipher without legal hassles? Is
there some third choice? A faster hash?

