Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTEaOFO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 10:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTEaOFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 10:05:14 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:1434 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S264328AbTEaOFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 10:05:13 -0400
Subject: Re: 2.5.70-mm3: LVM/device-mapper seems broken
From: Christophe Saout <christophe@saout.de>
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6u4r3bky20.fsf@zork.zork.net>
References: <20030531013716.07d90773.akpm@digeo.com>
	 <6u4r3bky20.fsf@zork.zork.net>
Content-Type: text/plain
Message-Id: <1054390711.13115.1.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 31 May 2003 16:18:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sam, 2003-05-31 um 16.09 schrieb Sean Neakums:

> On booting 2.5.70-mm3, only one of the six logical volumes in my
> volume group is activated.  2.5.70 works fine.  dmesg and .config
> appended below.

You need to recompile libdevmapper against the new kernel headers. The
kdev_t size has changed and unfortunately the old ioctl interface
exposed this limited one to the userspace.

-- 
Christophe Saout <christophe@saout.de>

