Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVKNTzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVKNTzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVKNTzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:55:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:60299 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751269AbVKNTzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:55:39 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200511141802.45788.s0348365@sms.ed.ac.uk>
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com>
	 <1131979779.5751.17.camel@localhost.localdomain>
	 <200511141802.45788.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Nov 2005 20:27:04 +0000
Message-Id: <1132000024.16148.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-14 at 18:02 +0000, Alistair John Strachan wrote:
> > If we spent our entire lives waiting for people to fix code nothing
> > would ever happen. Removing 8K stacks is a good thing to do for many
> > reasons. The ndis wrapper people have known it is coming for a long
> > time, and if it has a lot of users I'm sure someone in that community
> > will take the time to make patches.
> 
> I honestly don't know if this is the case, but is it conceivable that no patch 
> could be written to resolve this, because the Windows drivers themselves only 
> respect Windows stack limits (which are presumably still 8K?).

Both systems are (subject to memory limits) turing complete, so it is
definitely possible 8) The kernel itself switches stacks on an IRQ with
the 4K stack so you only have to worry about switching your kernel stack
not about taking interrupts on it and confusion that may cause.

