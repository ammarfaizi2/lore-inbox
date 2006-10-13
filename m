Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWJMXPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWJMXPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWJMXPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:15:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34967 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750952AbWJMXPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:15:46 -0400
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13
	(CRITICAL???)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Open Source <opensource3141@yahoo.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net,
       =?ISO-8859-1?Q?WolfgangM=FCes?= <wolfgang@iksw-muees.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061013230240.84447.qmail@web58108.mail.re3.yahoo.com>
References: <20061013230240.84447.qmail@web58108.mail.re3.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Oct 2006 00:41:44 +0100
Message-Id: <1160782904.25218.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 16:02 -0700, ysgrifennodd Open Source:
> clear understanding of what is causing it.  As it stands it doesn't
> seem like even the experts know exactly where this
> delay is being caused.

strace should tell you precisely how long each syscall takes if you ask
it to trace things nicely. If you have code trying to wait for a tiny
time then HZ will bump the wait to be longer (kernel or user) but for
other cases all should be fine either way.

The other issues like priority and paging caused delays can generally be
dealt with by having the relevant service code running mlockall and real
time priority.


