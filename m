Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264107AbTEWRwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 13:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264111AbTEWRwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 13:52:25 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:2438 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264107AbTEWRwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 13:52:24 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 23 May 2003 11:04:45 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Boehm, Hans" <hans_boehm@hp.com>
cc: "'Arjan van de Ven'" <arjanv@redhat.com>, Hans Boehm <Hans.Boehm@hp.com>,
       "MOSBERGER, DAVID (HP-PaloAlto,unix3)" <davidm@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@linuxia64.org
Subject: RE: [Linux-ia64] Re: web page on O(1) scheduler
In-Reply-To: <75A9FEBA25015040A761C1F74975667D01442101@hplex4.hpl.hp.com>
Message-ID: <Pine.LNX.4.55.0305231102310.3634@bigblue.dev.mcafeelabs.com>
References: <75A9FEBA25015040A761C1F74975667D01442101@hplex4.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Boehm, Hans wrote:

> Sorry about the typo and misnaming for the test program.  I attached the correct version that prints the right labels.
>
> The results I posted did not use NPTL.  (Presumably OpenMP wasn't targeted at NPTL either.)  I don't think that NPTL has any bearing on the underlying issues that I mentioned, though path lengths are probably a bit shorter.  It should also handle contention substantially better, but that wasn't tested.
>
> I did rerun the test case on a 900 MHz Itanium 2 machine with a more recent Debian installation with NPTL.  I get 200msecs (20nsecs/iter) with the custom lock, and 768 for pthreads.  (With static linking that decreases to 658 for pthreads.)  Pthreads (and/or some of the other infrastructure) is clearly getting better, but I don't think the difference will disappear.

To make things more fair you should test against pthread spinlocks. Also,
for tight loops like that, even an extra call deep level (that pthread is
likely to do) is going to matter.



- Davide

