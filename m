Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266168AbUAUWDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 17:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266171AbUAUWDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 17:03:52 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:55233 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S266168AbUAUWDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 17:03:47 -0500
Date: Wed, 21 Jan 2004 15:03:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       George Anzinger <george@mvista.com>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040121220341.GA15271@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121192128.GV13454@stop.crashing.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 12:21:28PM -0700, Tom Rini wrote:
> On Wed, Jan 21, 2004 at 11:42:17AM -0700, Tom Rini wrote:
> > On Wed, Jan 21, 2004 at 10:23:12PM +0530, Amit S. Kale wrote:
> > 
> > > Hi,
> > > 
> > > Here it is: ppc kgdb from timesys kernel is available at
> > > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.1.0.tar.bz2
> > > 
> > > This is my attempt at extracting kgdb from TimeSys kernel. It works well in 
> > > TimeSys kernel, so blame me if above patch doesn't work.
> > 
> > Okay, here's my first patch against this.
> 
> And dependant upon this is a patch to fixup the rest of the common PPC
> code, as follows:

And this should have also been in this patch:

--- 1.49/arch/ppc/Kconfig	Wed Jan 21 12:21:23 2004
+++ edited/arch/ppc/Kconfig	Wed Jan 21 12:47:52 2004
@@ -1374,12 +1374,11 @@
 	  this option if you do not want to compromise on speed.
 
 config KGDB_CONSOLE
-	bool "Enable serial console thru kgdb port"
-	depends on KGDB && 8xx || 8260
+	bool "KGDB: Console messages through gdb"
+	depends on KGDB
 	help
-	  If you enable this, all serial console messages will be sent
-	  over the gdb stub.
-	  If unsure, say N.
+	  If you say Y here, console messages will appear through gdb.
+	  Other consoles such as tty or ttyS will continue to work as usual.
 
 config XMON
 	bool "Include xmon kernel debugger"

-- 
Tom Rini
http://gate.crashing.org/~trini/
