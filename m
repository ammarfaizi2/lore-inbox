Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVD0PFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVD0PFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVD0PFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:05:33 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:24495 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261705AbVD0PF3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:05:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ITOnrfOnkVxy7Lji5tpHiZpyj4BMfd14E0oftVmWNXl9yRWFjdOPflTYERmolsIe2+5Eg+cJOnuMgXeM6yfmqbHVBXIQjrLncBulVyxrKev9mvi2EGghuN6okfno+6SJOVD+YT8Bc4QF+zEwHgFqJGsGw+dm3bQKM0ABZyzsmG0=
Message-ID: <699a19ea050427080545fb1676@mail.gmail.com>
Date: Wed, 27 Apr 2005 20:35:28 +0530
From: k8 s <uint32@gmail.com>
Reply-To: k8 s <uint32@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Doubt Regarding Multithreading and Device Driver
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I have a doubt regarding user space threads and device drivers
implementation issue.

I have a device driver for /dev/skn
It implements basic driver operations skn_open,skn_release, skn_ioctl.

I am storing something into struct file*filp->private_data.
As this is not shared across processes I am not doing any locking
stuff while accessing or putting anything into it.

Will There be a race condition in a multithreaded program in the ioctl
call on smp kernel accessing filp->private_data.

S.Kartikeyan
