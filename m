Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTLXQti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 11:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbTLXQti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 11:49:38 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:8635 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263679AbTLXQtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 11:49:35 -0500
Subject: Re: 2.6 unknown partition table
From: Christophe Saout <christophe@saout.de>
To: Shane Shrybman <shrybman@aei.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1072277542.10203.14.camel@mars.goatskin.org>
References: <1072277542.10203.14.camel@mars.goatskin.org>
Content-Type: text/plain
Message-Id: <1072284569.4710.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Dec 2003 17:49:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, den 24.12.2003 schrieb Shane Shrybman um 15:52:

> I noticed this in the logs yesterday on 2.6.0-test11-mm1 and upgraded to
> 2.6.0-mm1, but its still there. I use LVM on that disk and it is working
> fine, (LV file systems are mountable and useable).
>
> Advice?
> 
> # fdisk -l /dev/hdg
> [...]
> Disk /dev/hdg doesn't contain a valid partition table
>
> [...]
> vgdisplay  PV Name               /dev/hdg     

Everything is fine. You put your physical volume directly on the
harddisk, not in a partition, so you don't have a partition table.
vgscan recognizes the hard disk itself as LVM physical volume anyway
that's why it works.

If you want to get rid of this, the next time you create a PV please
create a partition first with fdisk, e.g. /dev/hdg1 with type 8e (LVM)
and then pvcreate /dev/hdg1.

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

