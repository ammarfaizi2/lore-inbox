Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318046AbSGRMnH>; Thu, 18 Jul 2002 08:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318041AbSGRMnH>; Thu, 18 Jul 2002 08:43:07 -0400
Received: from ns.suse.de ([213.95.15.193]:57358 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318046AbSGRMmf>;
	Thu, 18 Jul 2002 08:42:35 -0400
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 broken on headless boxes
References: <20020717165538.D13352@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Jul 2002 14:45:35 +0200
In-Reply-To: Matthew Wilcox's message of "17 Jul 2002 17:59:35 +0200"
Message-ID: <p73adopurv4.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> On a headless box with both CONFIG_VT_CONSOLE and CONFIG_SERIAL_CONSOLE
> defined, I get:

[...]

I also see similar problems on x86-64 in 2.5.25.  The kernel quickly crashes
when trying to return from opost_write() because something below has zeroed
out the stack (with serial console and vga console and early console enabled) 
I have not tried it with 2.5.26 yet.

-Andi
