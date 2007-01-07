Return-Path: <linux-kernel-owner+w=401wt.eu-S964872AbXAGTNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbXAGTNq (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbXAGTNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:13:46 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:38569 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964872AbXAGTNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:13:45 -0500
Date: Sun, 7 Jan 2007 20:11:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
In-Reply-To: <20070107170656.GC21133@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0701072009430.4365@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
 <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc>
 <1168182838.14763.24.camel@shinybook.infradead.org>
 <20070107153833.GA21133@flint.arm.linux.org.uk> <1168187346.14763.70.camel@shinybook.infradead.org>
 <20070107170656.GC21133@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 7 2007 17:06, Russell King wrote:
>On Mon, Jan 08, 2007 at 12:29:05AM +0800, David Woodhouse wrote:
>
>$ git log | head -n 1000 | tail -n 200 > o
>$ file -i o
>o: text/plain; charset=us-ascii
>$ git log | head -n 1000 | tail -n 300 > o
>$ file -i o
>o: text/plain; charset=us-ascii
>$ git log | head -n 1000 | tail -n 400 > o
>$ file -i o
>o: text/plain; charset=utf-8

I am inclined to say that "file" does not count, because it tries to guess an
ambiguous mapping from bytes to character set. Even more, file should be
_unable at all_ to distinguish an iso-8859-1 from an iso-8859-2 (or worse: 15)
file. This program is soo... forget it, it's not an argument. It works well for
headerful files, but text files don't really contain one. The next best thing
would be html, with a proper <meta http-equiv=Content> tag.


	-`J'
-- 
