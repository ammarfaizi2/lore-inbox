Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbTCGV4Q>; Fri, 7 Mar 2003 16:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbTCGVzS>; Fri, 7 Mar 2003 16:55:18 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36601 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261811AbTCGVy1>; Fri, 7 Mar 2003 16:54:27 -0500
Date: Fri, 7 Mar 2003 17:05:01 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] s390 (1/7): s390 arch fixes.
Message-ID: <20030307170501.A32569@devserv.devel.redhat.com>
References: <200303072001.h27K12V16864@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303072001.h27K12V16864@devserv.devel.redhat.com>; from zaitcev@redhat.com on Fri, Mar 07, 2003 at 03:01:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.5.64/include/asm-s390/system.h	Wed Mar  5 04:29:54 2003
> +++ linux-2.5.64-s390/include/asm-s390/system.h	Fri Mar  7 11:40:12 2003
> @@ -82,7 +82,7 @@
>  		break;							     \
>  	save_fp_regs(&prev->thread.fp_regs);				     \
>  	restore_fp_regs(&next->thread.fp_regs);				     \
> -	resume(prev,next);						     \
> +	prev = resume(prev,next);					     \
>  } while (0)
>  
>  #define nop() __asm__ __volatile__ ("nop")

Are you sure it's not "last = resume(prev, next);"?

-- Pete
