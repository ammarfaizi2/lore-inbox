Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271898AbTHHUwU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 16:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271938AbTHHUwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 16:52:20 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:33040 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S271898AbTHHUwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 16:52:17 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: "H. J. Lu" <hjl@lucon.org>
Subject: Re: Initrd problem with 2.6 kernel
Date: Sat, 9 Aug 2003 00:52:40 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308090052.40940.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a chicken and egg problem with initrd on 2.6. When
> root=/dev/xxx is passed to kernel, kernel will call try_name, which
> uses /sys/block/drive/dev, to find out the device number for ROOT_DEV.
> The problem is /sys/block/drive may not exist if the driver is loaded
> by /linuxrc in initrd. As the result, /linuxrc can't use
> /proc/sys/kernel/real-root-dev to determine the root device number.

{pts/1}% grep \"/sys\" *
do_mounts.c:    sys_mkdir("/sys", 0700);
do_mounts.c:    if (sys_mount("sysfs", "/sys", "sysfs", 0, NULL) < 0)
do_mounts.c:    sys_umount("/sys", 0);
do_mounts.c:    sys_rmdir("/sys");

or do you mean something different?

-andrey
