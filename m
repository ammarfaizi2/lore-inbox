Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUIUU5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUIUU5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268069AbUIUU5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:57:36 -0400
Received: from peabody.ximian.com ([130.57.169.10]:56705 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268070AbUIUU4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:56:12 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095792996.4944.59.camel@betsy.boston.ximian.com>
References: <1095652572.23128.2.camel@vertex>
	 <1095782674.4944.41.camel@betsy.boston.ximian.com>
	 <1095792996.4944.59.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Tue, 21 Sep 2004 16:55:01 -0400
Message-Id: <1095800101.5090.10.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 14:56 -0400, Robert Love wrote:

> I then went ahead and just made dev->bitmask an array, since we know the
> size at compile time.

Forgot to remove the kfree() there, which I did not hit in testing until
now.

This patch applies on top of the previous.

	Robert Love


Signed-Off-By: Robert "Cheese Taste Good" Love <rml@novell.com>

 drivers/char/inotify.c |    1 -
 1 files changed, 1 deletion(-)

--- linux-inotify-rml/drivers/char/inotify.c.orig	2004-09-21 16:50:00.643770936 -0400
+++ linux-inotify-rml/drivers/char/inotify.c	2004-09-21 16:50:45.118009824 -0400
@@ -711,7 +711,6 @@
 
 		inotify_release_all_events(dev);
 
-		kfree (dev->bitmask);
 		kfree (dev);
 
 	}


