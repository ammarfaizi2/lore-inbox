Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263460AbUEGKBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUEGKBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 06:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUEGKBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 06:01:45 -0400
Received: from users.linvision.com ([62.58.92.114]:59079 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263460AbUEGKBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 06:01:43 -0400
Date: Fri, 7 May 2004 12:01:42 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: Niccolo Rigacci <niccolo@rigacci.org>, linux-kernel@vger.kernel.org
Subject: Re: 2Gb file size limit on 2.4.24, LVM and ext3?
Message-ID: <20040507100142.GA30872@harddisk-recovery.com>
References: <20040506172152.GB17351@paros.rigacci.org> <409AA9EA.9020108@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409AA9EA.9020108@pointblue.com.pl>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 10:11:06PM +0100, Grzegorz Piotr Jaskiewicz wrote:
> Niccolo Rigacci wrote:
> >- The partition is an ext3 over LVM, kernel 2.4.24. Debian Woody
> > (glibc-2.2.5-11.5). Pentium 4 2.80GHz.
> > 
> >
> Ooops, sorry ;) can see it now.
> afair you need at least 2.3 for large files. But I am not 100% sure.

No, glibc-2.2.5-11.5 will also do large files. Just be sure that you
open() the file with O_LARGEFILE. I usually have this piece of code in
one of my header files to get it done:

#ifndef O_LARGEFILE
#define O_LARGEFILE     0100000
#endif

I always forget about the glibc #define-du-jour to get O_LARGEFILE
defined, this always works.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
