Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263648AbREYI3T>; Fri, 25 May 2001 04:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263634AbREYI3J>; Fri, 25 May 2001 04:29:09 -0400
Received: from ns.suse.de ([213.95.15.193]:22290 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263633AbREYI2z>;
	Fri, 25 May 2001 04:28:55 -0400
Date: Fri, 25 May 2001 10:27:53 +0200
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Message-ID: <20010525102753.A26379@gruyere.muc.suse.de>
In-Reply-To: <20010525101457.A26038@gruyere.muc.suse.de> <26405.990779157@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <26405.990779157@ocs3.ocs-net>; from kaos@ocs.com.au on Fri, May 25, 2001 at 06:25:57PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 06:25:57PM +1000, Keith Owens wrote:
> Nothing in arch/i386/kernel/traps.c uses a task gate, they are all
> interrupt, trap, system or call gates.  I guarantee that kdb on ix86
> and ia64 uses the same kernel stack as the failing task, the starting
> point for the kdb backtrace is itself and it does not follow segment
> switches.

I would consider this a bug in kdb then.

-Andi
