Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbSKFWmY>; Wed, 6 Nov 2002 17:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266185AbSKFWmX>; Wed, 6 Nov 2002 17:42:23 -0500
Received: from [208.49.22.194] ([208.49.22.194]:42428 "EHLO mail.atvideo.com")
	by vger.kernel.org with ESMTP id <S266186AbSKFWld>;
	Wed, 6 Nov 2002 17:41:33 -0500
From: "Frank Wang" <frank@atvideo.com>
To: <redhat-list@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: devfs, input event system, and kernel configuration.
Date: Wed, 6 Nov 2002 14:50:21 -0800
Message-ID: <002401c285e6$e32acb00$3d00000a@atvideo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to attach a special serial input device to an X application.
Looking at the kernel document, it seems to me the input core system (the
/dev/input/event#) fits the my needs nicely.  I also realize that the input
system uses the devfs rather than the traditional major/minor number for its
device driver.

So I configured a 2.4.18-5 kernel with the following flags turned on,

	- devfs turned on,
	- the input core module,
	- the input core's keyboard and mouse modules
	- the input core's event modules

The kernel compiles fine.  However, during boot process, everything under
the /var/* and several device mounts were marked as read-only and thus the
kernel fails to boot.  I tried to set the devfs=nomount as its boot
parameter.  It didn't help either.

Thanks in advance!

Frank Wang @ Advanced Technology Video Inc.

