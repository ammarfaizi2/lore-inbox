Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbTIVMFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 08:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbTIVMFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 08:05:30 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:56026 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263120AbTIVMF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 08:05:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16238.58754.128179.710670@gargle.gargle.HOWL>
Date: Mon, 22 Sep 2003 14:05:22 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: rob@landley.net
Cc: azarah@gentoo.org, linux-kernel@vger.kernel.org, rddunlap@osdl.org,
       rusty@rustcorp.com.au
Subject: Re: Make modules_install doesn't create /lib/modules/$version
In-Reply-To: <200309220655.43275.rob@landley.net>
References: <200309192139.h8JLdaXf012418@harpo.it.uu.se>
	<200309220655.43275.rob@landley.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley writes:
 > > depmod does not create any directories, 'make modules_install' does.
 > 
 > Although make install dies on a red hat 9 system trying to look at the modules 
 > directory if modules_install isn't done first.  Maybe it's an RH 9 bug.  I 

RH9's /sbin/installkernel tries to run /sbin/new-kernel-pkg in order to
build a new initrd. This will almost certainly fail if your modules
directory isn't already populated at this point.

make modules_install; make install
in that order solves the problem.

If you don't like RH's installkernel then you can always write
your own and put it in ~/bin. That's what I did a long time ago
to make it lilo-friendly. (RH prefers that POS grub.)

 > install" now, yet make install doesn't install modules.  Is there a reason 
 > make install does NOT install modules for a modular kernel?

It hasn't before. I doubt very many people have a major problem with it.
