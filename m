Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266093AbTLIS6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266098AbTLIS6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:58:23 -0500
Received: from zero.aec.at ([193.170.194.10]:56584 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266093AbTLIS6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:58:21 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, flame@pygmyprojects.com
Subject: Re: 2.6.0-test11, PCMCIA,, Cirrus CL  6729 bridge not working
From: Andi Kleen <ak@muc.de>
Date: Tue, 09 Dec 2003 19:58:02 +0100
In-Reply-To: <10SV2-44s-43@gated-at.bofh.it> (Linus Torvalds's message of
 "Tue, 09 Dec 2003 17:30:48 +0100")
Message-ID: <m3iskpq0n9.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <10LpW-2OQ-7@gated-at.bofh.it> <10SV2-44s-43@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
>
> It looks like you tried every single module _except_ for the i82365.
>
> Give that one a whirl. Just "modprobe i82365"

It won't work. The 6729 needs some special register settings. The chip
is similar to 82365, but not completely compatible. I have a PCI
wireless card from Samsung that needs it too (wireless chip is
connected using a 6729). David Hinds' driver supports it, but it is
some special case code in there. Adding it to the in kernel pcmcia
would require some work and it may be cleaner to do it in a separate
driver.

-Andi
