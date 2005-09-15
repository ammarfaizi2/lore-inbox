Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbVIOBvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVIOBvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVIOBvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:51:36 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:2441 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030324AbVIOBvg (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:51:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wY0SfuiFeDsP4v3PBB1+iJIdl07oXlTST/16PF/L+OEO8jowe4YBiV/GrWOFBRCgHhmkWCGWFPrf7iPNNz1DULAPRO86y4yiftXbuJ2af/A9KnsoMtwDqwISC4nrxAc2pnXjmSkqUp9+f4wenp7METzJy0aK77qjIYlOqrDWNcw=  ;
Message-ID: <4328D39C.2040500@yahoo.com.au>
Date: Thu, 15 Sep 2005 11:51:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au> <Pine.LNX.4.61.0509141814220.3743@scrub.home> <43285374.3020806@yahoo.com.au> <Pine.LNX.4.61.0509141906040.3728@scrub.home> <20050914230049.F30746@flint.arm.linux.org.uk> <Pine.LNX.4.61.0509150010100.3728@scrub.home> <20050914232106.H30746@flint.arm.linux.org.uk>
In-Reply-To: <20050914232106.H30746@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> The whole point about architecture specific includes is not to provide
> a frenzied feeding ground for folk who like to "clean code up" but to
> allow architectures to do things in the most efficient way for them
> without polluting the kernel too much.
> 
> It seems that aspect is being lost sight of here.
> 

Yep. We've got atomic_add, atomic_sub, atomic_inc, atomic_dec,
atomic_inc_return, atomic_add_return, atomic_dec_return, atomic_sub_return
to start with.

Not only that, but we can probably emulate all the atomic_ operations
with atomic_cmpxchg, not just atomic_inc_not_zero.

Roman: any ideas about what you would prefer? You'll notice
atomic_inc_not_zero replaces rcuref_inc_lf, which is used several times
in the VFS.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
