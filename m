Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVAWE5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVAWE5v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVAWE5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:57:51 -0500
Received: from smtpout.mac.com ([17.250.248.47]:19402 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261221AbVAWE5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:57:50 -0500
In-Reply-To: <m1r7kc27ix.fsf@muc.de>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net> <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5ADB1D78-6CFB-11D9-86B4-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       Buck Huppmann <buchk@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: [patch 1/13] Qsort
Date: Sun, 23 Jan 2005 05:58:00 +0100
To: Andi Kleen <ak@muc.de>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 2005, at 03:39, Andi Kleen wrote:

> Felipe Alfaro Solana <lkml@mac.com> writes:
>>
>> AFAIK, XOR is quite expensive on IA32 when compared to simple MOV
>> operatings. Also, since the original patch uses 3 MOVs to perform the
>> swapping, and your version uses 3 XOR operations, I don't see any
>> gains.
>
> Both are one cycle latency for register<->register on all x86 cores
> I've looked at. What makes you think differently?

I thought XOR was more expensie. Anyways, I still don't see any 
advantage in replacing 3 MOVs with 3 XORs.

