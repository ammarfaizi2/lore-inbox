Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280339AbRKOC7B>; Wed, 14 Nov 2001 21:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280480AbRKOC6v>; Wed, 14 Nov 2001 21:58:51 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:34808 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S280339AbRKOC6e>; Wed, 14 Nov 2001 21:58:34 -0500
Date: Wed, 14 Nov 2001 21:58:15 -0500
From: Ben Collins <bcollins@debian.org>
To: Alex Adriaanse <alex_a@caltech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LFS stopped working
Message-ID: <20011114215815.S329@visi.net>
In-Reply-To: <JIEIIHMANOCFHDAAHBHOOEOLCMAA.alex_a@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JIEIIHMANOCFHDAAHBHOOEOLCMAA.alex_a@caltech.edu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 02:05:21PM -0800, Alex Adriaanse wrote:
> Hey,
> 
> I've been running 2.4.14 for a few days now.  I needed LFS support, so I
> recompiled glibc 2.1.3 with the new 2.4 headers, and after that I could
> create large files (e.g. using dd if=/dev/zero of=test bs=1M count=0
> seek=3000) just fine.
> 
> However, as of yesterday, I couldn't create files bigger than 2GB anymore.
> I did not change kernels, nor did I mess with libc or anything else (I did
> some Debian package upgrades/installations/recompiles, but I don't think
> they should affect this) - I'm not quite sure what happened.  Now commands
> such as the dd command I mentioned above will die with the message "File
> size limit exceeded", leaving a 2GB file behind.  Rebooting didn't solve
> anything.  My ulimits seem to be fine (file size = unlimited).

Actually it does affect it. Recompiling glibc isn't the end all to LFS
support. In fact, 2.1.3 has less than adequate support for LFS, IIRC, so
use 2.2.x. For Debian, that just means upgrading to woody(testing).

Your problem extends from programs also needing to be recompiled with
LFS support. This involves some special LFS CFLAGS, and most common
programs detect whether to do this using autoconf (fileutils, gzip and
tar are perfect examples of programs that use this feature).


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
