Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbUDFLld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUDFLeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:34:24 -0400
Received: from zero.aec.at ([193.170.194.10]:17930 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263787AbUDFLdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:33:00 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: {put,get}_user() side effects
References: <1HVGV-1Wl-21@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 06 Apr 2004 13:32:50 +0200
In-Reply-To: <1HVGV-1Wl-21@gated-at.bofh.it> (Geert Uytterhoeven's message
 of "Tue, 06 Apr 2004 12:10:09 +0200")
Message-ID: <m3fzbhfijh.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On most (all?) architectures {get,put}_user() has side effects:
>
> #define put_user(x,ptr)                                                 \
>   __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))

Neither typeof not sizeof are supposed to have side effects. If your
compiler generates them that's a compiler bug.

-Andi

