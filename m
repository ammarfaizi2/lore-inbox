Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265942AbSKBL61>; Sat, 2 Nov 2002 06:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265944AbSKBL60>; Sat, 2 Nov 2002 06:58:26 -0500
Received: from pop018pub.verizon.net ([206.46.170.212]:26107 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S265942AbSKBL6Z>; Sat, 2 Nov 2002 06:58:25 -0500
Date: Sat, 02 Nov 2002 06:04:20 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] 1/2 2.5.45 cleanup & add original copy_ro/from_user
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p737kfws378.fsf@oldwotan.suse.de>
References: <20021102024957.220C.AT541@columbia.edu.suse.lists.linux.kernel> <p737kfws378.fsf@oldwotan.suse.de>
Message-Id: <20021102055614.0327.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop018.verizon.net from [138.89.32.225] at Sat, 2 Nov 2002 06:04:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Nov 2002 10:58:35 +0100
Andi Kleen <ak@suse.de> mentioned:
> Akira Tsukamoto <at541@columbia.edu> writes:
> 
> > This patch will:
> > 1) If it is not X86_MPENTIUMIII or 4, use the original copy routines, 
> >    which does not exist in 2.5.45.
> 
> First you're ignoring Athlon, which also prefers unrolled copies.
> 
> The old user copy functions should then only used when not optimizing for
> modern cpus, but not when the minimum level is 386. And perhaps when
> CONFIG_SMALL is defined.

Yes, it is ignoring Athlon because my patch is basically just clean up and not changing
anything.
If you read the 2.5.45, you will see *2.5.45* is also ignoring Athlon and not using 
unrolled copies.

I am working on optimized version for AMD, go over on this patch.
But thank you for your comment, I will consider using CONFIG_SMALL for 
putting all the old stuff in it.



