Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbUBDU20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUBDUZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:25:56 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:13318 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266549AbUBDUZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:25:25 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Wed, 4 Feb 2004 23:20:20 +0300
To: linux-kernel@vger.kernel.org
Subject: Strange display artefacts on boot with modular IDE + VESA fb
Message-ID: <20040204202020.GA3944@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running with VESA fb (the only driver selected, vga=788) and modular IDE
loaded out of initrd (piix driver) after outputting message

"RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize"

cursor jumps to the first screen line ans stays there; all other kernel
messages appear on the single first line. This continues until
/sbin/setsysfont is called out of rc.sysinit then display reverts to
normal.

booting with vga=normal does not show this problem; nor compiling kernel
with built in IDE. Observed on 2.6.2-rc2-mm2, 2.6.2-rc3-mm1, 2.6.2

kernel is SMP, preemption on single CPU system, GF2MX video, i815
shipset.

-andrey
