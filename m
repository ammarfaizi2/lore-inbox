Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTBKSjd>; Tue, 11 Feb 2003 13:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbTBKSjd>; Tue, 11 Feb 2003 13:39:33 -0500
Received: from dsl027-161-083.atl1.dsl.speakeasy.net ([216.27.161.83]:27141
	"EHLO hoist") by vger.kernel.org with ESMTP id <S261594AbTBKSjc>;
	Tue, 11 Feb 2003 13:39:32 -0500
Date: Tue, 11 Feb 2003 13:37:07 -0500
To: linux-kernel@vger.kernel.org
Subject: checksumming with mmx, comment in arch/i386/lib/mmx.c
Message-ID: <20030211183707.GA23376@suburbanjihad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: dank@suburbanjihad.net (nick black)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i want to speed up my product's checksum verification code, and was
pondering the use of mmx (ip_fast_csum as implemented by cwik and
gulbrandsen from asm-i386/checksum.h is fast enough for my needs, but i
don't want to violate the gpl 8) ).

i'm refreshing myself on mmx currently, but noticed the following
comment from arch/i386/lib/mmx.c's _mmx_memcpy:

"Checksums are not a win with MMX on any CPU tested so far for any MMX
solution figured."

firstly, to what domain of checksums does this comment apply?  secondly,
why is it true?  it seems the PADDW family of instructions could work
well here; is the slowdown a result of the kernel's need to muck with
fpu state (from what i can tell, mmx uses the fp registers)?

thanks so much for any help!

-- 
nick black <dank@reflexsecurity.com>
