Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTEaOsl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 10:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTEaOsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 10:48:41 -0400
Received: from zork.zork.net ([64.81.246.102]:30096 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264491AbTEaOsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 10:48:40 -0400
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm3: LVM/device-mapper seems broken
References: <20030531013716.07d90773.akpm@digeo.com>
	<6u4r3bky20.fsf@zork.zork.net>
	<1054390711.13115.1.camel@chtephan.cs.pocnet.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Christophe Saout <christophe@saout.de>,
 linux-kernel@vger.kernel.org
Date: Sat, 31 May 2003 16:01:54 +0100
In-Reply-To: <1054390711.13115.1.camel@chtephan.cs.pocnet.net> (Christophe
 Saout's message of "31 May 2003 16:18:31 +0200")
Message-ID: <6uznl3jh25.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> writes:

> Am Sam, 2003-05-31 um 16.09 schrieb Sean Neakums:
>
>> On booting 2.5.70-mm3, only one of the six logical volumes in my
>> volume group is activated.  2.5.70 works fine.  dmesg and .config
>> appended below.
>
> You need to recompile libdevmapper against the new kernel headers. The
> kdev_t size has changed and unfortunately the old ioctl interface
> exposed this limited one to the userspace.

Aha.

The 64-bit device number patch reverses cleanly, so I think I'll just
build without it and try again.

