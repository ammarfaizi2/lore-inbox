Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbUKEXo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUKEXo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbUKEXo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:44:28 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:160 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261265AbUKEXoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:44:19 -0500
Date: Sat, 6 Nov 2004 00:44:14 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] change Kconfig entry for RAMFS
In-Reply-To: <Pine.LNX.4.58.0411051506590.2223@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.60.0411060027560.3255@alpha.polcom.net>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041105195045.GA16766@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
 <Pine.LNX.4.58.0411051406200.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411052319160.3255@alpha.polcom.net>
 <Pine.LNX.4.58.0411051506590.2223@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So at the very least you'd need to make the Kconfig understand the
> dependency on ramfs.

Should I add dependency to tmpfs on ramfs when building for embedded? Or 
should I introduce new config option to stop registering ramfs as a 
mountable filesystem?


> Also, don't shout in help-files. Nobody likes shouting.

Sorry.

For now, will you accept this patch:

Signed-off-by: Grzegorz Kulewski <kangur@polcom.net>

--- linux/fs/Kconfig	 2004-10-20 19:48:27.000000000 +0200
+++ linux-gk/fs/Kconfig	 2004-11-05 23:58:56.745730328 +0100
@@ -939,9 +939,6 @@
           you need a file system which lives in RAM with limit checking use
           tmpfs.

-         To compile this as a module, choose M here: the module will be called
-         ramfs.
-
  source "fs/supermount/Kconfig"

  endmenu
-


Thanks,

Grzegorz Kulewski

