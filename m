Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbTCNBo1>; Thu, 13 Mar 2003 20:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263216AbTCNBo1>; Thu, 13 Mar 2003 20:44:27 -0500
Received: from cs.columbia.edu ([128.59.16.20]:33999 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S263208AbTCNBoZ>;
	Thu, 13 Mar 2003 20:44:25 -0500
Subject: Re: fork/sh/hello microbenchmark performance in chroot
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1047606184.10046.9.camel@zaphod>
References: <1047606184.10046.9.camel@zaphod>
Content-Type: text/plain
Organization: 
Message-Id: <1047606869.7428.12.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 20:54:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in a followup, the only thing I can tell difference b/w the 2 runs
(under strace and inside and outside of the chroot) is that within the
chroot, after every fork() I see a SIGSTOP on the child.

anyone have any idea why this is happening?

On Thu, 2003-03-13 at 20:43, Shaya Potter wrote:
> I'm trying to play with our a homebrew version of lmbench's fork
> benchmark which exec's sh to run a "hello world" program.  On normal
> 2.4.18 (UP 933mhz p3) it runs in about .2s  However, within a chrooted
> environment I'm looking at 1s.
> 
> Anyone knows why this runs significantly slower within a chroot?
> 
> thanks,
> 
> shaya
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

