Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265532AbUALOd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265550AbUALOd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:33:28 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:64645 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265532AbUALOd0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:33:26 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
Date: Mon, 12 Jan 2004 20:02:14 +0530
User-Agent: KMail/1.5
Cc: George Anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       jim.houston@comcast.net, discuss@x86-64.org, ak@suse.de,
       shivaram.upadhyayula@wipro.com, lkml <linux-kernel@vger.kernel.org>
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401101611.53510.amitkale@emsyssoft.com> <20040110181402.GA2250@elf.ucw.cz>
In-Reply-To: <20040110181402.GA2250@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401122001.14997.amitkale@emsyssoft.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed. Thanks.

On Saturday 10 Jan 2004 11:44 pm, Pavel Machek wrote:
> Hi!
>
> > I have released kgdb 2.0.1 for kernel 2.6.1:
> > http://kgdb.sourceforge.net/linux-2.6.1-kgdb-2.0.1.tar.bz2
> >
> > It doesn't contain any assert stuff. I have split it into multiple parts
> > to make a merge easier. Please let me know if you want me to further
> > split them or if you want something to be changed. The README file from
> > this tarball is pasted below.
> >
> > Here is two possible starting points:
> > 1. SMP stuff -> Replace my old smp and nmi handling code.
> > 2. Early boot -> Change 8250.patch to make configuration of serial port
> > either through config options or through command line.
> >
> > I'll attempt reading your patch and merging as much stuff as possible.
> > Thanks.
>
> I'm getting error:
>
>   CC      kernel/kgdbstub.o
> kernel/kgdbstub.c: In function `kgdb_handle_exception':
> kernel/kgdbstub.c:646: error: `thref' undeclared (first use in this
> function)
> kernel/kgdbstub.c:646: error: (Each undeclared identifier is reported
> only once
> kernel/kgdbstub.c:646: error: for each function it appears in.)
> kernel/kgdbstub.c:677: error: `thread' undeclared (first use in this
> function)
> make[1]: *** [kernel/kgdbstub.o] Error 1
> make: *** [kernel] Error 2
> 44.97user 3.71system 59.51 (0m59.514s) elapsed 81.81%CPU
>
> I enabled  KGDB_THREAD and problem went away.
>
> 								Pavel

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

