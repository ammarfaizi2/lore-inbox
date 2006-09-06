Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWIFMVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWIFMVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 08:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWIFMVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 08:21:16 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:43231 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1750774AbWIFMVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 08:21:15 -0400
From: Paul Slootman <paul+nospam@wurtel.net>
Subject: Re: Linux v2.6.18-rc5
Date: Wed, 6 Sep 2006 12:21:14 +0000 (UTC)
Organization: Wurtelization
Message-ID: <edmefq$96n$1@news.cistron.nl>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <20060829083643.A3150749@wobbly.melbourne.sgi.com> <9a8748490608281630v26db3164y4f104d13a3b201b6@mail.gmail.com> <1156925667.28597.1.camel@localhost>
X-Trace: ncc1701.cistron.net 1157545274 9431 83.68.3.130 (6 Sep 2006 12:21:14 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Sandberg  <lkml@metanurb.dk> wrote:
>
>i have nyself tested xfs in -rc5 now, doing rsync over and over, and
>been unable to hit any problem, it indeed seems very hard to reproduce.

I have a box (dual opteron) that "reliably" has XFS failing every night
with kernels >= 2.6.16.  It stays up without any problems with 2.6.15.7.

I've started doing a git bisect, and it failed with some 2.6.16-rc2
version, albeit in a different way to the usual XFS failure: all disk IO
related tasks were locked up in state 'D', no kernel messages on the
console. Probably not related to the previous XFS problem, I guess.

I now need to run at least one night with the "known good" 2.6.15.7,
but I'll report any further findings.


Paul Slootman

