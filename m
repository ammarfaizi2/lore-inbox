Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTIWTSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbTIWTSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:18:09 -0400
Received: from ns.suse.de ([195.135.220.2]:20404 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263447AbTIWTQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:16:36 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       iod00d@hp.com, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org> <jehe3372th.fsf@sykes.suse.de>
	<20030923115200.1f5b44df.davem@redhat.com>
	<je4qz3724k.fsf@sykes.suse.de>
	<20030923120110.4a039808.davem@redhat.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Sometime in 1993 NANCY SINATRA will lead a BLOODLESS COUP on GUAM!!
Date: Tue, 23 Sep 2003 21:16:33 +0200
In-Reply-To: <20030923120110.4a039808.davem@redhat.com> (David S. Miller's
 message of "Tue, 23 Sep 2003 12:01:10 -0700")
Message-ID: <jer8275n8u.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Tue, 23 Sep 2003 21:09:47 +0200
> Andreas Schwab <schwab@suse.de> wrote:
>
>> The compiler is allowed to take advantage that there are no unaligned
>> accesses.  You need to use compiler extensions (like attribute packed) to
>> stop it from doing this.
>
> That's correct, and if the address is misaligned the cpu "traps"
> and the kernel fixes up the load/store access to fix it up.

Or the compiler generates code to take advantage of the fact that the
lower address bits are zero.

> That's what we're talking about here.

Of course, the kernel language is not ISO C, and never will be.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
