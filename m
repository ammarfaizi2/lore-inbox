Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUAVWwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 17:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUAVWwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 17:52:21 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:16603 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S265136AbUAVWwU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 17:52:20 -0500
Date: Thu, 22 Jan 2004 15:52:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Hollis Blanchard <hollisb@us.ibm.com>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040122225209.GS15271@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <30216351-4CEF-11D8-A2A1-000A95A0560C@us.ibm.com> <20040122154529.GE15271@stop.crashing.org> <200401222136.10887.amitkale@emsyssoft.com> <20040122164521.GF15271@stop.crashing.org> <401052D1.4040306@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401052D1.4040306@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 02:46:41PM -0800, George Anzinger wrote:
> Tom Rini wrote:
> >
> >
> >FWIW, this is true of KGDB on all PPCs.  IIRC, so long as the serial
> >definitions are filled out statically, the stub currently in kernel.org
> >for PPC can do first-line-of-C already.
> >
> >
> >>How about changing the code in kgdbstub to allow kgdb to be configured in 
> >>one of the following ways:
> >>Late kgdb - kgdb comes up after smp_init in the kernel boot sequence. 
> >>kgdb8250 can be used with more flexibility through kernel command line 
> >>options. One can boot a kgdb kernel without activating kgdb. Works with 
> >>the interface chosen by kernel command line (kgdb8250 and kgdbeth for the 
> >>moment).
>
> A further thought on this.  I think kgdb should take control on oops, panic 
> and other bad news things.  This without being anthing but configured in.  
> Thus the command line options to set up the interface, etc, should not 
> automatically connect to gdb.

*confused look* it doesn't do this already on i386?  I'm fairly certain
that it does on PPC, regardless of the stub (since I've got this wierd
panic happening on my testbox right now, but kgdb is kicking in..)

-- 
Tom Rini
http://gate.crashing.org/~trini/
