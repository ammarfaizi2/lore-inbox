Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVCNIAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVCNIAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVCNIAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:00:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60897 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261336AbVCNIAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:00:46 -0500
Date: Mon, 14 Mar 2005 09:00:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de,
       rjw@sisk.pl
Subject: Re: Call for help: list of machines with working S3
Message-ID: <20050314080029.GF22635@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <200503140719.01536.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503140719.01536.lkml@kcore.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   * MySQL (hinders the actual suspension process and kicks the pc back to 
>     where it was)

Try this patch...
								Pavel

--- clean/kernel/signal.c	2005-02-03 22:27:26.000000000 +0100
+++ linux/kernel/signal.c	2005-02-03 22:28:19.000000000 +0100
@@ -2222,6 +2222,7 @@
 			ret = -EINTR;
 	}
 
+	try_to_freeze(1);
 	return ret;
 }
 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
