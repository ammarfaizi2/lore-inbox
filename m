Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSLTP7D>; Fri, 20 Dec 2002 10:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSLTP7D>; Fri, 20 Dec 2002 10:59:03 -0500
Received: from crack.them.org ([65.125.64.184]:1512 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262446AbSLTP7D>;
	Fri, 20 Dec 2002 10:59:03 -0500
Date: Fri, 20 Dec 2002 11:08:17 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: PTRACE_GET_THREAD_AREA
Message-ID: <20021220160817.GA26717@nevyn.them.org>
Mail-Followup-To: Jakub Jelinek <jakub@redhat.com>,
	Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>
References: <200212200832.gBK8Wfg29816@magilla.sf.frob.com> <20021220154829.GB17007@nevyn.them.org> <20021220105513.J27455@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220105513.J27455@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 10:55:16AM -0500, Jakub Jelinek wrote:
> On Fri, Dec 20, 2002 at 10:48:29AM -0500, Daniel Jacobowitz wrote:
> > Eventually most or all targets will have thread-specific data
> > implemented; I don't want to have to redo this for each one.
> 
> Well, but on most arches you don't need any kernel support for TLS.
> On sparc32/sparc64/IA-64/s390/s390x and others you simply have one
> general register reserved for it by the ABI, on Alpha you use a PAL
> call.
> set_thread_area/get_thread_area is IA-32/x86-64 specific.

Oh, right, I guess we won't need anything if it's just in a register :)
Architecture-specific it is, then.  For Alpha (and probably MIPS) we
can add a ptrace equivalent of the trap to fetch the pointer.  Patch
looks fine to me.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
