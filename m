Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132850AbRDPEEM>; Mon, 16 Apr 2001 00:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132851AbRDPEEC>; Mon, 16 Apr 2001 00:04:02 -0400
Received: from quechua.inka.de ([212.227.14.2]:11812 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132850AbRDPEDs>;
	Mon, 16 Apr 2001 00:03:48 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: fsck, raid reconstruction & bad bad 2.4.3
In-Reply-To: <01041521302600.15046@tabby>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14p0Et-0001Qz-00@sites.inka.de>
Date: Mon, 16 Apr 2001 06:03:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01041521302600.15046@tabby> you wrote:
>>a) stop rebuild until fsck is fixed

> And let fsck read bad data because the raid doesn't yet recognize the correct
> one....

a degraded raid will not deliver broken data. and even if it does, one more
reason not to check a degraded raid.

> There is nothing to fix in fsck. It should NOT know about the low level
> block storage devices. If it does, then fsck for EACH filesystem will
> have to know about ALL different raid hardware/software implementations.

fsck does not neet to be changed, yoi can have a shell script loop and check
the raid state before caling the fsck.

>>b) wait with fsck until rebuild is fixed

> Depends on your definition of "fixed"

fixed as in rebuild, thats what we where tlking about, no?

. The most I can see to fix is
> reduce the amount of continued update in favor of updating those blocks
> being read (by fsck or anything else). This really ought to be a runtime
> configuration option. If it is set to 0, then no automatic repair would
> be done.

yes would be a nice feature if rebuild can be made to only to io which is
required by the kernel anyway. since fsck will reach a lot of meta data this
is a fairly good start for a slow rebuild.

Greetings
Bernd
