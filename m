Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSCOJNg>; Fri, 15 Mar 2002 04:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287408AbSCOJNZ>; Fri, 15 Mar 2002 04:13:25 -0500
Received: from ns.suse.de ([213.95.15.193]:56836 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287204AbSCOJNM>;
	Fri, 15 Mar 2002 04:13:12 -0500
Date: Fri, 15 Mar 2002 10:13:09 +0100
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
        rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-ID: <20020315101309.A13609@wotan.suse.de>
In-Reply-To: <20020314195122.A30566@wotan.suse.de> <E16lj03-0007Zm-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16lj03-0007Zm-00@wagner.rustcorp.com.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 03:07:27PM +1100, Rusty Russell wrote:
> They must return an lvalue, otherwise they're useless for 50% of cases
> (ie. assignment).  x86_64 can still use its own mechanism for
> arch-specific per-cpu data, of course.

Assignment should use an own macro (set_this_cpu()) or use per_cpu().

Alternatively you could split it into this_cpu_lvalue() and this_cpu(),
but this would be slightly less efficient.

-Andi


