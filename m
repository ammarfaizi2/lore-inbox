Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbRCBWEt>; Fri, 2 Mar 2001 17:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129548AbRCBWEj>; Fri, 2 Mar 2001 17:04:39 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:5380 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129546AbRCBWE2>;
	Fri, 2 Mar 2001 17:04:28 -0500
Date: Thu, 1 Mar 2001 12:04:47 +0000
From: Pavel Machek <pavel@suse.cz>
To: Erik Hensema <erik@hensema.xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binfmt_script and ^M
Message-ID: <20010301120446.A34@(none)>
In-Reply-To: <20010227140333.C20415@cistron.nl> <E14XkQG-0003R7-00@the-village.bc.nu> <20010228211043.A4579@hensema.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010228211043.A4579@hensema.xs4all.nl>; from erik@hensema.xs4all.nl on Wed, Feb 28, 2001 at 09:10:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > When running a script (perl in this case) that has DOS-style
> > > newlines (\r\n), Linux 2.4.2 can't find an interpreter because it
> > > doesn't recognize the \r.  The following patch should fix this
> > > (untested).
> 
> > Fix the script. The kernel expects a specific format
> 
> 
> How about letting the kernel return ENOEXEC instead of ENOENT? It would
> give the luser just the little extra hint about converting their files to
> Unix format.
> 
> $ ls
> testscript
> $ head -1 testscript
> #!/bin/sh
> $ ./testscript
> bash: ./testscript: No such file or directory

What kernel wants to say is "/usr/bin/perl\r: no such file". Saying ENOEXEC
would be even more confusing.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

