Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWAIGOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWAIGOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWAIGOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:14:00 -0500
Received: from fmr14.intel.com ([192.55.52.68]:2690 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751118AbWAIGN5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:13:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 01:13:17 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A136E9@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git pull on Linux/ACPI release tree
Thread-Index: AcYUjkUHuM6k/ZrRQoKsmcAVWT9fQQAU6dzQ
From: "Brown, Len" <len.brown@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Martin Langhoff" <martin.langhoff@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, <linux-acpi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <git@vger.kernel.org>
X-OriginalArrivalTime: 09 Jan 2006 06:13:19.0297 (UTC) FILETIME=[C93CBB10:01C614E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>Which just means that a commit that was tested and found to be working 
>might suddenly not work any more, which can be very surprising ("But I 
>didn't change anything!").

This is why I try to follow the top of tree as closely as possible.
While parts of ACPI are well contained, other parts get stomped on constantly.
My two updates in 10 hours were not becaudse of what I did,
it was in response to seeing the flood gates in 2.6.16 open.

Also, it isn't accurate that nothing changed at my end.
I put some trivial patches into my release branch,
udpated the release branch with upstream,
and then pulled the release branch into my test branch
where there are other patches you haven't seen yet.

I pushed the release branch just to 'clear the deck' of
the trivial patches there since there was no reason to delay
them behind all the stuff still on the test branch.

>So trying out git-rebase and git-cherry-pick just in case you 
>decide to want to use them might be worthwhile. Making it part of your 
>daily routine like David has done? Somewhat questionable, but hey,
>it seems to be working for David, and it does make some things much easier, so..

In the past I have use git-cherry-pick to recover from when a "good" patch
was checked in on top of a "bad" patch, and I wanted to push
the good without the bad.

But the linearization model will not work for me in general.
Branches enable parallel lines of development in git.  If that
is thrown out, then we're basically back at quilt.

thanks,
-Len
