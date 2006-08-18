Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWHRRNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWHRRNu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWHRRNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:13:50 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:6614 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030291AbWHRRNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:13:49 -0400
Date: Fri, 18 Aug 2006 19:13:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg Schafer <gschafer@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's in kbuild.git for 2.6.19
Message-ID: <20060818171335.GA7595@mars.ravnborg.org>
References: <20060813194503.GA21736@mars.ravnborg.org> <pan.2006.08.18.08.26.03.994311@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2006.08.18.08.26.03.994311@zip.com.au>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 06:26:07PM +1000, Greg Schafer wrote:
> On Sun, 13 Aug 2006 21:45:03 +0200, Sam Ravnborg wrote:
> 
> > Just a quick intro to what is pending in kbuild.git/lxdialog.git for 2.6.19.
> > And a short status too.
> > 
> > Highlights:
> > 	o unifdef is now included in the kernel source (used by
> > 	  headers_* targets).
> 
> Hi Sam,
> 
> This apparently doesn't build:
> 
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/docproc
>   HOSTCC  scripts/unifdef
> /tmp/ccwcmPxS.o: In function `keywordedit':
> unifdef.c:(.text+0x25c): undefined reference to `strlcpy'
> collect2: ld returned 1 exit status
> make[1]: *** [scripts/unifdef] Error 1
> make: *** [headers_install] Error 2

When I grep in the unifdef sources I get only one reference to strlcpy.
That's a prototype that was missed when I replaced the use of strlcpy
with a dedicated implementation.

I have checked latest -mm - same result.
Try to doublecheck that you have properly updated your source tree.

	Sam
