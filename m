Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263627AbREYIQT>; Fri, 25 May 2001 04:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263630AbREYIQJ>; Fri, 25 May 2001 04:16:09 -0400
Received: from ns.suse.de ([213.95.15.193]:63248 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263627AbREYIP7>;
	Fri, 25 May 2001 04:15:59 -0400
Date: Fri, 25 May 2001 10:14:57 +0200
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Message-ID: <20010525101457.A26038@gruyere.muc.suse.de>
In-Reply-To: <20010525013303.A21810@gruyere.muc.suse.de> <23182.990768020@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <23182.990768020@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, May 25, 2001 at 03:20:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 03:20:20PM +1000, Keith Owens wrote:
> >> On a side note, does anyone know if the kernel does checking if the
> >> stack overflowed at any time?
> >
> >You normally get a silent hang or worse a stack fault exception 
> >(which linux/x86 without kdb cannot recover from) which gives you instant 
> >reboot.
> 
> You cannot recover from a kernel stack overflow even with kdb.  The
> exception handler and kdb use the stack that just overflowed.

Hmm, I thought it used an own stack using an appropiate gate.
At least on x86-64 I implemented it this way using a static 4K array.


-Andi
