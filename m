Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVHKOkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVHKOkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVHKOkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:40:32 -0400
Received: from pop.gmx.net ([213.165.64.20]:60129 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751064AbVHKOkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:40:31 -0400
Date: Thu, 11 Aug 2005 16:40:30 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: peterc@gelato.unsw.edu.au, linux-kernel@vger.kernel.org,
       sfr@canb.auug.org.au, matthew@wil.cx, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <1123769192.8251.75.camel@lade.trondhjem.org>
Subject: =?ISO-8859-1?Q?Re:_fcntl(F_GETLEASE)_semantics=3F=3F?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <23689.1123771230@www9.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond,

> to den 11.08.2005 Klokka 15:22 (+0200) skreiv Michael Kerrisk:
> 
> > As noted already, I don't know much of CIFS and SAMBA.
> > But are you saying that it is sensible and consistent that
> > "a process can open a file read-write, and can't place a 
> > read lease, but can place a write lease"?  
> 
> It is just as "sensible and consistent" as being able to open the file
> read-write and being able to place a read lease but not a write lease.
> What is your point?

I think my metapoint really is this: there has never been a 
clearly documented statement of how File Leases are supposed 
to behave on Linux.  There is just some code... how is one 
supposed to know what it _should_ do?  (The manual page text 
was my attempt to discover the details, after the fact.)

Can you provide an explanation of how file leases should 
behave?  That is, a tabulation of the expected behavious 
for the possible cimbinations of

[lease type] X 
[open() access-mode employed file placing lease] X
[open() access-mode employed by other process(es)]

?

> Make no mistake: this is not a locking protocol. It is implementing
> support for a _caching_ protocol.

Yes, that I knew.

Cheers,

Michael

-- 
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse für Mail, Message, More +++
