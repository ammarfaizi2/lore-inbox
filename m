Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTL1Utb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 15:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTL1Uta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 15:49:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:59847 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262052AbTL1Uta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 15:49:30 -0500
Date: Sun, 28 Dec 2003 12:49:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
In-Reply-To: <20031228182545.B20278@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0312281248190.11299@home.osdl.org>
References: <20031005171055.A21478@flint.arm.linux.org.uk>
 <20031228174622.A20278@flint.arm.linux.org.uk> <20031228182545.B20278@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Dec 2003, Russell King wrote:
> 
> Would it be possible to switch LDT/GDT to whatever the APM BIOS expects
> just before calling the APM BIOS to suspend/hibernate, and restore them
> to whatever Linux requires after the APM BIOS returns from resume?

Possible, yes. But it would help a lot to know what's wrong with the 
current segments - we did leave most of them with exactly the same layout 
as before, and I thought we explicitly left the ones that APM cares about 
that way..

		Linus
