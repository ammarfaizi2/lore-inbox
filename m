Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263711AbTCUScn>; Fri, 21 Mar 2003 13:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263713AbTCUSbf>; Fri, 21 Mar 2003 13:31:35 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:59300 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262595AbTCUSaZ>; Fri, 21 Mar 2003 13:30:25 -0500
Date: Fri, 21 Mar 2003 18:41:20 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: __NO_VERSION__ and remove a bogomacro from drm
Message-ID: <20030321184119.GC17494@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <200303211920.h2LJKpoF025699@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303211920.h2LJKpoF025699@hraefn.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 07:20:51PM +0000, Alan Cox wrote:

 > @@ -40,12 +39,6 @@
 >  #include <linux/interrupt.h>	/* For task queue support */
 >  #include <linux/delay.h>
 >  
 > -#ifdef DO_MUNMAP_4_ARGS
 > -#define DO_MUNMAP(m, a, l)	do_munmap(m, a, l, 1)
 > -#else
 > -#define DO_MUNMAP(m, a, l)	do_munmap(m, a, l)
 > -#endif
 > -
 >  #define I830_BUF_FREE		2
 >  #define I830_BUF_CLIENT		1
 >  #define I830_BUF_HARDWARE      	0
 > @@ -230,7 +223,7 @@
 >  		return -EINVAL;
 >  
 >  	down_write(&current->mm->mmap_sem);
 > -	retcode = DO_MUNMAP(current->mm,
 > +	retcode = do_munmap(current->mm,
 >  			    (unsigned long)buf_priv->virtual,
 >  			    (size_t) buf->total);
 >  	up_write(&current->mm->mmap_sem);
 > -

already applied in -bk

		Dave

