Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263604AbREYHN3>; Fri, 25 May 2001 03:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263605AbREYHNU>; Fri, 25 May 2001 03:13:20 -0400
Received: from oxmail3.ox.ac.uk ([129.67.1.180]:27572 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S263604AbREYHNH>;
	Fri, 25 May 2001 03:13:07 -0400
Date: Fri, 25 May 2001 08:11:07 +0100
From: David Welch <david.welch@st-edmund-hall.oxford.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Message-ID: <20010525081107.A733@whitehall1-5.seh.ox.ac.uk>
In-Reply-To: <20010525013303.A21810@gruyere.muc.suse.de> <23182.990768020@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <23182.990768020@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, May 25, 2001 at 03:20:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 03:20:20PM +1000, Keith Owens wrote:
> 
> >> On a side note, does anyone know if the kernel does checking if the
> >> stack overflowed at any time?
> >
> >You normally get a silent hang or worse a stack fault exception 
> >(which linux/x86 without kdb cannot recover from) which gives you instant 
> >reboot.
> 
> You cannot recover from a kernel stack overflow even with kdb.  The
> exception handler and kdb use the stack that just overflowed.
> 
Why not use a task gate for the double fault handler points to a 
per-processor TSS with a seperate stack. This would allow limited recovery
from a kernel stack overlay.
