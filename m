Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268004AbTBWKhb>; Sun, 23 Feb 2003 05:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268024AbTBWKhb>; Sun, 23 Feb 2003 05:37:31 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13318 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S268004AbTBWKha>; Sun, 23 Feb 2003 05:37:30 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302231047.h1NAlqNZ000894@81-2-122-30.bradfords.org.uk>
Subject: Re: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (6/21) FS & partiton
To: hch@infradead.org (Christoph Hellwig)
Date: Sun, 23 Feb 2003 10:47:52 +0000 (GMT)
Cc: tomita@cinet.co.jp, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20030223102937.A15963@infradead.org> from "Christoph Hellwig" at Feb 23, 2003 10:29:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -	if (FAT_FIRST_ENT(sb, media) != first) {
> > +	if (FAT_FIRST_ENT(sb, media) != first
> > +	    && (!pc98 || media != 0xf8 || (first & 0xff) != 0xfe))
> > +	{
> 
> I think this should be made unconditionally.  There's no reason why
> non-pc98 linux machines shouldn't read fat filesystems created on pc98.

How does the pc98 store filenames containing kana and kanji?  Maybe
this is a complete non-issue, but it occurred to me, so I thought I'd
mention it.

John.
