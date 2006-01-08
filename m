Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbWAHHrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbWAHHrm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 02:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbWAHHrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 02:47:42 -0500
Received: from fmr15.intel.com ([192.55.52.69]:18820 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030491AbWAHHrk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 02:47:40 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 02:47:30 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git pull on Linux/ACPI release tree
Thread-Index: AcYTt3od2y3F+1eER6SV8QyC6bgpNQAZPKLQ
From: "Brown, Len" <len.brown@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>, <git@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2006 07:47:32.0861 (UTC) FILETIME=[C89C62D0:01C61427]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

adding git@vger.kernel.org...

>> please pull this batch of trivial patches from: 
>> 
>> 
>git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
>
>Len,
>
>I _really_ wish you wouldn't have those automatic merges.
>
>Why do you do them? They add nothing but ugly and unnecessary 
>history, and in this pull, I think almost exactly half of the
>commits were just these empty merges.

Is it possible for it git, like bk, to simply ignore merge commits in its summary output?

Note that "Auto-update from upstream" is just the place-holder comment
embedded in the wrapper script in git/Documentation/howto/using-topic-branches.txt
All instances of it here are from me manually updating --
the only "auto" happening here is the automatic insertion of that comment:-)

I think that Tony's howto above captures two key requirements
from all kernel maintainers -- which the exception of you --
who hang out  in the middle of the process rather than
at the top of the tree.

1. It is important that we be able (and encouraged, not discouraged)
to track the top of tree as closely as we have time to handle.
Divergence and conflicts are best handled as soon as they are noticed
and can be a huge pain if left to fester and discovered
only when it is time to push patches upstream.
Plus, tracking the top of tree means we force more folks to
track the top of tree, and so it gets more testing.  This is goodness.

Earlier in your release cycle when changes are appearing faster,
my need/desire to sync is greater than later in the cycle when changes
are smaller and infrequent.  On average, I think that one sync/day
from upstream is an entirely reasonable frequency.

2. It is also important that we be able to cherry pick individual patches
in our trees so that they don't block each other from going upstream.
Tony's using-topic-branches.txt above is the best way I know of doing that.
I think it is a big improvement over the bk model since I can have a simple
branch for each patch or group of patches rather than an entire repository
dedicatd to each.  But for this to work, I need to be able to update
any and all of the topic branches from upstream, and to merge them with
each other -- just like I could with BK.  Otherwise they become "dated"
in the time they were first integrated, and it is not convenient to do
simple apples/apples comparisons that are needed to debug and test.

I'm probably a naïve git user -- but I expect I have a lot of company.
If there is a better way of using the tool to get the job done,
I'm certainly a willing customer with open ears.

thanks,
-Len
