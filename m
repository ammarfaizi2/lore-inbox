Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTL2RgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTL2RgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:36:12 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:42382 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263568AbTL2RfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:35:21 -0500
Subject: RE: ataraid in 2.6.?
From: Christophe Saout <christophe@saout.de>
To: Nicklas Bondesson <nicke@nicke.nu>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1072719337.5152.142.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Dec 2003 18:35:37 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 29.12.2003 schrieb Nicklas Bondesson um 18:27:

> How do you set this (device mapping) up using the 2.6 kernel. I like the
> ease of using ataraid in 2.4.x. Why not have both alternatives as options
> (both ataraid and devicemapper)?

I think the reason is to avoid unnecessary code duplication.
device-mapper provides a generic method to do such things. Also the
developers are heading towards removing code from the kernel that can be
done in userspace. There are plans to remove partition detection from
the kernel in 2.7 and move the detection and setup code to a userspace
program (using device-mapper) which can be placed in the initramfs (so
that the user won't notice any difference). Ataraid detection and setup
could also be placed there later.

If someone writes an ataraid detection and setup program in userspace it
could be placed on an initrd.

You can find the dmsetup tool in Sistina's device-mapper package.

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

