Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWDJToK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWDJToK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 15:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWDJToK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 15:44:10 -0400
Received: from khc.piap.pl ([195.187.100.11]:44040 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932126AbWDJToJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 15:44:09 -0400
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Andi Kleen" <ak@suse.de>, "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Black box flight recorder for Linux
References: <5ZjEd-4ym-37@gated-at.bofh.it> <5ZlZk-7VF-13@gated-at.bofh.it>
	<4437C335.30107@shaw.ca> <200604080917.39562.ak@suse.de>
	<Pine.LNX.4.61.0604100754340.25546@chaos.analogic.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 10 Apr 2006 21:44:06 +0200
In-Reply-To: <Pine.LNX.4.61.0604100754340.25546@chaos.analogic.com> (linux-os@analogic.com's message of "Mon, 10 Apr 2006 08:18:01 -0400")
Message-ID: <m3k69xkygp.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> Further, in a boot where the BIOS needs to initialize hardware,
> It will write all RAM before enabling NMI. This makes sure that
> the parity bit(s) are set properly. Most BIOS will attempt to
> preserve RAM on a 'warm' boot as a throw-back to the '286 days
> with their above-1MB-memory-manager paged RAM because the
> only way to get back from protected mode to 16-bit real mode
> was a hardware reset.

I think there is no distinction WRT RAM test between cold and warm
boot anymore. If the BIOS clears the RAM is, I think, determined by
the "fast POST" option in BIOS setup (it always checks the size
so some bytes will be changed anyway).

> When using a memory-manager like DOS's
> HIMEM.SYS, you might actually be rebooting the machine hundreds
> of times per second!

Yes but it uses (or, rather, used) a CMOS flag to skip POST (not only
the RAM test) and to go directly to the entry point in real mode.

IIRC (I may be wrong, that was 15+ years ago) only 286 required
KBC reset to return to real mode (did LOADALL matter?), 386s have
no such problem.


BTW I understand the idea have nothing to do with actual aircraft,
so it would be the admin rather than NTSB looking at the data(?).
-- 
Krzysztof Halasa
