Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264341AbTKMQfy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 11:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264342AbTKMQfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 11:35:54 -0500
Received: from services3.virtu.nl ([217.114.97.6]:40601 "EHLO
	services3.virtu.nl") by vger.kernel.org with ESMTP id S264341AbTKMQfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 11:35:52 -0500
Message-Id: <5.1.0.14.2.20031113171537.01ee82c8@services3.virtu.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 13 Nov 2003 17:32:49 +0100
To: linux-kernel@vger.kernel.org
From: Remco van Mook <remco@virtu.nl>
Subject: 2.4 odd behaviour of ramdisk + cramfs
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Virtu-MailScanner-VirusCheck: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am experiencing a problem when I try to run the following script:

#! /bin/sh
cat /flash/modules-2.4.21 > /dev/ram1
mount -t cramfs -o ro /dev/ram1 /lib/modules

Running it once causes the mount to fail with 'cramfs: wrong magic' - 
running it twice will make mount succeed on the second try.

Oddly enough, repeating the 2 lines within the script doesn't work either.

The behaviour has been reproduced by several people with different 2.4 
kernels.

As I need this to go into some boot scripts, I'd like this to work without 
human intervention.

Any suggestions ?

Remco van Mook

Typical kernel config:
2.4.21 unpatched kernel tree
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

