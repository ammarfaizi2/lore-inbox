Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbUAJSNS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUAJSNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:13:18 -0500
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:14720 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265280AbUAJSNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:13:01 -0500
Date: Sat, 10 Jan 2004 19:14:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: George Anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       jim.houston@comcast.net, discuss@x86-64.org, ak@suse.de,
       shivaram.upadhyayula@wipro.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
Message-ID: <20040110181402.GA2250@elf.ucw.cz>
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401091031.41493.amitkale@emsyssoft.com> <3FFF2851.4060501@mvista.com> <200401101611.53510.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401101611.53510.amitkale@emsyssoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have released kgdb 2.0.1 for kernel 2.6.1:
> http://kgdb.sourceforge.net/linux-2.6.1-kgdb-2.0.1.tar.bz2
> 
> It doesn't contain any assert stuff. I have split it into multiple parts to 
> make a merge easier. Please let me know if you want me to further split them 
> or if you want something to be changed. The README file from this tarball is 
> pasted below.
> 
> Here is two possible starting points:
> 1. SMP stuff -> Replace my old smp and nmi handling code.
> 2. Early boot -> Change 8250.patch to make configuration of serial port either 
> through config options or through command line.
> 
> I'll attempt reading your patch and merging as much stuff as possible.
> Thanks.

I'm getting error:

  CC      kernel/kgdbstub.o
kernel/kgdbstub.c: In function `kgdb_handle_exception':
kernel/kgdbstub.c:646: error: `thref' undeclared (first use in this
function)
kernel/kgdbstub.c:646: error: (Each undeclared identifier is reported
only once
kernel/kgdbstub.c:646: error: for each function it appears in.)
kernel/kgdbstub.c:677: error: `thread' undeclared (first use in this
function)
make[1]: *** [kernel/kgdbstub.o] Error 1
make: *** [kernel] Error 2
44.97user 3.71system 59.51 (0m59.514s) elapsed 81.81%CPU

I enabled  KGDB_THREAD and problem went away.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
