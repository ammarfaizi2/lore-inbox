Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262955AbVDHVLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbVDHVLT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 17:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbVDHVLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 17:11:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:16806 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262955AbVDHVLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 17:11:15 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Airlie <airlied@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL
 accesses
References: <1110519743.5810.13.camel@gaston>
	<1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	<1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	<1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	<21d7e9970504071422349426eb@mail.gmail.com>
	<1112914795.9568.320.camel@gaston> <jemzsa6sxg.fsf@sykes.suse.de>
	<1112923186.9567.349.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
X-Yow: If I pull this SWITCH I'll be RITA HAYWORTH!!  Or a SCIENTOLOGIST!
Date: Fri, 08 Apr 2005 23:11:12 +0200
In-Reply-To: <1112923186.9567.349.camel@gaston> (Benjamin Herrenschmidt's
 message of "Fri, 08 Apr 2005 11:19:46 +1000")
Message-ID: <jezmw9ug7j.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2005-04-08 at 01:58 +0200, Andreas Schwab wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> 
>> > Yes, that's very extreme, I suspect somebody is banging on set_par or
>> > something like that.
>> 
>> fb_setcolreg is it.
>
> Ok, what about that patch:
>
> ---
>
> This patch adds to the fbdev interface a set_cmap callback that allow
> the driver to "batch" palette changes. This is useful for drivers like
> radeonfb which might require lenghtly workarounds on palette accesses,
> thus allowing to factor out those workarounds efficiently.

This makes it better. But there is still a delay of half a second, and
there is an annoying flicker when switching from X to the console.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
