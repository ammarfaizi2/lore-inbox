Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbTCEFPQ>; Wed, 5 Mar 2003 00:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbTCEFPQ>; Wed, 5 Mar 2003 00:15:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:64689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267106AbTCEFPP>;
	Wed, 5 Mar 2003 00:15:15 -0500
Message-ID: <32833.4.64.238.61.1046841945.squirrel@www.osdl.org>
Date: Tue, 4 Mar 2003 21:25:45 -0800 (PST)
Subject: reducing stack usage in v4l?
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was looking at stack usage in drivers/media/video/v4l1-compat.c::
v4l_compat_translate_ioctl().  It's 0x924 bytes on my peecee.

It's fairly straightforward to change the stack space to
kmalloc() space, but some of these functions (ioctls) are
speed-critical, so I was wondering if the changes should still
be done, or done only in some cases and not others, or wait
until an oops is reported here....

Comments?

Thanks,
~Randy




