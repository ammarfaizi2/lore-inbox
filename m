Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbTF1WPM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 18:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265438AbTF1WPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 18:15:11 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:23680 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265434AbTF1WPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 18:15:04 -0400
Date: Sat, 28 Jun 2003 23:37:22 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306282237.h5SMbMEm000443@81-2-122-30.bradfords.org.uk>
To: alan@lxorguk.ukuu.org.uk, davem@redhat.com
Subject: Re: networking bugs and bugme.osdl.org
Cc: davidel@xmailserver.org, greearb@candelatech.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       mbligh@aracnet.com, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If users send their report to the wrong place, it will get lost,
> just like if their cat their report into /dev/null.  I have no reason
> to feel bad about the information getting lost.

Also, remember that we sometimes get no response when something is
fixed, which is especially true when the fix happens by itself.

E.G.

2.5.foo released

Bug reported to LKML, and nobody responds.

2.5.bar released

Bug re-reported to LKML, still nobody answers, maybe it's not a very
detailed bug report, or everybody is too busy.

2.5.baz released

No bug report.

We have so far been assuming in this discussion that 2.5.baz won't
have fixed the bug.  It's not entirely impossible that 2.5.baz _will_
have fixed the bug - maybe a subsystem was being overhauled anyway,
and it was generally known on the list that the bug existed.

By not letting bug reports expire, we'd have a lot of unclosed bugs
that were really fixed.

There is an analogy with TCP:

Compare:

SYN -->
<-- ACK
DATA -->
FIN -->

and

SYN -->
<-- ACK
DATA -->

with:

Bug report -->
Bug report -->
<-- Please test this patch
Follow up bug report -->
<-- Please test this patch
Follow up bug report -->
<-- Please test this patch
OK, thanks, it works -->
<-- Glad it worked

and

Bug report -->
Bug report -->
<-- Please test this patch
Follow up bug report -->
<-- Please test this patch
<-- Please test this patch
<-- Please test this patch

> If it's too much for them to do as I ask, it's too much for
> me to consider their report.
>
> Bug reporting, just like patch submission, is a 2 way street.

It's not even a case of effort, more that you need 2 way communication
to successfully fix a bug.  You need to know that the fix worked
initially, continues to work, and that it doesn't break anything else,
otherwise you might be adding more bugs.

John.
