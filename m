Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbTIRH2n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 03:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbTIRH2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 03:28:42 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:12232
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262995AbTIRH2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 03:28:41 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Make modules_install doesn't create /lib/modules/$version
Date: Thu, 18 Sep 2003 03:21:40 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309180321.40307.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've installed -test3, -test4, and now -test5, and each time make 
modules_install died with the following error:

Kernel: arch/i386/boot/bzImage is ready
sh arch/i386/boot/install.sh 2.6.0-test5 arch/i386/boot/bzImage System.map ""
/lib/modules/2.6.0-test5 is not a directory.
mkinitrd failed
make[1]: *** [install] Error 1
make: *** [install] Error 2

I had to create the directory in question by hand, and then run it again, at 
which point it worked.

Am I the only person this is happening for?  (Bog standard Red Hat 9 system 
otherwise.  With Rusty's modutils...)

Rob
