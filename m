Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTDON0C (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbTDON0B 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:26:01 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:52230 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S261380AbTDONZh (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 09:25:37 -0400
Date: Tue, 15 Apr 2003 15:37:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kdevt-diff
In-Reply-To: <Pine.LNX.4.44.0304141116020.19302-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304151445150.5042-100000@serv>
References: <Pine.LNX.4.44.0304141116020.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Apr 2003, Linus Torvalds wrote:

> > Linus, if you still want to go for a single block device major, this patch 
> > is bad idea (at least in this form).
> 
> I disagree.

Ok, here is a compromise proposal. I don't care very much about the MKDEV 
macro and almost nobody else should care about it either.
My main concern with a larger dev_t is that people start to go wild and 
waste the number range with crap. So what I'd like to see is some usage 
policy, e.g. nobody should assume a certain dev_t size, so that it's still 
possible to scale it down. If the user has only a small number of devices, 
they should be addressable even with a 16 bit dev_t.

BTW there are a few more functions missing, we need a dev_to_u32() and a 
dev_to_u16(), so e.g. file systems can do something useful in mknod if 
they can't store the complete number.

bye, Roman

