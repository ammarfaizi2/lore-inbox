Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbUCYXo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbUCYXo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:44:26 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:62690 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S263675AbUCYXoV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:44:21 -0500
Subject: Re: swsusp with highmem, testing wanted
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040325225946.GI2179@elf.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz>
	 <1080185300.1147.62.camel@gaston> <20040325120250.GC300@elf.ucw.cz>
	 <1080254461.1195.40.camel@gaston>  <20040325225946.GI2179@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080254675.7097.16.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Fri, 26 Mar 2004 10:44:35 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-03-26 at 10:59, Pavel Machek wrote:
> > I also think we free too much memory btw (and spend too much time
> > trying to free memory). Have you looked at some of Nigel stuffs in
> > swsusp2 ? There may be good ideas to borrow... 
> 
> Yes, swsusp2 is faster. It is also 10x more code. We could probably
> stop freeing as soon as half of memory is free; OTOH if memory is
> disk cache, it might be faster to drop it than write to swap, then
> read back [swsusp2 shows its not usually the case, through].

10x more code is true, but we also need to ask, how much of that is more
functionality? How much is debugging code (that can be removed)? How
much is comments?

10x implies there's needless bloat and that the two are otherwise
equivalent. That's simply not true.

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

