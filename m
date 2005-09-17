Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVIQER4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVIQER4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 00:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbVIQER4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 00:17:56 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:26336 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750870AbVIQERz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 00:17:55 -0400
Subject: Re: 2.6.13-mm2
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200509162038_MC3-1-AA6D-60D9@compuserve.com>
References: <200509162038_MC3-1-AA6D-60D9@compuserve.com>
Content-Type: text/plain
Date: Sat, 17 Sep 2005 00:17:37 -0400
Message-Id: <1126930657.7927.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-16 at 20:36 -0400, Chuck Ebbert wrote:
> It looks to me like that patch corrupts ebp.
> 
>  This one works for me, though ebp still appears wrong to a 32-bit
> debugger on syscall exit trace.  Maybe that doesn't matter so much. 

Did you compile the program under a x86_64 kernel, distro? I ask because
it doesn't compile for me. On my machine asm-i386/user.h and
asm-x86_64/user.h both do not contain a user_regs_struct definition with
x86 registers.

Another thing I noticed was that with the patch %eax was zero for the
failing program although I didn't see how the patch affects %eax.

Parag

