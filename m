Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270827AbTHNQ2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270810AbTHNQ2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:28:48 -0400
Received: from maja.beep.pl ([195.245.198.10]:40721 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S270827AbTHNQ2n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:28:43 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: finding which pci device works as ide controller for root fs
Date: Thu, 14 Aug 2003 18:26:30 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308141826.30735.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need /dev/hdX -> pci id mapping for geninitrd script - with modular IDE I 
need to load some IDE controller driver from initrd to mount root fs.

Now I'm loading all modules for IDE devices found from:
awk ' { print $2 } ' /proc/bus/pci/devices
+ simple file which maps PCI ID to module name like
808684cb piix

How to find controller which is used for root fs (and do not load other 
modules)? I suppose that on 2.4 this is impossible from userspace but on 2.6 
maybe sysfs will be useful.

[arekm@mobarm arekm]$ ls -l /sys/block/hda/device
lrwxrwxrwx    1 root     root           46 2003-08-14 00:49 
/sys/block/hda/device -> ../../devices/pci0000:00/0000:00:11.1/ide0/0.0

Is it possible to get PCI ID from sysfs for specified device?

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm@sse.pl   AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

