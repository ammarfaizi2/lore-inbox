Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293201AbSCRWsk>; Mon, 18 Mar 2002 17:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293162AbSCRWsa>; Mon, 18 Mar 2002 17:48:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:35002 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293190AbSCRWsS>; Mon, 18 Mar 2002 17:48:18 -0500
Date: Mon, 18 Mar 2002 14:44:51 -0800
From: Russ Weight <rweight@us.ibm.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable CPU bitmasks
Message-ID: <20020318144451.A4377@us.ibm.com>
In-Reply-To: <001e01c1cecc$50c347f0$010411ac@local> <200203182242.g2IMgx119637@www.hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good point - I'll catch this at compile time. I'll resubmit shortly...

- Russ

On Mon, Mar 18, 2002 at 02:42:59PM -0800, Tim Hockin wrote:
> > >  NOTE:   The cpumap_to_ulong() and cpumap_ulong_to_cpumap() interfaces
> > >          are provided specifically for migration. In their current
> > >          form, they call BUG() if NR_CPUS is defined to be greater
> > >          than the bit-size of (unsigned long).
> > 
> > Why BUG? NR_CPUS is known at compile time,  is there a reason why you
> > can't use a call to an undefined function in order to get a link time
> > error message? (like __bad_udelay in linux/asm-i386/udelay.h)
> 
> why that, rather than #error ?
> 
> 

-- 
Russ Weight (rweight@us.ibm.com)
Linux Technology Center
