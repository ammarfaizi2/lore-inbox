Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUFNVQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUFNVQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUFNVP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:15:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:20430 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264412AbUFNVPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:15:38 -0400
Subject: Re: [PATCH] Fix ppc64 out_be64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: Andrew Morton <akpm@osdl.org>, anton@au.ibm.com,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <52wu2928ej.fsf@topspin.com>
References: <521xkk77xh.fsf@topspin.com> <1087141822.8210.176.camel@gaston>
	 <52llir5rr2.fsf@topspin.com> <1087146682.8697.184.camel@gaston>
	 <52wu2928ej.fsf@topspin.com>
Content-Type: text/plain
Message-Id: <1087247403.8697.198.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 14 Jun 2004 16:10:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-14 at 15:26, Roland Dreier wrote:
>     Benjamin> Well, I may know ppc asm, but gcc inline asm still
>     Benjamin> drives me nuts :)
> 
> Speaking of gcc asm, is there a reason why out_le64 (specifically the
> constraints) isn't written in this (simpler) way?  It seems to me we
> can just let val be an input, as long as the "&" constraint for tmp
> makes sure it doesn't share the same register.  This seems to generate
> the same code for me as the current kernel version, at least with gcc
> 3.4.0/binutils 2.15.

Hrm... and addr too .. well, I'm just paranoid about those constraints,
I never took the time to fully understand how gcc deals with them
and got bitten by them often enough. I'd rather keep the version that
just works at this point ;)

Ben.


