Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTECGj5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 02:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbTECGj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 02:39:57 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:40644 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263264AbTECGj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 02:39:56 -0400
Date: Sat, 3 May 2003 02:52:21 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <3EB2E7B1.40006@gmx.net>
Message-ID: <Pine.LNX.4.44.0305030249280.30960-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 May 2003, Carl-Daniel Hailfinger wrote:

> Ingo Molnar wrote:
> > 
> > Furthermore, the kernel also remaps all PROT_EXEC mappings to the
> > so-called ASCII-armor area, which on x86 is the addresses 0-16MB. These
> [snipped]
> > In the above layout, the highest executable address is 0x01003fff, ie.
> > every executable address is in the ASCII-armor.
> 
> If my math is correct,
> 0x01000000 is 16 MB boundary
> 0x01003fff is outside the ASCII-armor.

the ASCII-armor, more precisely, is between addresses 0x00000000 and
0x0100ffff. Ie. 16 MB + 64K. [in the remaining 64K the \0 character is in
the second byte of the address.] So the 0x01003fff address is still inside 
the ASCII-armor.

> Another question: Last time I checked, there were some problems with
> binary only drivers (to name one, NVidia graphics) and a non-executable
> stack. Has this been resolved?

i'm not using any binary-only drivers, so i have no idea. But as long as
they use PROT_EXEC areas for code, they should be safe.

	Ingo

