Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275819AbRJCEKj>; Wed, 3 Oct 2001 00:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276853AbRJCEK2>; Wed, 3 Oct 2001 00:10:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36106 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275819AbRJCEKY>; Wed, 3 Oct 2001 00:10:24 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.4.11-pre2 fs/buffer.c: invalidate: busy buffer
Date: Wed, 3 Oct 2001 04:10:45 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9pe345$8ic$1@penguin.transmeta.com>
In-Reply-To: <20011002190547.A3323@cm.nu>
X-Trace: palladium.transmeta.com 1002082246 31750 127.0.0.1 (3 Oct 2001 04:10:46 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 3 Oct 2001 04:10:46 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011002190547.A3323@cm.nu>, Shane Wegner  <shane@cm.nu> wrote:
>
>I am getting the following out of fs/buffer.c immediately
>after bootup.  The kernel is 2.4.11-pre2 when the message
>was added.
>
>Oct  2 17:35:08 continuum kernel: invalidate: busy buffer
>Oct  2 17:35:08 continuum last message repeated 7 times
>
>I assume this is an error though it doesn't seem to say so. 

Well, it's an error, but it's an error in that LVM invalidates the block
devices a bit too much, and the message really tells you that the code
refused to invalidate stuff that must not be invalidated.

It's harmless, although I hope that the LVM people will become a bit
less invalidation-happy as a result of the warning (it's always happened
before, it just hasn't warned about it in earlier kernels).

		Linus
