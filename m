Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbUASVtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUASVtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:49:23 -0500
Received: from mail.rdslink.ro ([193.231.236.20]:17344 "EHLO mail.rdslink.ro")
	by vger.kernel.org with ESMTP id S264905AbUASVtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:49:19 -0500
Message-ID: <400C50FA.5070809@rdslink.ro>
Date: Mon, 19 Jan 2004 23:49:46 +0200
From: "Beratco Matei jr." <mathew@rdslink.ro>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: ro, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: iswraid calling modprobe when scsi statically compiled?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the top Makefile look for the following lines:
DRIVERS-$(CONFIG_IDE) += drivers/ide/idedriver.o
DRIVERS-$(CONFIG_FC4) += drivers/fc4/fc4.a
DRIVERS-$(CONFIG_SCSI) += drivers/scsi/scsidrv.o 
These are taken from 2.4.23 patched with libata and iswraid.
You can move the line with SCSI before the one with
IDE (the rest does not matter) and recompile.

It worked for me, and i'm booting from 2 Seagate 80Gb
HDD's in RAID0 (so no modules allowed for SATA/SCSI/RAID).



