Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269644AbRHIAXL>; Wed, 8 Aug 2001 20:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269645AbRHIAXC>; Wed, 8 Aug 2001 20:23:02 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:20232 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S269644AbRHIAWx>;
	Wed, 8 Aug 2001 20:22:53 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: summary Re: encrypted swap
Date: 9 Aug 2001 00:19:51 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9kskv7$5us$1@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.LNX.4.33.0108071957170.3450-100000@dlang.diginsite.com> <3B70E4C8.2020400@blue-labs.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 997316391 6108 128.32.45.153 (9 Aug 2001 00:19:51 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 9 Aug 2001 00:19:51 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford  wrote:
>You can't guarantee much if the machine is physically compromised.

You're missing the point.  The point is not about crypto keys currently
in memory.  The point is about crypto keys that were in memory five reboots
ago.  If you use unencrypted swap, those keys might have been swapped out
and might still be laying around in swap somewhere even after five reboots.
Therefore, with unencrypted swap, compromise of a machine can compromise
crypto keys (and other sensitive data) going back a long way.

In contrast, if you use encrypted swap, compromise of your machine can
only compromise crypto keys (and other sensitive data) going back to your
last reboot.  That's a big difference: encrypted swap cuts down the impact
of a penetration or other compromise of your machine.  *This* is one of
the really compelling security motivations for encrypted swap.
