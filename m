Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTJDSkT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 14:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTJDSkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 14:40:19 -0400
Received: from zero.aec.at ([193.170.194.10]:4624 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262686AbTJDSkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 14:40:16 -0400
To: Tony Hoyle <tmh@nodomain.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops linux 2.4.23-pre6 on amd64
From: Andi Kleen <ak@muc.de>
Date: Sat, 04 Oct 2003 20:39:59 +0200
In-Reply-To: <CYRo.18k.9@gated-at.bofh.it> (Tony Hoyle's message of "Sat, 04
 Oct 2003 20:00:15 +0200")
Message-ID: <m3smm8q22o.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <CYRo.18k.9@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Hoyle <tmh@nodomain.org> writes:
>
> Trace; ffffffff80202fce <pci_announce_device+3e/60>

It jumped to nirvana, probably because someone passed crap 
to pci_announce_device.

My first guess would be a non matching module.  Do a make distclean
and recompile/reinstall everything.

> Trace; ffffffffa0014560 <[usbcore]hcd_data_lock+4c4c/5f5f06ec>

But the decode is useless because the module in question is not loaded.

Can you load the module whatever it is manually and then decode
the oops while it's still loaded? Or better compile in all USB
statically and see if it oopses too.

Your legacy USB problems are very likely BIOS bugs.

-Andi
