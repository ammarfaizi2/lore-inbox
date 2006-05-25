Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWEYSke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWEYSke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWEYSke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:40:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60084 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030322AbWEYSke convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:40:34 -0400
Date: Thu, 25 May 2006 11:43:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: __smail =?ISO-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scx200_acb: fix section mismatch warning
Message-Id: <20060525114309.0e49b467.akpm@osdl.org>
In-Reply-To: <4475F314.9060308@pardus.org.tr>
References: <20060525100138.cb9e53c5.rdunlap@xenotime.net>
	<20060525192657.081c8c11.khali@linux-fr.org>
	<20060525110627.3461937f.akpm@osdl.org>
	<4475F314.9060308@pardus.org.tr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__smail Dönmez <ismail@pardus.org.tr> wrote:
>
> Andrew Morton wrote On 25-05-2006 21:06:
> > Jean Delvare <khali@linux-fr.org> wrote:
> >>> -static int scx200_add_cs553x(void)
> >>  > +static __init int scx200_add_cs553x(void)
> >>  >  {
> >>  >  	u32	low, hi;
> >>  >  	u32	smb_base;
> >>  > 
> >>
> >>  Correct, I sent exactly the same patch to the the lm-sensors list and
> >>  Greg KH yesterday:
> >>  http://lists.lm-sensors.org/pipermail/lm-sensors/2006-May/016213.html
> >>
> >>  So this one is
> >>  Signed-off-by: Jean Delvare <khali@linux-fr.org>
> >>
> >>  Note that the section mismatch is harmless here (we have a non-__init
> >>  function sandwiched between two __init functions) but nevertheless this
> >>  kind of warning is never welcome in a final kernel release so let's get
> >>  the fix merged now.
> >>
> >>  Andrew, can you please push this to Linus?
> > 
> > yup, I'll send that later on today.  My current 2.6.17 queue is:
> > 
> > s390-fix-typo-in-stop_hz_timer.patch
> > add-cmspar-to-termbitsh-for-powerpc-and-alpha.patch
> > x86-wire-up-vmsplice-syscall.patch
> > ads7846-conversion-accuracy.patch
> > affs-possible-null-pointer-dereference-in-affs_rename.patch
> > powermac-force-only-suspend-to-disk-to-be-valid.patch
> > s3c24xx-fix-spi-driver-with-config_pm.patch
> > scx200_acb-fix-section-mismatch-warning.patch
> 
> Is there a chance of queing Randy's other mismatch fixes? It would be
> nice to eliminate them for the final release.
> 

spose so.  At least, the ones which fix bugs.
