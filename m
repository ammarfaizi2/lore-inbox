Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUAUSjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbUAUSjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:39:51 -0500
Received: from nevyn.them.org ([66.93.172.17]:12697 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265590AbUAUSjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:39:49 -0500
Date: Wed, 21 Jan 2004 13:39:40 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040121183940.GA23200@nevyn.them.org>
Mail-Followup-To: "Amit S. Kale" <amitkale@emsyssoft.com>,
	George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
	Matt Mackall <mpm@selenic.com>, discuss@x86-64.org
References: <200401161759.59098.amitkale@emsyssoft.com> <200401171459.01794.amitkale@emsyssoft.com> <40099301.6000202@mvista.com> <200401211916.49520.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401211916.49520.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 07:16:48PM +0530, Amit S. Kale wrote:
> Now back to gdb problem of not being able to locate registers.
> schedule results in code of this form:
> 
> schedule:
> framesetup
> registers save
> ...
> ...
> save registers
> change esp
> call switchto
> restore registers
> ...
> ...
> 
> GDB can't analyze code other than frame setup and registers save. It may not 
> show values of variables that are present in registers correctly. This used 
> to be a problem some time ago (gdb 5.X). Perhaps gdb 6.x does a better job.
> hmm...
> May be its time I should look at gdb's x86 register info code again.

You should try GDB 6.0, which will use the dwarf2 unwind information to
accurately locate registers in any GCC-compiled code with -gdwarf-2 (-g
on Linux targets).

As George is now painfully familiar with :)

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
