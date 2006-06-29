Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWF2TVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWF2TVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWF2TV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:21:29 -0400
Received: from [141.84.69.5] ([141.84.69.5]:27152 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932270AbWF2TUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:20:52 -0400
Date: Thu, 29 Jun 2006 21:20:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Eric.Moore@lsil.com
Cc: linux-kernel@vger.kernel.org, mpt_linux_developer@lsil.com,
       linux-scsi@vger.kernel.org
Subject: [-mm patch] drivers/message/fusion/mptsas.c: make 2 functions static
Message-ID: <20060629192010.GP19712@stusta.de>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629013643.4b47e8bd.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 01:36:43AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm3:
>...
>  git-scsi-misc.patch
>...
>  git trees.
>...

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/message/fusion/mptsas.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm4-full/drivers/message/fusion/mptsas.c.old	2006-06-29 14:54:36.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/message/fusion/mptsas.c	2006-06-29 14:54:51.000000000 +0200
@@ -337,7 +337,7 @@
 }
 
 /* no mutex */
-void
+static void
 mptsas_port_delete(struct mptsas_portinfo_details * port_details)
 {
 	struct mptsas_portinfo *port_info;
@@ -438,7 +438,7 @@
  * Updates for new and existing narrow/wide port configuration
  * in the sas_topology
  */
-void
+static void
 mptsas_setup_wide_ports(MPT_ADAPTER *ioc, struct mptsas_portinfo *port_info)
 {
 	struct mptsas_portinfo_details * port_details;

