Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267320AbUGNIXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267320AbUGNIXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 04:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267318AbUGNIXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 04:23:44 -0400
Received: from [211.152.157.138] ([211.152.157.138]:48821 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S267320AbUGNIXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 04:23:38 -0400
Date: Wed, 14 Jul 2004 16:13:57 +0800
From: Hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org, bcollins@debian.org
Subject: Re: [PATCH] fix rmmod sbp2 hang in 2.6.7
Message-Id: <20040714161357.426b5c08@localhost>
In-Reply-To: <20040714114854.29d4e015@localhost>
References: <20040714114854.29d4e015@localhost>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Checked: Checked
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004 11:48:54 +0800
Hugang <hugang@soulinfo.com> wrote:

| Hi:
| 
|  http://sourceforge.net/mailarchive/forum.php?thread_id=5036991&forum_id=5389
| 
| * modified files
| 
| --- orig/drivers/base/driver.c
| +++ mod/drivers/base/driver.c
| @@ -106,8 +106,8 @@
|  
|  void driver_unregister(struct device_driver * drv)
|  {
| -	bus_remove_driver(drv);
|  	down(&drv->unload_sem);
| +	bus_remove_driver(drv);
|  	up(&drv->unload_sem);
|  }
|  

Sorry, the above patch, can't fix rmmod sbp2 complete,I still got hang when
rmmod sbp2 in my PowerBook G4 sometimes.

-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
