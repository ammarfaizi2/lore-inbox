Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbTIJQwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTIJQwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:52:06 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:41033 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S265229AbTIJQwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:52:03 -0400
Subject: Re: Fw: Make Menuconfig and Make Xconfig errors in Mandrake 9.2 rc1
From: Steven Cole <elenstev@mesatop.com>
To: Anton Kholodenin <cicprogr@mail.dux.ru>
Cc: linux-kernel@vger.kernel.org, Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <01ec01c37763$89f183c0$370101c8@antontest>
References: <01ec01c37763$89f183c0$370101c8@antontest>
Content-Type: text/plain
Organization: 
Message-Id: <1063212461.1663.139.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 10 Sep 2003 10:47:41 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 00:19, Anton Kholodenin wrote:
> File /usr/src/linux/3rdparty/lufs/Config.in contains only one line:
> 
> dep_tristate 'LUFS support' CONFIG_LUFS
> 
> I have attached Config.in and all files from lufs folder in the message.
> 
> Best regadrs
> Anton Kholodenin.

Apologies again for the noise.  This should be going to a Mandrake list,
but this is short and sweet.  Adding Juan Q. to cc-list.

It's still broken in 2.4.22-6mdk.  You'll get something like this when
you do make xconfig:

./tkparse < ../arch/i386/config.in >> kconfig.tk
3rdparty/lufs/Config.in: 2: unknown command

This will fix it:

--- linux-2.4.22-6mdk/3rdparty/lufs/Config.in.brokenasusual	2003-09-10 10:34:27.000000000 -0600
+++ linux-2.4.22-6mdk/3rdparty/lufs/Config.in	2003-09-10 10:36:27.000000000 -0600
@@ -1,2 +1,2 @@
 
-xtristate 'LUFS support' CONFIG_LUFS
+tristate 'LUFS support' CONFIG_LUFS



Steven



