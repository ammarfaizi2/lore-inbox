Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTH1KIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTH1KIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:08:05 -0400
Received: from mail.webmaster.com ([216.152.64.131]:36037 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S263860AbTH1J4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:56:33 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Timo Sirainen" <tss@iki.fi>, "Jamie Lokier" <jamie@shareable.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Lockless file reading
Date: Thu, 28 Aug 2003 02:56:29 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEJEFLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <1062061038.1459.240.camel@hurina>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, 2003-08-28 at 09:13, Jamie Lokier wrote:

> > Timo Sirainen wrote:
> > > I'm sure someone has figured out a way to make a checksum of
> > > data that
> > > can detect if there's even a single bit wrong, if the checksum is
> > > allowed to take as much space as the data itself. I should read more
> > > about algorithms..
> >
> > You said that MD5 wasn't strong enough, and you would like a guarantee.

> Yes. I don't really like it if my program heavily relies on something
> that can go wrong in some situations.

	Okay, this is too much. Your alternative, assuming the kernel won't
re-order writes, is clearly relying on something that can go wrong. MD5
would be orders of magnitude more reliable.

	No two data sets with the same MD5 hash are known. It will be many, many
years before anyone finds two data sets of the same size with the same MD5
hash. The odds of having two data sets just happen to have the same MD5 has
are  infinitesimal.

	If you compared the MD5 hashes of random data sets 1,000,000 times a second
for a million years, your odds of getting a single false match on any one of
those comparisons are less than one in a quadrillion.

	DS


