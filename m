Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270507AbTGSHKO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 03:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270508AbTGSHKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 03:10:14 -0400
Received: from mta08bw.bigpond.com ([144.135.24.137]:17357 "EHLO
	mta08bw.bigpond.com") by vger.kernel.org with ESMTP id S270507AbTGSHKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 03:10:10 -0400
Date: Sat, 19 Jul 2003 17:25:32 +1000
From: Michael Still <mikal@stillhq.com>
Subject: Re: [PATCH] docbook: Added support for generating man files
In-reply-to: <20030719091919.A3236@pclin040.win.tue.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       steve@ggi-project.org
Message-id: <Pine.LNX.4.44.0307191721350.1829-100000@diskbox.stillhq.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jul 2003, Andries Brouwer wrote:

> On Sat, Jul 19, 2003 at 12:47:31PM +1000, Michael Still wrote:
>
> You do this in two steps: first construct an sgml document, then invoke
> docbook2man.

Which is what I currently do.

> So, first you have to figure out what the proper docbook markup is
> for such material. According to me it is <docinfo>...</docinfo>,
> to be placed inside <refentry> before <refmeta>.
> So you do that - example script fragments appended below.

I tried this...

> Next, the docbook2man stage. My presently installed docbook2man says
> 
> # IGNORE.
> sgml('<DOCINFO>', sub { push_output('nul'); });
> sgml('</DOCINFO>', sub { pop_output(); });
> 
> That is, it does not produce any output for a docinfo section.

...and hit this. Another option is that we could ship a tweaked version of 
docbook2man with the kernel sources, and call that copy. That could then 
turn docinfo's into comments -- this was what I was getting at with my 
previous message.

> In the meantime I do not worry too much about this missing copyright.

Okie, that's fair enough.

> By the way, you start copying at <legalnotice>, but I consider that
> the least interesting part. The fact that these docs were written
> by Alan Cox is much more interesting. In other words, it might be
> a good idea to enlarge this <docinfo> section a bit.

Cool. I like your comments. I've got people coming over for dinner 
tonight, but I'll see what I can do about whipping up a new patch.

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | Stage 1: Steal underpants
http://www.stillhq.com            | Stage 2: ????
UTC + 10                          | Stage 3: Profit

