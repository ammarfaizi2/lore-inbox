Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132830AbRDPCao>; Sun, 15 Apr 2001 22:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132837AbRDPCaf>; Sun, 15 Apr 2001 22:30:35 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:58862
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S132830AbRDPCaa>; Sun, 15 Apr 2001 22:30:30 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Bernd Eckenfels <W1012@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: fsck, raid reconstruction & bad bad 2.4.3
Date: Sun, 15 Apr 2001 21:23:27 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <E14oxbX-0000oM-00@sites.inka.de>
In-Reply-To: <E14oxbX-0000oM-00@sites.inka.de>
MIME-Version: 1.0
Message-Id: <01041521302600.15046@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Apr 2001, Bernd Eckenfels wrote:
>In article <20010415195903.1D0F7683B@mail.clouddancer.com> you wrote:
>>>(There is no config file to disable/alter this .. no work-around that I
>>>know of ..)
>
>> You can't be serious.  Go sit down and think about what's going on.
>
>Well, there are two potential solutions:
>
>a) stop rebuild until fsck is fixed

And let fsck read bad data because the raid doesn't yet recognize the correct
one....

There is nothing to fix in fsck. It should NOT know about the low level
block storage devices. If it does, then fsck for EACH filesystem will
have to know about ALL different raid hardware/software implementations.

>b) wait with fsck until rebuild is fixed

Depends on your definition of "fixed". The most I can see to fix is
reduce the amount of continued update in favor of updating those blocks
being read (by fsck or anything else). This really ought to be a runtime
configuration option. If it is set to 0, then no automatic repair would
be done.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
