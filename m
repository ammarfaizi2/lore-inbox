Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030523AbVIAXZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbVIAXZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbVIAXZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:25:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38159 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030523AbVIAXZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:25:28 -0400
Date: Fri, 2 Sep 2005 01:25:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.13-mm1: misc mwave issues
Message-ID: <20050901232526.GF3657@stusta.de>
References: <20050901035542.1c621af6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901035542.1c621af6.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 03:55:42AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc6-mm2:
>...
>  git-serial.patch
>...
>  Subsystem trees
>...

This patch contains Alan's patch for fixing the compilation of 
drivers/char/mwave/mwavedd.c, but the driver is still marked as BROKEN 
which should now be undone.

The MWAVE also got a comment
  # PLEASE DO NOT DO THIS - move this driver to drivers/serial

Since it seems this code is mostly unmaintained, can the
  mv drivers/char/mwave drivers/serial/
be done in the git-serial tree?

Additionally, drivers/char/mwave/mwavedd.c now requires an
  #include "8250.h"
for the serial8250_{,un}register_port prototypes.


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


