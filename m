Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSHRS4X>; Sun, 18 Aug 2002 14:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSHRS4X>; Sun, 18 Aug 2002 14:56:23 -0400
Received: from smtp3.vol.cz ([195.250.128.83]:3846 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S315607AbSHRS4X>;
	Sun, 18 Aug 2002 14:56:23 -0400
Date: Sun, 18 Aug 2002 20:56:20 +0200
From: Stanislav Brabec <utx@penguin.cz>
To: Paul Bristow <paul@paulbristow.net>
Cc: linux-kernel@vger.kernel.org
Subject: ide-floppy & devfs - /dev entry not created if drive is empty
Message-ID: <20020818185620.GA6013@utx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Paul Bristow,

I have tested ide-floppy on my Linux 2.4.19 with ATAPI ZIP 100. I am
using devfs.

I found following problem:

If module ide-floppy is loaded and no disc is present in the drive,
/dev/ide/host0/bus1/target1/lun0/disc entry is not created. Later
inserted media cannot be checked in any way, because no /dev entry
exists.

Older kernels have also this behavior.

Fix: Create .../disc entry in all cases, even if no disc is present.

-- 
Stanislav Brabec
http://www.penguin.cz/~utx
