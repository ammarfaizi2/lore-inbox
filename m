Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbUBVAiW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 19:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbUBVAiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 19:38:22 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:23711 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261633AbUBVAiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 19:38:20 -0500
Date: Sat, 21 Feb 2004 19:21:07 -0500
From: Ben Collins <bcollins@debian.org>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: drivers/ieee1394/sbp2.c:734: error: `host' undeclared (first use in this function) 2.6.3-bk3
Message-ID: <20040222002107.GB6006@phunnypharm.org>
References: <1077399402.22141.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077399402.22141.86.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 02:36:43PM -0700, Bob Gill wrote:
> Hi.  The whole error message is (when building 2.6.3-bk3):
> drivers/ieee1394/sbp2.c: In function `sbp2_alloc_device':
> drivers/ieee1394/sbp2.c:734: error: `host' undeclared (first use in this
> function)
> drivers/ieee1394/sbp2.c:734: error: (Each undeclared identifier is
> reported only once
> drivers/ieee1394/sbp2.c:734: error: for each function it appears in.)
> make[2]: *** [drivers/ieee1394/sbp2.o] Error 1
> make[1]: *** [drivers/ieee1394] Error 2
> make: *** [drivers] Error 2

Disable CONFIG_IEEE1394_SBP2_PHYS_DMA. I'll have this fixed next time I
sync with Linus. Really, CONFIG_IEEE1394_SBP2_PHYS_DMA is for debugging
only, and you shouldn't have it enabled.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
