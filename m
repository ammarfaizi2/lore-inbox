Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTJWKuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 06:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbTJWKuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 06:50:50 -0400
Received: from main.gmane.org ([80.91.224.249]:48620 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263504AbTJWKus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 06:50:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Holger Schurig <h.schurig@mn-logistik.de>
Subject: [PATCH] "/sys/devices/legacy" is an offending term
Date: Thu, 23 Oct 2003 12:50:42 +0200
Message-ID: <bn8bq2$588$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   echo 50 > /sys/devices/legacy/sa1100fb/brightness
 
Is there any change to get rid of this "legacy"?  From my (still quite 
limited) understanding of the english language, this means old/outdated 
and has a not-so-good connotation. It's not just a fact, but puts a 
negative value into something. But maybe I'm wrong.
 
Anyway, on embedded arches it makes no sense to say "Oh, PCI is all wow, 
non-pci is all boo".


I talked on the arm-linux-kernel mailing list and Russell King answered:

> I brought this exact point up with Pat Mochel at OLS this year.  At
> the time, he agreed that it should be renamed to "platform".
>
> I don't know if such a change will now be allowed for the 2.6 series,
> since it'll effectively be a user-visible interface change.
>
> I do know that Pat is heavily overloaded with work, which probably
> explains why it hasn't happened.

In the hope that this happens I included a patch below.

If wished, I can provide a bigger patch that renames "
legacy_bus" to "legacy_bus" as well.


#
# Patch managed by http://www.mn-logistik.de/unsupported/pxa250/patcher
#

--- linux-2.6/drivers/base/platform.c~legacy-platform
+++ linux-2.6/drivers/base/platform.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>

 struct device legacy_bus = {
-       .bus_id         = "legacy",
+       .bus_id         = "platform",
 };

 /**


-- 
Try Linux 2.6 from BitKeeper for PXA2x0 CPUs at
http://www.mn-logistik.de/unsupported/linux-2.6/

