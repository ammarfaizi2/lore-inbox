Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbTH2QNn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbTH2QNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:13:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:56197 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261363AbTH2QNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:13:40 -0400
Date: Fri, 29 Aug 2003 08:57:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test4-mm3
Message-Id: <20030829085726.452d7a3f.akpm@osdl.org>
In-Reply-To: <3F4F747E.7020601@wmich.edu>
References: <20030828235649.61074690.akpm@osdl.org>
	<3F4F747E.7020601@wmich.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman <ed.sweetman@wmich.edu> wrote:
>
> Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm3/
> > 
> > 
> > . Lots of small fixes.
> 
> 
> It seems that since test3-mm2 ...possibly mm3, my kernels just hang 
> after loading the input driver for the pc speaker.  Now directly after 
> this on test3-mm1 serio loads.
>   serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> I'm guessing this is where the later kernels are hanging.
> I checked and i dont see any serio/input patches since mm1 in test3 but 
> every mm kernel i've tried since mm3 hangs at the same point where as 
> mm1 does not.  All have the same config.  I'm using acpi as well.  This 
> is a via amd board.  I dont wanna send a general email with all kinds of 
> extra info (.config and such) unless someone is interested in the 
> problem and needs it.

The only patch I can see in there is syn-multi-btn-fix.patch in test3-mm3,
which seems unlikely.

Have you tested 2.6.0-test4?  If that also fails then I'd be suspecting the
ACPI changes; there seem to be a few new problems in that area lately.

