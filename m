Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUIASk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUIASk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUIASk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:40:56 -0400
Received: from av7-2-sn1.fre.skanova.net ([81.228.11.114]:26838 "EHLO
	av7-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S266850AbUIASku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 14:40:50 -0400
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>, Nigel Kukard <nkukard@lbsd.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] DVD+RW support for 2.6.7-bk13
References: <m2hdsr6du0.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 01 Sep 2004 20:40:42 +0200
In-Reply-To: <m2hdsr6du0.fsf@telia.com>
Message-ID: <m34qmhest1.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> This patch adds support for using DVD+RW drives as writable block
> devices under the 2.6.7-bk13 kernel.
> 
> The patch is based on work from:
> 
>         Andy Polyakov <appro@fy.chalmers.se> - Wrote the 2.4 patch
>         Nigel Kukard <nkukard@lbsd.net> - Initial porting to 2.6.x
...
>  linux-petero/drivers/cdrom/cdrom.c |   80 +++++++++++++++++++++++++++++++++++++
>  linux-petero/drivers/ide/ide-cd.c  |    2 
>  linux-petero/drivers/scsi/sr.c     |    1 
>  linux-petero/include/linux/cdrom.h |    2 

Nigel pointed out that the earlier patches contained attributions that
are not present in this patch. The 2.4 patch contains:

  Nov 5 2001, Aug 8 2002. Modified by Andy Polyakov
  <appro@fy.chalmers.se> to support MMC-3 complaint DVD+RW units.

and Nigel changed it to this in his 2.6 patch:

  Modified by Nigel Kukard <nkukard@lbsd.net> - support DVD+RW
  2.4.x patch by Andy Polyakov <appro@fy.chalmers.se>

The patch I sent you deleted most of the earlier work and moved the
rest to cdrom.c, but the comments were not moved over, since the
earlier authors didn't modify cdrom.c.

Nigel wants to get credit for his work though, so were should we put
those messages? Is this patch acceptable?


 linux-petero/drivers/cdrom/cdrom.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN drivers/cdrom/cdrom.c~packet-copyright drivers/cdrom/cdrom.c
--- linux/drivers/cdrom/cdrom.c~packet-copyright	2004-09-01 20:03:13.075394816 +0200
+++ linux-petero/drivers/cdrom/cdrom.c	2004-09-01 20:31:57.282275528 +0200
@@ -234,6 +234,12 @@
   -- Mt Rainier support
   -- DVD-RAM write open fixes
 
+  Nov 5 2001, Aug 8 2002. Modified by Andy Polyakov
+  <appro@fy.chalmers.se> to support MMC-3 compliant DVD+RW units.
+
+  Modified by Nigel Kukard <nkukard@lbsd.net> - support DVD+RW
+  2.4.x patch by Andy Polyakov <appro@fy.chalmers.se>
+
 -------------------------------------------------------------------------*/
 
 #define REVISION "Revision: 3.20"
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
