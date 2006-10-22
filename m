Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWJVRmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWJVRmr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWJVRmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:42:47 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:46311 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751775AbWJVRmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:42:46 -0400
To: balagi@justmail.de
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 2.6.19-rc2-mm2 pktcdvd: add sysfs and debugfs interface
References: <op.tht1yvsaiudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 22 Oct 2006 19:42:34 +0200
In-Reply-To: <op.tht1yvsaiudtyh@master>
Message-ID: <m3vemcdz79.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> this patch adds a sysfs and debugfs interface
> to the pktcdvd driver.
> The procfs interface is not modified!

Calling the character device interface "procfs interface" is
misleading, so I disagree with this part of the patch:

+  Note: pktsetup uses the pktcdvd procfs interface!

The only connection pktsetup has with procfs is that it reads the
character device minor number from /proc/misc. If that number was
available somewhere else or if udev created /dev/pktcdvd/control
automatically, pktsetup wouldn't need /proc at all.

Actually, checking my FC5 installation, /dev/pktcdvd/control is
created automatically when the driver is loaded, so the /proc code in
pktsetup is only needed to cope with older distributions.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
