Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbUAJPEr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUAJPEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:04:46 -0500
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:64384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265188AbUAJPEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:04:44 -0500
Date: Sat, 10 Jan 2004 16:03:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: George Anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       jim.houston@comcast.net, discuss@x86-64.org, ak@suse.de,
       shivaram.upadhyayula@wipro.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
Message-ID: <20040110150338.GA532@elf.ucw.cz>
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
> 
> Patch:
> ------
> Patch the kernel out of following patches.
> core.patch -	KGDB architecture and interface independent code. Required.
> i386.patch -	i386 architecture dependent part. Required only for that
> 		architecture.
> x86_64.patch -	x86_64 architecture dependent part. Required only for that
> 		architecture.
> 8250.patch -	Generic serial port (8250 and 16550) interface for kgdb. This
> 		is the only working interface in this release. Hence required.
> eth.patch -	Ethernet interface for kgdb. This is still under development.
> 		Use only if you plan to contribute to its development.

It worked in 2.6something-mm. I'll try to take a look at this one; the
code is way better than -mm version. Hopefully getting kgdbeth to work
will not be that hard.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
