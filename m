Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTFOPst (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 11:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTFOPst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 11:48:49 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:31877 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP id S262318AbTFOPss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 11:48:48 -0400
Date: Sun, 15 Jun 2003 09:05:26 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: GFDL in the kernel tree
In-reply-to: <20030615140758.A9390@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, mochel@osdl.org, linux-kernel@vger.kernel.org
Message-id: <3EEC9946.9090308@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
References: <20030615140758.A9390@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 2.5.71 introduces two GFDL-licensed files in the kernel tree...

A "grep" in Documentation/DocBook shows me three GFDL files,
last time I grepped there were none.  So I was aware that
adding one would likely raise some issues ... evidently
a variety of people have noticed that GPL for docs/specs
isn't the best solution.


> (2) Documentation/DocBook/gadget.tmpl, one of the files, includes
>     extracted from source files licensed under GPL, making this
>     a GPL license violation.

Almost all of that is covered by a "GFDL Exception"; see the
top of <linux/usb_gadget.h>.  I can submit a patch to do the
same for one other file (usbstring.c, one function).

But there's a potential issue for kerneldoc for one particular
structure, "usb_ctrlrequest", which was merged into 2.5 from a
patch on 2/2/2002 ... I think I know who contributed that patch.
If that author isn't willing to let that text be covered by
GFDL, and for some reason I can't replace it with similar text
that is (mostly pointing to the USB spec for details), I'll pull
that bit out.  In short:  This particular issue is fixable.


> And of course there's still all those nasty issue with GFDL like
> invariant sections and cover texts that make at least the debian-devel
> list believe it's an unfree license..

Only when those sections are used.  Which none of those three
files do; all that doc is Free (GPL-compatible) by Debian terms.
(Modulo minor issues to be worked.)

- Dave



