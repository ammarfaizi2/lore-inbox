Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWEKXlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWEKXlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 19:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWEKXlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 19:41:42 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:55200 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750827AbWEKXll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 19:41:41 -0400
In-Reply-To: <20060511002217.GA31481@twiddle.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com> <20060510154702.GA28938@twiddle.net> <20060510.124003.04457042.davem@davemloft.net> <17506.21908.857189.645889@cargo.ozlabs.ibm.com> <49BB818F-DF88-43A3-8B6A-7F9F5C7A2C3C@kernel.crashing.org> <20060511002217.GA31481@twiddle.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E44D1BA0-2DB1-4151-BAC7-16B4BF37E419@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>,
       linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Date: Fri, 12 May 2006 01:41:32 +0200
To: Richard Henderson <rth@twiddle.net>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would an asm clobber of GPR13 in the schedule routines (or a wrapper
>> for them, or whatever) work?
>
> No.  The address is cse'd symbolically long before the r13
> reference is exposed.

Current GCC won't ever do that over a (non-local, non-inlinable)
function call though.  _Current_ GCC.


Segher

