Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263842AbUFFRb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbUFFRb2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUFFRb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:31:28 -0400
Received: from tag.witbe.net ([81.88.96.48]:59586 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263842AbUFFRb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:31:26 -0400
Message-Id: <200406061731.i56HVOX28240@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Patrick J. LoPresti'" <patl@users.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
Date: Sun, 6 Jun 2004 19:31:16 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <s5g4qpo4p40.fsf@patl=users.sf.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcRL6sYHN4zTnRupRS+HFtllhASiYAAAL3/Q
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I though this was a job for mktemp and co.
> 
> Sure, if you want to create a unique filename on a local unshared
> disk.

Right.
 
> But suppose you want a unique filename on a partition which might be
> NFS-mounted with multiple concurrent writers.  Oh, and the year is
> 1997.  Still want to use mktemp?

Probably not...

> Bernstein decided to name each file:
> 
>     <time>.<PID>.<fully-qualified-domain-name>
> 
> This approach makes three assumptions.  First, that the time does not
> repeat.  Second, that the FQDN is unique.  Third, that the time
> changes (i.e., one second elapses) before a PID is reused on the local
> system.  Subject to these assumptions, this is a perfectly reliable,
> very efficient, lock-free way to create unique file names.
> 
> Can you do better?
Not sure it's the best place to run a contest...
However, I could have used something like :
<FQDN>.<time-up-to-usec>.<random-number>

But this is biased because I know I must find an answer with <PID> :-)

> Sure, Bernstein's code is an unmaintainable nightmare.  But his
> designs and implementations are usually pretty sound.  The last
> release of qmail was in 1998, and we still use it where I work.  Six
> years with zero crashes, zero dropped messages, and zero security
> holes is not a trivial track record for an MTA.

One point for him.

Paul


