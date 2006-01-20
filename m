Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWATIdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWATIdl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWATIdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:33:41 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:36880 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1750737AbWATIdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:33:41 -0500
Date: Fri, 20 Jan 2006 09:33:26 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4.32] usb-uhci.c failing "-"
Message-ID: <Pine.LNX.4.63.0601200928480.1049@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Looks like a bug?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

Signed-off-by Guennadi Liakhovetski <g.liakhovetski@gmx.de>

--- a/drivers/usb/host/usb-uhci.c	Fri Jan 20 09:27:50 2006
+++ b/drivers/usb/host/usb-uhci.c	Fri Jan 20 09:28:05 2006
@@ -2505,7 +2505,7 @@
  			((urb_priv_t*)urb->hcpriv)->flags=0;
  		}

-		if ((urb->status != -ECONNABORTED) && (urb->status != ECONNRESET) &&
+		if ((urb->status != -ECONNABORTED) && (urb->status != -ECONNRESET) &&
  			    (urb->status != -ENOENT)) {

  			urb->status = -EINPROGRESS;
