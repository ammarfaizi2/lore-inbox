Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVJQPJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVJQPJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbVJQPJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:09:50 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:465 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751387AbVJQPJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:09:49 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: 2.6.14-rc4-mm1 ntfs/namei.c missing compat.h?
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: nyk <nyk@giantx.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051017144900.GA2942@giantx.co.uk>
References: <20051017144900.GA2942@giantx.co.uk>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 17 Oct 2005 16:09:46 +0100
Message-Id: <1129561786.4701.9.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 15:49 +0100, nyk wrote:
> Looks like fs/ntfs/namei.c is missing linux/compat.h
> 
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   CC [M]  fs/ntfs/namei.o
> In file included from include/linux/dcache.h:6,
>                  from fs/ntfs/namei.c:23:
> include/asm/atomic.h:383: error: syntax error before '*' token
> include/asm/atomic.h:384: warning: function declaration isn't a prototype
> include/asm/atomic.h: In function 'atomic_scrub':
> include/asm/atomic.h:385: error: 'u32' undeclared (first use in this function)
> include/asm/atomic.h:385: error: (Each undeclared identifier is reported only once
> include/asm/atomic.h:385: error: for each function it appears in.)
> include/asm/atomic.h:385: error: syntax error before 'i'
> include/asm/atomic.h:386: error: 'i' undeclared (first use in this function)
> include/asm/atomic.h:386: error: 'size' undeclared (first use in this function)
> include/asm/atomic.h:386: error: 'virt_addr' undeclared (first use in this function)
> include/asm/atomic.h:386: warning: left-hand operand of comma expression has no effect
> include/asm/atomic.h:386: warning: statement with no effect
> include/asm/atomic.h:390: error: memory input 0 is not directly addressable
> make[2]: *** [fs/ntfs/namei.o] Error 1
> make[1]: *** [fs/ntfs] Error 2
> make: *** [fs] Error 2
> 
> Compiles fine with #include <linux/compat.h> added to the top of
> fs/ntfs/namei.c
> 
> If that's the right place for it, of course.

Odd.  Compiles fine on non-mm kernel here.  Can you send me
your .config?  (And which architecture are you using?)

Thanks.

/me goes away to download -mm...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

