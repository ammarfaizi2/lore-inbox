Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268417AbTCCHZT>; Mon, 3 Mar 2003 02:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268422AbTCCHZS>; Mon, 3 Mar 2003 02:25:18 -0500
Received: from [203.199.140.162] ([203.199.140.162]:25103 "EHLO
	calvin.codito.co.in") by vger.kernel.org with ESMTP
	id <S268417AbTCCHZR>; Mon, 3 Mar 2003 02:25:17 -0500
From: Amit Shah <shahamit@gmx.net>
To: Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] taskqueue to workqueue update for riscom8 driver
Date: Mon, 3 Mar 2003 13:05:22 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030302043804.A17185@parcelfarce.linux.theplanet.co.uk> <200303021751.01224.shahamit@gmx.net> <20030302163427.C7301@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030302163427.C7301@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303031305.22854.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 Mar 2003 22:04, Matthew Wilcox wrote:
> So it only compiles on UP.  Not terribly interesting.
>
> BTW, I wouldn't necessarily expect it to work.  Work queues run in
> process context; the code you replaced ran in bottom half context.
> If you're going to do this kind of lame hack, it should be converted
> to a tasklet, not a work queue.

A simple grep for cli() in drivers/char reveals that many of those drivers 
still use cli(), which means even they haven't yet been converted to the new 
framework.

As for the patch, other drivers, like cyclades, for example, too have been 
modified in the same manner.... on digging, I found that the original patch 
that converted the taskqueues to workqueues had also done it the same way.

Amit.

-- 
Amit Shah
http://amitshah.nav.to/

The most exciting phrase to hear in science, the one that heralds new
discoveries, is not "Eureka!" (I found it!) but "That's funny ..."
                -- Isaac Asimov

