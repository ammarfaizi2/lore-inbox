Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287177AbSA1W05>; Mon, 28 Jan 2002 17:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287244AbSA1W0h>; Mon, 28 Jan 2002 17:26:37 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:45954 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S287204AbSA1W0e>;
	Mon, 28 Jan 2002 17:26:34 -0500
Date: Mon, 28 Jan 2002 17:26:20 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
Message-ID: <20020128172620.A11522@nevyn.them.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <001401c1a844$ae7c51b0$010411ac@local> <E16VJu7-0001w0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16VJu7-0001w0-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 10:05:31PM +0000, Alan Cox wrote:
> > For framebuffers addresses, there is no page structure, and then the
> > page reference count updates read/write to random memory.
> 
> If it is a physical pci bus object why do we need to refcount it, surely
> "no page" is ok. Its just up to the driver not to do anything stupid and
> the core code to honour the pci/pci transfer quirks (or when faced with
> a hard one just say "no")

So, is there a clear interface by which access_process_vm ought to be
able to get at the mapped framebuffer, or should get_user_pages just
punt off it?

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
