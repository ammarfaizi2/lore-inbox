Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277304AbRJJQau>; Wed, 10 Oct 2001 12:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277308AbRJJQal>; Wed, 10 Oct 2001 12:30:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23312 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277304AbRJJQad>; Wed, 10 Oct 2001 12:30:33 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Invalidate: busy buffer at shutdown with 2.4.11
Date: Wed, 10 Oct 2001 16:29:36 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9q1t1g$21m$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110100917460.234-100000@desktop>
X-Trace: palladium.transmeta.com 1002731433 6993 127.0.0.1 (10 Oct 2001 16:30:33 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 Oct 2001 16:30:33 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110100917460.234-100000@desktop>,
Jeffrey W. Baker <jwbaker@acm.org> wrote:
>What does this message mean in 2.4.11 at shutdown time:
>
>Invalidate: busy buffer
>
>I'm afraid it means "now your RAID is fucked."

No, it really means: raid and LVM are a bit too happy to invalidate the
underlying block devices, and the warning should be harmless.

Unless, of course, all your data has magically gone up in smoke ;)

		Linus
