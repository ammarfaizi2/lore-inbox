Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTEARGy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTEARGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:06:54 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:58837 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261428AbTEARGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:06:53 -0400
Date: Thu, 1 May 2003 13:15:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC][PATCH] Faster generic_fls
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305011318_MC3-1-36ED-528D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>>  BTW, has someone benchmarked BSF/BSR on x86 ? It should be
>> faster, it it's also possible that a poor microcode implements it with a one
>> bit/cycle algo, which will result in one instruction not being as fast as your
>> code.
>
> I think the original i386 did it with a one-bit-per-cycle algorithm,
> anything since should be fine. In particular, on a P4 where I just tested,
> the bsf seems to be 4 cycles over the whole input set (actually, my whole
> loop was 4 cycles per iteration, so 4 cycles is worst-case. I'm assuming
> the rest could have been done in parallell).

 
 Just for comparison, the Pentium (Classic) manual says 6-43 clocks for
bsfl and 7-72 (!) for bsrl.

------
 Chuck
