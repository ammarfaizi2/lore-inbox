Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292841AbSCGDxe>; Wed, 6 Mar 2002 22:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292554AbSCGDxX>; Wed, 6 Mar 2002 22:53:23 -0500
Received: from [202.135.142.196] ([202.135.142.196]:49674 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S291081AbSCGDxP>; Wed, 6 Mar 2002 22:53:15 -0500
Date: Thu, 7 Mar 2002 14:56:30 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Message-Id: <20020307145630.7d4aed95.rusty@rustcorp.com.au>
In-Reply-To: <20020305145004.BFA503FE06@smtp.linux.ibm.com>
In-Reply-To: <20020305145004.BFA503FE06@smtp.linux.ibm.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002 20:57:49 -0500
Hubertus Franke <frankeh@watson.ibm.com> wrote:

> 
> Can somebody post why this patch shouldn't be picked up ?
> The attached program shows the problem in user space 
> and the patch is almost trivial ..

At a cursory glance, this seems to be three patches:
	1) Fix the get_pid() hang.
	2) Speed up get_pid().
	3) And this piece I'm not sure about:
> +                 if(p->tgid > last_pid && next_safe > p->tgid)
> +                       next_safe = p->tgid;

Please split, and send the fix get_pid() hang to trivial patch monkey,
and push optimization to Linus.

Cheers!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
