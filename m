Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWIIOwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWIIOwh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWIIOwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:52:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25226 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932235AbWIIOwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:52:36 -0400
Subject: Re: patch [0/2]: acpi: add generic removable drive bay support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
In-Reply-To: <20060907161305.67804d14.kristen.c.accardi@intel.com>
References: <20060907161305.67804d14.kristen.c.accardi@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 16:15:44 +0100
Message-Id: <1157814944.6877.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-07 am 16:13 -0700, ysgrifennodd Kristen Carlson Accardi:
> the exact same event for either insertion or removal (i.e. the Dell M65 for
> example).  Same scripts for using these events and udev can be found on the
> thinkwiki website:
> 
> http://www.thinkwiki.org/wiki/How_to_hotswap_UltraBay_devices#When_using_the_ata
> _piix_driver

drivers/ide/piix does not support hotplug of any kind. drivers/ide does
not support hotplug of any kind. There is an ioctl hack that vaguely
works now and then for some interfaces but it too is completely unsafe
in 2.6 except for RHEL4. If people keep trying to post suggestions to
use them for anything but debugging I'm going to have to send Andrew
patches to remove them entirely before more people lose their data.

RHEL4 has a set of locking changes/patches to support some basic hotplug
cases, they were refused upstream so upstream simply doesn't support it.

Alan

