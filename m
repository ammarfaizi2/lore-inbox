Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSLFQmc>; Fri, 6 Dec 2002 11:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSLFQmO>; Fri, 6 Dec 2002 11:42:14 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2835 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264786AbSLFQlm>;
	Fri, 6 Dec 2002 11:41:42 -0500
Date: Fri, 6 Dec 2002 08:48:54 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PNP driver changes for 2.5.50
Message-ID: <20021206164854.GC10376@kroah.com>
References: <20021206164522.GA10376@kroah.com> <20021206164802.GB10376@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206164802.GB10376@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.837.4.2, 2002/12/05 23:31:41-06:00, ambx1@neo.rr.com

[PATCH] PnP bugfix

I forgot the errno.h.  Without this patch, things may not compile when
pnp support or pnp card support is disabled.

Hope you had a good trip.  I noticed a small mistake in pnp 0.93 and I have
a fix for it.


diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Fri Dec  6 10:38:37 2002
+++ b/include/linux/pnp.h	Fri Dec  6 10:38:37 2002
@@ -11,6 +11,7 @@
 
 #include <linux/device.h>
 #include <linux/list.h>
+#include <linux/errno.h>
 
 
 /*
