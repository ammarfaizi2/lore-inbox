Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTLJTUj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTLJTUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:20:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:35265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263895AbTLJTUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:20:37 -0500
Date: Wed, 10 Dec 2003 11:20:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: Maciej Zenczykowski <maze@cela.pl>, David Schwartz <davids@webmaster.com>,
       Jason Kingsland <Jason_Kingsland@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.10.10312101027030.3805-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.58.0312101115360.29676@home.osdl.org>
References: <Pine.LNX.4.10.10312101027030.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Dec 2003, Andre Hedrick wrote:
>
> So given RMS and company state OSL and GPL are not compatable, how does
> the two exist in the current kernel?  Earlier, iirc, there were comments
> about dual license conflicts.

They don't "co-exist".

Some parts of the kernel are dual-licensed, which basically means that the
author says "you can use this code under _either_ the GPL or the OSL".

When used in the kernel, the GPL is the one that matters. But being
dual-licensed means that the same thing may be used somewhere else under
another license (so you could use that particular instance of code under
the OSL in some _other_ project where the OSL would be ok).

This is pretty common. We have several drivers that are dual-GPL/BSD, and
there are some parts that are dual GPL/proprietary (which is just another
way of saying that the author is licensing it somewhere else under a
proprietary model - common for hardware manufacturers that write their
own driver and _also_ use it somewhere else: when in Linux, they license
it under the GPL, when somewhere else, they have some other license).

This isn't Linux-specific - you'll find the same thing in other projects.
Most well-known perhaps perl - which is dual Artistic/GPL (I think.
That's from memory).

And ghostscript was (is?) dual-licensed too (proprietary/GPL).

		Linus
