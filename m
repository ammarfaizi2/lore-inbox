Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWGPVMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWGPVMd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 17:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWGPVMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 17:12:33 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:27663 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751204AbWGPVMc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 17:12:32 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: Linux v2.6.18-rc2 | UTS Release version does not match current version
Date: Sun, 16 Jul 2006 22:12:58 +0100
User-Agent: KMail/1.9.3
Cc: Michael Krufky <mkrufky@linuxtv.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manoj Srivastava <srivasta@debian.org>
References: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org> <44BA4E5E.7060803@linuxtv.org> <20060716203600.GZ11640@ca-server1.us.oracle.com>
In-Reply-To: <20060716203600.GZ11640@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607162212.58880.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 July 2006 21:36, Joel Becker wrote:
> On Sun, Jul 16, 2006 at 10:34:06AM -0400, Michael Krufky wrote:
> > I get this when building using debian's make-kpkg:
> >
> > The UTS Release version in include/linux/version.h
> >     ""
> > does not match current version:
> >     "2.6.18-rc2"
> > Please correct this.
>
> 	make-kpkg uses version.h to get UTS_RELEASE.  UTS_RELEASE has
> moved to utsrelease.h.
>
> Right after you get the error, modify
> debian/ruleset/misc/version_vars.mk
>
> -UTS_RELEASE_VERSION=$(shell if [ -f include/linux/version.h ]; then	 \
> -                 grep 'define UTS_RELEASE' include/linux/version.h | \
> +UTS_RELEASE_VERSION=$(shell if [ -f include/linux/utsrelease.h ]; then	 \
> +                 grep 'define UTS_RELEASE' include/linux/utsrelease.h | \
>
>
> And rerun your make-kpkg.  The above is not a valid patch, you'll have
> to hand change it.

It's probably worth letting somebody an upstream Debian maintainer know about 
this, so that Etch can inherit it (CCed).

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
