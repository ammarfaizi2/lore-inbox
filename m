Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314408AbSDRSgt>; Thu, 18 Apr 2002 14:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314409AbSDRSgs>; Thu, 18 Apr 2002 14:36:48 -0400
Received: from science.horizon.com ([192.35.100.1]:1089 "HELO
	science.horizon.com") by vger.kernel.org with SMTP
	id <S314408AbSDRSgr>; Thu, 18 Apr 2002 14:36:47 -0400
Date: 18 Apr 2002 18:36:39 -0000
Message-ID: <20020418183639.20946.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: SSE related security hole
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Um, people here seem to be assuming that, in the absence of MMX,
fninit *doesn't* leak information.

I thought it was well-known to just clear (set to all-ones) the
tag register and not alter the actual floating-point registers.

Thus, it seems quite feasible to reset the tag word with FLDENV and
store out the FPU registers, even on an 80387.

Isn't this the same security hole?  Shouldn't there be 8 FLDZ instructions
(or equivalent) in the processor state initialization?
