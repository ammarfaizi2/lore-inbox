Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbTIRQV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 12:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTIRQV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 12:21:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:63157 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261641AbTIRQV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 12:21:57 -0400
Date: Thu, 18 Sep 2003 09:15:11 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: rob@landley.net
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Make modules_install doesn't create /lib/modules/$version
Message-Id: <20030918091511.276309a6.rddunlap@osdl.org>
In-Reply-To: <200309180321.40307.rob@landley.net>
References: <200309180321.40307.rob@landley.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Sep 2003 03:21:40 -0400 Rob Landley <rob@landley.net> wrote:

| I've installed -test3, -test4, and now -test5, and each time make 
| modules_install died with the following error:
| 
| Kernel: arch/i386/boot/bzImage is ready
| sh arch/i386/boot/install.sh 2.6.0-test5 arch/i386/boot/bzImage System.map ""
| /lib/modules/2.6.0-test5 is not a directory.
| mkinitrd failed
| make[1]: *** [install] Error 1
| make: *** [install] Error 2
| 
| I had to create the directory in question by hand, and then run it again, at 
| which point it worked.
| 
| Am I the only person this is happening for?  (Bog standard Red Hat 9 system 
| otherwise.  With Rusty's modutils...)

Yes, I see that also.
Just running 'depmod -e -F System.map-260t5 -v 2.6.0-test5' prints:
FATAL: Could not open /lib/modules/2.6.0-test5/modules.dep.temp for writing:
 No such file or directory

--
~Randy
