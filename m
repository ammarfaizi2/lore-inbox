Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSIEVuq>; Thu, 5 Sep 2002 17:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318152AbSIEVuq>; Thu, 5 Sep 2002 17:50:46 -0400
Received: from hermes.domdv.de ([193.102.202.1]:35849 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S318138AbSIEVup>;
	Thu, 5 Sep 2002 17:50:45 -0400
Message-ID: <3D77B43B.7000506@domdv.de>
Date: Thu, 05 Sep 2002 21:44:59 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Linux-LVM@sistina.com
Subject: 2.4.20pre5 CONFIG_BLK_STATS breaks LVM tools
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_BLK_STATS is enabled in 2.4.20pre5 this breaks at least the
LVM tools. The symptom on a system running initrd to do vgscan/vgchange
to be able to boot is that after

RAMDISK: Compressed image found at block 0
Freeing initrd memory: 734k freed
VFS: Mounted root (ext2 filesystem).

the system hangs with the CPU under load. It is difficult for me to
investigate this further as both systems I do have available run a
LVM/reiserfs only setup and thus I can't have a look at the layout of
/proc/partitions in the CONFIG_BLK_STATS enabled page.

It would, however, be worth a word of warning in Configure.help that
this option can break userspace tools that may be important for system
boot and other system functions.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH



