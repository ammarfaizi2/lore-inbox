Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbTFCM6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbTFCM6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:58:47 -0400
Received: from [211.167.76.68] ([211.167.76.68]:51357 "HELO soulinfo")
	by vger.kernel.org with SMTP id S264992AbTFCM6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:58:45 -0400
Date: Tue, 3 Jun 2003 21:11:56 +0800
From: hugang <hugang@soulinfo.com>
To: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: software suspend in 2.5.70-mm3.
Message-Id: <20030603211156.726366e7.hugang@soulinfo.com>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= Pavel Machek <pavel@suse.cz>
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel Machek:

I try the 2.5.70-mm3 with software suspend function. When suspend it will oops at ide-disk.c 1526 line
   BUG_ON (HWGROUP(drive)->handler);

I'm disable this check, The software suspend can work, and also can resumed. But this fix is not best way. I found in ide-io.c 1196
   hwgroup->handler = NULL;
is the problem.

thanks.

-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
http://soulinfo.com/~hugang/HuGang.asc
ICQ#         : 205800361
Registered Linux User : 204016
