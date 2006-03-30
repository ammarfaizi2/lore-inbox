Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWC3I0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWC3I0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWC3I0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:26:25 -0500
Received: from ns2.suse.de ([195.135.220.15]:16557 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932111AbWC3I0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:26:24 -0500
Date: Thu, 30 Mar 2006 10:26:13 +0200
From: Karsten Keil <kkeil@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Jan Harkes <jaharkes@cs.cmu.edu>, Jan Kara <jack@suse.cz>,
       David Woodhouse <dwmw2@infradead.org>,
       Sridhar Samudrala <sri@us.ibm.com>
Subject: Re: [patch 3/8] use list_add_tail() instead of list_add()
Message-ID: <20060330082613.GD29247@pingi.kke.suse.de>
Mail-Followup-To: Akinobu Mita <mita@miraclelinux.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	Jan Harkes <jaharkes@cs.cmu.edu>, Jan Kara <jack@suse.cz>,
	David Woodhouse <dwmw2@infradead.org>,
	Sridhar Samudrala <sri@us.ibm.com>
References: <20060330081605.085383000@localhost.localdomain> <20060330081730.068972000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330081730.068972000@localhost.localdomain>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15.7-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 04:16:08PM +0800, Akinobu Mita wrote:

This patch converts list_add(A, B.prev) to list_add_tail(A, &B)
for readability.

Acked-by: Karsten Keil <kkeil@suse.de>
for the ISDN/CAPI part.


CC: Jan Harkes <jaharkes@cs.cmu.edu>
CC: Jan Kara <jack@suse.cz>
CC: David Woodhouse <dwmw2@infradead.org>
CC: Sridhar Samudrala <sri@us.ibm.com>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 drivers/isdn/capi/capi.c |    2 +-
 fs/coda/psdev.c          |    2 +-
 fs/coda/upcall.c         |    2 +-
 fs/dcache.c              |    2 +-
 fs/dquot.c               |    4 ++--
 fs/jffs2/compr.c         |    4 ++--
 net/sctp/outqueue.c      |    2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

Index: 2.6-git/drivers/isdn/capi/capi.c
===================================================================
--- 2.6-git.orig/drivers/isdn/capi/capi.c
+++ 2.6-git/drivers/isdn/capi/capi.c
@@ -238,7 +238,7 @@ static struct capiminor *capiminor_alloc
 		
 		if (minor < capi_ttyminors) {
 			mp->minor = minor;
-			list_add(&mp->list, p->list.prev);
+			list_add_tail(&mp->list, &p->list);
 		}
 	}
 		write_unlock_irqrestore(&capiminor_list_lock, flags);



-- 
Karsten Keil
SuSE Labs
ISDN development
