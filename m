Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272660AbRHaKdZ>; Fri, 31 Aug 2001 06:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272661AbRHaKdQ>; Fri, 31 Aug 2001 06:33:16 -0400
Received: from nick.dcs.qmw.ac.uk ([138.37.88.61]:8206 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S272660AbRHaKdB>; Fri, 31 Aug 2001 06:33:01 -0400
Date: Fri, 31 Aug 2001 11:33:19 +0100 (BST)
From: <mb/ext3@dcs.qmul.ac.uk>
To: <linux-kernel@vger.kernel.org>
cc: <ext3-users@redhat.com>
Subject: Re: ext3 oops under moderate load
In-Reply-To: <Pine.LNX.4.33.0108310759460.13139-100000@nick.dcs.qmul.ac.uk>
Message-ID: <Pine.LNX.4.33.0108311131380.25530-100000@nick.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:19 +0100 mb/ext3@dcs.qmul.ac.uk wrote:

>I left my spangly new dual PIII with an ext3 partition on a Promise
>FastTrak 100TX2 being used both by a local process and knfsd for a few
>hours, and the following happened:

>[ 2.4.9-ac3 SMP (noapic) + the one patch from Zygo Blaxell to recognise
>the Promise card; now I have kupdated, kjournald and user-space processes
>trying to access the volume in question all in state 'D' ]

>kernel BUG at revoke.c:307!
[snip oops]

found this on my screen when I got into work:

Assertion failure in journal_revoke() at revoke.c:307: "!(__builtin_constant_p(BH_Revoked) ? constant_test_bit((BH_Revoked),(&bh->b_state)) : variable_test_bit((BH_Revoked),(&bh->b_state)))"

Anything else I can provide, do let me know!

