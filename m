Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTIURDy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 13:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbTIURDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 13:03:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:51390 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262457AbTIURDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 13:03:53 -0400
Date: Sun, 21 Sep 2003 10:03:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move some more intilization out of drivers/char/mem.c
Message-Id: <20030921100306.44949fb9.rddunlap@osdl.org>
In-Reply-To: <20030921070524.GA1992@lst.de>
References: <20030920132900.GC23153@lst.de>
	<20030920160645.30c2745d.akpm@osdl.org>
	<20030921063030.GA1508@lst.de>
	<20030920234853.7e09f663.akpm@osdl.org>
	<20030921070524.GA1992@lst.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Sep 2003 09:05:24 +0200 Christoph Hellwig <hch@lst.de> wrote:

| On Sat, Sep 20, 2003 at 11:48:53PM -0700, Andrew Morton wrote:
| > Christoph Hellwig <hch@lst.de> wrote:
| > >
| > > > Please compile-test things...
| > > 
| > >  Well, I compiled this here.  I see, looks like I lost half of the patch
| > >  when sending it to you.  Sorryh for that, here's the full patch:
| > 
| > It still generates warnings.  I suggest you build kernels with a script
| > which saves up stderr and spits it all out at the end.  That way, these
| > things are noticed.
| 
| Well, I do that, but they slipped through anyway.  I did a completle
| rebuild now and saw them.  I really need a filter for all those anoying
| warnings from the debian sid assembler..

I don't know what the assembler messages are, but I often do this:

make -j4 bzImage modules > buildk.out 2>&1

bldlogstrip buildk.out > buildkk.out

where 'bldlogstrip' is:

#! /bin/sh
# strip lines that contain CC, LD, "standard input", "In function"
egrep -v "CC|LD" $1 | grep -v "standard input" | grep -v "In function"

to get down to messages to focus on.

--
~Randy
