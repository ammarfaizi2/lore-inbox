Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWEYSNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWEYSNw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWEYSNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:13:52 -0400
Received: from xenotime.net ([66.160.160.81]:40847 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030311AbWEYSNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:13:52 -0400
Date: Thu, 25 May 2006 11:16:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@pardus.org.tr>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scx200_acb: fix section mismatch warning
Message-Id: <20060525111624.a647390f.rdunlap@xenotime.net>
In-Reply-To: <4475F314.9060308@pardus.org.tr>
References: <20060525100138.cb9e53c5.rdunlap@xenotime.net>
	<20060525192657.081c8c11.khali@linux-fr.org>
	<20060525110627.3461937f.akpm@osdl.org>
	<4475F314.9060308@pardus.org.tr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2006 21:10:28 +0300 İsmail Dönmez wrote:

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

Well this one got quick review/feedback/ack by maintainer.
The others need something like that too....

---
~Randy
