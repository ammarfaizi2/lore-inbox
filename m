Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWAWNPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWAWNPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWAWNPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:15:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:40647 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751437AbWAWNPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:15:55 -0500
Message-ID: <43D4D708.2050802@suse.de>
Date: Mon, 23 Jan 2006 14:15:52 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: kbuild: problems with separate src/obj trees
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Trapped into two problems with 2.6.16-rc1:

  (1) Building kernels with the source tree on a r/o filesystem
      doesn't work any more because kbuild tries to create
      $(srctree)/.kernelrelease and fails to do so.

  (2) UML kernels don't build at all with a separate obj tree:

master-xen kraxel ~/objtree/vanilla-2.6.16-pre-um# make ARCH=um
gmake -C /home/kraxel/scratch/vanilla-2.6.16-pre
O=/home/kraxel/objtree/vanilla-2.6.16-pre-um
  SYMLINK arch/um/include/kern_constants.h
ln: creating symbolic link `arch/um/include/kern_constants.h' to
`../../../include/asm-um/asm-offsets.h': No such file or directory
gmake[2]: *** [arch/um/include/kern_constants.h] Error 1
gmake[1]: *** [cdbuilddir] Error 2
gmake: *** [all] Error 2

Ideas/Patches anyone?

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
