Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbTEZXL2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbTEZXL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:11:28 -0400
Received: from rj.SGI.COM ([192.82.208.96]:50629 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262294AbTEZXL1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:11:27 -0400
Date: Tue, 27 May 2003 09:21:44 +1000
From: Nathan Scott <nathans@sgi.com>
To: Gregoire Favre <greg@magma.unil.ch>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: xfs don't compil in linux-2.5 BK
Message-ID: <20030526232144.GA705@frodo>
References: <20030526193136.GB10276@magma.unil.ch> <1053986469.3754.6.camel@nalesnik.localhost> <20030526223803.GB14954@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20030526223803.GB14954@magma.unil.ch>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 12:38:03AM +0200, Gregoire Favre wrote:
> On Mon, May 26, 2003 at 11:01:12PM +0100, Grzegorz Jaskiewicz wrote:
> 
> > looks like LINUX_VERSION_CODE is not defined
> > try this (as 2.5.69 > than 2.5.9)
> 
> Well, maybe BK is not for me:
> 
> greg@greg:linux >make dep && make bzImage && make modules && sudo make modules_install
> *** Warning: make dep is unnecessary now.

Are you missing "make oldconfig" or one of the other *config targets,
perhaps?  Looks like some parts of your build haven't been done before
you descend into fs/xfs - in particular, your <linux/version.h> header
doesn't seem to have good stuff in it.

cheers.

> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
>   CHK     include/linux/compile.h
> dnsdomainname: Unknown host
>   CC      fs/xfs/pagebuf/page_buf.o
> In file included from fs/xfs/pagebuf/page_buf.c:65:
> fs/xfs/pagebuf/page_buf_internal.h:46:24: operator '<' has no left operand
> fs/xfs/pagebuf/page_buf_internal.h:51:24: operator '<' has no left operand
> make[2]: *** [fs/xfs/pagebuf/page_buf.o] Error 1
> make[1]: *** [fs/xfs] Error 2
> make: *** [fs] Error 2
> Exit 2
> 
> Thank you very much,
> 
> 	Grégoire
> __________________________________________________________________
> http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Nathan
