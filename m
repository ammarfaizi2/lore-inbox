Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVBYXgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVBYXgc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 18:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVBYXgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 18:36:32 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:42320 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262804AbVBYXg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 18:36:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=tq7Eb6aE6YbX0FhYfpZvxlzipjnQSo0FptkVaoQngG5dzKYOkxJT+H9OjDbkEjWnGpsveHtCipR/c3CDNmCOPsLHv756WVcFRixD+01r9nqSTZmO0VnlyaupzuyGLeGI2XAy+4kz1TFblwHqW1jLOl+6dUWv79aYj4RhTHlPcSI=
Message-ID: <e16ac85e050225153649939bed@mail.gmail.com>
Date: Fri, 25 Feb 2005 16:36:28 -0700
From: Greg Felix <gregfelixlkml@gmail.com>
Reply-To: Greg Felix <gregfelixlkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Intel ICH7 SATA support question for ATA_PIIX
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two new OEM machines that are both ICH7 chipsets.  
Both machines give the same vendor and device PCI ids for their
storage controllers.

8086:27df and 8086:27c0

I noticed that Jason Gaston submitted a patch that made it into
2.6.11-rc1 to add support for ICH7 into ata_piix.  I'm using
2.6.11-rc5 and am getting good results on one of my machines.

The problem I'm having is that the other machine doesn't seem to be
supported even though it appears to be the same controller (by PCI ID
at least).  My modules.pcimap file shows that x27df and x27c0 are both
mapped to the piix driver.  I'm seeing nothing in /proc/partitions.

Perhaps someone at Intel, or HP, or Jason Gaston, or Jeff Garzik even
can shed some light on this or tell me where I can look to determine a
chipset version number that can be used to differentiate the two
boxes?  I'll gladly provide any more information I've forgotten.

Also the machine that isn't working has a Broadcom Gigabit NIC that
isn't being recognized by the tg3 module.  I'm seeing no eth0 in
/sys/class/net. It's PCI ID is 14e4:1600.

Greg Felix
