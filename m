Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbUJWTfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbUJWTfc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 15:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUJWTfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 15:35:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:32999 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261284AbUJWTfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 15:35:25 -0400
Date: Sat, 23 Oct 2004 12:33:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Javier Marcet <javier@marcet.info>
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
Message-Id: <20041023123323.04b59353.akpm@osdl.org>
In-Reply-To: <20041023125948.GC9488@marcet.info>
References: <20041023125948.GC9488@marcet.info>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Marcet <javier@marcet.info> wrote:
>
> I've been following quite closely the development of 2.6.9, testing
>  every -rc release and a lot of -bk's.
> 
>  Upon changing from 2.6.9-rc2 to 2.6.9-rc3 I began experiencing random
>  oom kills whenever a high memory i/o load took place.

Do you have swap online?

What sort of machine is it, and how much memory has it?

>  This happened with plenty of free memory, and with whatever values I
>  used for vm.overcommit_ratio and vm.overcommit_memory
>  Doubling the physical RAM didn't change the situation either.
> 
>  Having traced the problem to 2.6.9-rc3, I took a look at the differences
>  in memory handling between 2.6.9-rc2 and 2.6.9-rc3 and with the attached
>  patch I have no more oom kills. Not a single one.
> 
>  I'm not saying everything within the patch is needed, not even that it's
>  the right thing to change. Nonetheless, 2.6.9 vanilla was unusable,
>  while this avoids those memory leaks.

That patch only affects NUMA machines?
