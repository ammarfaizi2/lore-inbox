Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751930AbWI3UYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWI3UYM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbWI3UYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:24:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751930AbWI3UYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:24:11 -0400
Date: Sat, 30 Sep 2006 13:23:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Eric Rannaud <eric.rannaud@gmail.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, nagar@watson.ibm.com,
       Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <1159645755.13651.54.camel@lappy>
Message-ID: <Pine.LNX.4.64.0609301322530.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <1159645755.13651.54.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Peter Zijlstra wrote:
> 
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/broken-out/slab-fix-lockdep-warnings.patch
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/broken-out/slab-fix-lockdep-warnings-fix.patch
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/broken-out/slab-fix-lockdep-warnings-fix-2.patch
> 
> Those should rid you off the trace seen under:

Well, the more serious problem seems to be that any warning that causes a 
back-trace on x86-64 seems liable to just lock up due to the backtrace 
code itself being buggy.

At least I _hope_ its x86-64 only.

		Linus
