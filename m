Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268149AbUI2CT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbUI2CT7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 22:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUI2CT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 22:19:59 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:21993 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268149AbUI2CT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 22:19:57 -0400
Cc: linux-kernel@vger.kernel.org
In-Reply-To: 
X-Mailer: roland_patchbomb
Date: Tue, 28 Sep 2004 19:19:33 -0700
Message-Id: <200409281919.Xvizfpbjxoiv0MeE@topspin.com>
Mime-Version: 1.0
To: greg@kroah.com, pj@sgi.com
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][0/2] [take 2] Hotplug variable patches
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 29 Sep 2004 02:19:34.0231 (UTC) FILETIME=[C2BC3E70:01C4A5CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's an updated version of my hotplug environment variable patch.
Based on Paul Jackson's suggestion, I switched the helper from a macro
to a function.

When I wanted to implement some environment variables in my hotplug
method, I looked for an example of how to do it.  I noticed two
things: adding values ends up being kind of messy, and the hotplug
method in drivers/usb/core/usb.c is subtly wrong!  These two patches
attempt to fix both of those problems.

If you apply these, I'll send patches to use add_hotplug_env_var() in
net/, drivers/ieee1394/, etc.

Thanks,
  Roland

