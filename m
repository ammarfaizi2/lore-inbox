Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279824AbRKFRIL>; Tue, 6 Nov 2001 12:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279788AbRKFRIC>; Tue, 6 Nov 2001 12:08:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14857 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279824AbRKFRHz>; Tue, 6 Nov 2001 12:07:55 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Using %cr2 to reference "current"
Date: Tue, 6 Nov 2001 17:04:24 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9s956o$24b$1@penguin.transmeta.com>
In-Reply-To: <9s82rl$k51$1@cesium.transmeta.com> <E1613vx-00005r-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 1005066444 31922 127.0.0.1 (6 Nov 2001 17:07:24 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Nov 2001 17:07:24 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E1613vx-00005r-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>It may be. Likewise its not clear if %cr2 should hold current or a cpu ident
>pointer (so you dont reload on switch of task). This needs more
>benchmarking. Its in current -ac to verify the theory is correct not the
>tuning.

We pretty much know the _theory_ is not correct, just by virtue of
depending on non-architected behaviour.  The only thing -ac can do is
test whether it works in practice.  Which is a totally different thing. 

Especially on x86 chips.

		Linus
