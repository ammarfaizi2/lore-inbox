Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267336AbUHPCTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267336AbUHPCTZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUHPCTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:19:24 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:7670 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S267336AbUHPCTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:19:05 -0400
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
References: <20040813101717.GS13377@fs.tum.de>
	<Pine.LNX.4.58.0408131231480.20635@scrub.home>
	<1092394019.12729.441.camel@uganda>
	<Pine.LNX.4.58.0408131253000.20634@scrub.home>
	<20040813110137.GY13377@fs.tum.de>
	<20040813131236.B5416@flint.arm.linux.org.uk>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Mon, 16 Aug 2004 11:18:44 +0900
In-Reply-To: <20040813131236.B5416@flint.arm.linux.org.uk> (Russell King's
 message of "Fri, 13 Aug 2004 13:12:36 +0100")
Message-ID: <buozn4vvn97.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:
> In which case, can we remove the user-visibility of CONFIG_NET and
> instead make all the protocols automatically select it.

That would kind of annoying for cases where one really does want to
disable it though.  A very nice property of the current system is that
when one disables something like _NET, it removes a vast swath of other
options (which removes a lot of clutter from the interface), and _know_
you won't inadvertently drag in _NET by enabling something.

Conversely, the requirement that _NET be enabled to select various
network-related things isn't a problem from a user-interface point of
view, as it's `obvious' that one needs a network to use them (and the
config option to turn networking on is pretty starkly obvious when all
other networking options are removed).

This latter point in particular doesn't hold for some other
relationships (e.g. I seem to recall that various feature require SCSI
somewhat counter-intuitively, as they're not inherently related to it,
but rather have an implementation dependency on the kernel SCSI
infrastructure).

-Miles
-- 
Somebody has to do something, and it's just incredibly pathetic that it
has to be us.  -- Jerry Garcia
