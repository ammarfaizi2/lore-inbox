Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVKJQUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVKJQUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVKJQUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:20:30 -0500
Received: from mail.suse.de ([195.135.220.2]:62691 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751113AbVKJQU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:20:29 -0500
From: Andreas Schwab <schwab@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Broken __get_unaligned from <asm-generic/unaligned.h>
References: <jevez0h8ea.fsf@sykes.suse.de>
	<20051110144847.GA28700@flint.arm.linux.org.uk>
X-Yow: ..  this must be what it's like to be a COLLEGE GRADUATE!!
Date: Thu, 10 Nov 2005 17:20:27 +0100
In-Reply-To: <20051110144847.GA28700@flint.arm.linux.org.uk> (Russell King's
	message of "Thu, 10 Nov 2005 14:48:47 +0000")
Message-ID: <jer79oh3uc.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> On Thu, Nov 10, 2005 at 03:42:05PM +0100, Andreas Schwab wrote:
>> __get_unaligned can't cope with const-qualified types:
>> 
>> drivers/char/vc_screen.c: In function 'vcs_write':
>> drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'
>> drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'
>> drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'
>> drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'
>
> What if get_unaligned is used with a u64 / long long type (which it is)?

Oops, I missed that, it needs a different approach.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
