Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265004AbSKANoW>; Fri, 1 Nov 2002 08:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265015AbSKANoW>; Fri, 1 Nov 2002 08:44:22 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:48902 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265004AbSKANoV>; Fri, 1 Nov 2002 08:44:21 -0500
Date: Fri, 1 Nov 2002 14:50:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Russell King <rmk@arm.linux.org.uk>
cc: Matthew Wilcox <willy@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Where's the documentation for Kconfig?
In-Reply-To: <20021101125226.B16919@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211011439420.6949-100000@serv>
References: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.44.0210311452531.13258-100000@serv> <20021101125226.B16919@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 1 Nov 2002, Russell King wrote:

> Is there a tool to convert _a_ Config.in to a Kconfig?  lkcc doesn't
> seem to do it - it wants to do thw hole lot, which isn't very useful
> when you've got half a tree that's converted and many Config.in files
> that contain updates that aren't in Kconfig.

You could put it into arch/tmp/config.in and do 'lkcc tmp'.
But converting the whole tree is the prefered solution, because lkcc needs 
all the type information of every symbol used in the config file to do a 
good job. The easiest solution is probably to get the 2.5.44 patch from my 
page, generate a diff to your converted 2.5.44 tree and apply this patch 
to 2.5.45. If you send me a 2.5.44 patch of your tree, I can do it for 
you.

bye, Roman

