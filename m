Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSINNgZ>; Sat, 14 Sep 2002 09:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSINNgZ>; Sat, 14 Sep 2002 09:36:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41737 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316614AbSINNgY>;
	Sat, 14 Sep 2002 09:36:24 -0400
Date: Sat, 14 Sep 2002 14:41:18 +0100
From: Matthew Wilcox <willy@debian.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: torvalds@transmeta.com, willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.34-bk fcntl lockup
Message-ID: <20020914144118.C10583@parcelfarce.linux.theplanet.co.uk>
References: <20020914101811.GA1447@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020914101811.GA1447@ppc.vc.cvut.cz>; from vandrove@vc.cvut.cz on Sat, Sep 14, 2002 at 12:18:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2002 at 12:18:11PM +0200, Petr Vandrovec wrote:
> Hi Linus,
>    please apply this. 

agreed, please apply.

> Fixes endless loop without schedule which happens as soon as smbd 
> invokes fcntl64(7, F_SETLK64, ...). fcntl_setlk64 gets cmd F_SETLK64,
> not F_SETLK tested in the loop;

i guess the LTP testsuite isn't quite comprehensive enough yet, it should
have caught this.

> Maybe return value from posix_lock_file should be changed to -EINPROGRESS 
> or -EJUKEBOX instead of testing passed cmd in callers, but this oneliner 
> works too. If you preffer changing posix_lock_file return value to clearly 
> distinugish between -EAGAIN and lock request queued, I'll do that.

i'll look at that idea, hadn't occurred to me before.

-- 
Revolutions do not require corporate support.
