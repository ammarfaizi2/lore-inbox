Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbUCCC2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 21:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUCCC2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 21:28:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:53405 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262323AbUCCC2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 21:28:40 -0500
Date: Tue, 2 Mar 2004 18:28:34 -0800
From: Chris Wright <chrisw@osdl.org>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.3] Sysfs breakage - tun.ko
Message-ID: <20040302182834.R22989@build.pdx.osdl.net>
References: <4043938C.9090504@lbsd.net> <40439B03.4000505@backtobasicsmgmt.com> <20040302060251.GG21950@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040302060251.GG21950@lbsd.net>; from nkukard@lbsd.net on Tue, Mar 02, 2004 at 08:02:51AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nigel Kukard (nkukard@lbsd.net) wrote:
> 
> Nothing said solves the problem, the problem has got nothing to do with
> devfs (only for compat reasons), the problem is that "net/tun" breaks
> sysfs.

Yes, why does this not work?  Keeps devfs legacy name, works fine with
udev, and makes proper dir in sysfs.

thanks,
-chris

===== drivers/net/tun.c 1.29 vs edited =====
--- 1.29/drivers/net/tun.c	Sat Jan 10 16:09:09 2004
+++ edited/drivers/net/tun.c	Tue Mar  2 12:05:30 2004
@@ -602,7 +602,8 @@
 
 static struct miscdevice tun_miscdev = {
 	.minor = TUN_MINOR,
-	.name = "net/tun",
+	.name = "tun",
+	.devfs_name = "net/tun",
 	.fops = &tun_fops
 };
 
