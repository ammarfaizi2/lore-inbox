Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbTLIPqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266074AbTLIPqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:46:50 -0500
Received: from mhub-c5.tc.umn.edu ([160.94.128.35]:7350 "EHLO
	mhub-c5.tc.umn.edu") by vger.kernel.org with ESMTP id S266072AbTLIPqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:46:47 -0500
Subject: Re: Menuconfig problem
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Aurelian Pop <aurelian.pop@ondems.com>,
       cooker@linux-mandrake.com
In-Reply-To: <200312091548.49261.m.c.p@wolk-project.de>
References: <001b01c3bdd6$ed8a2310$1b32e682@dmi.tut.fi>
	 <200312091548.49261.m.c.p@wolk-project.de>
Content-Type: text/plain
Message-Id: <1070984793.1090.47.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 09:46:34 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-09 at 08:48, Marc-Christian Petersen wrote:
> On Monday 08 December 2003 23:02, Aurelian Pop wrote:
> 
> Hi Aurelian,
> 
> > I was trying to recomile my kernel and when configuring it I got the next
> > message:
> >  Q> scripts/Menuconfig: line 832: MCmenu78: command not found
> >
> > Please report this to the maintainer <mec@shout.net>.  You may also
> 
> you sent that bugreport also to mec@shout.net?

I hope not. ^_^;

http://www.cs.helsinki.fi/linux/linux-kernel/2003-21/0234.html

Maybe something like the following would be appropriate? (Of course, the
real issue is to get Mandrake to say "Please report this to
someone@mandrake-linux.com" ... )

(For the Mandrake people, lkml gets occasional messages from people
building Mandrake kernels where Menuconfig fails at the ALSA menu
due to a bug that's been fixed in Mandrake sources for a while, the
attached patch will at least make sure lkml and the previous kbuild
maintainer don't get those messages anymore; it also hints that people
should try with a newer distro kernel.)

Matt

  Remove visible references to mec@shout.net from Menuconfig, since he
  no longer maintains it.



diff -puN MAINTAINERS~mec MAINTAINERS
--- linux-2.4.23-pre7/MAINTAINERS~mec	2003-12-09 09:14:46.321159168
-0600
+++ linux-2.4.23-pre7-arashi/MAINTAINERS	2003-12-09 09:22:34.723951120
-0600
@@ -455,11 +455,9 @@ M:	Pasztor Szilard <don@itc.hu>
 S:	Supported
 
 CONFIGURE, MENUCONFIG, XCONFIG
-P:	Michael Elizabeth Chastain
-M:	mec@shout.net
 L:	kbuild-devel@lists.sourceforge.net
 W:	http://kbuild.sourceforge.net
-S:	Maintained
+S:	Obsolete
 
 CONFIGURE.HELP
 P:	Steven P. Cole
diff -puN scripts/Menuconfig~mec scripts/Menuconfig
--- linux-2.4.23-pre7/scripts/Menuconfig~mec	2003-12-09
09:25:00.293821136 -0600
+++ linux-2.4.23-pre7-arashi/scripts/Menuconfig	2003-12-09
09:42:53.380963608 -0600
@@ -20,7 +20,6 @@
 # script.
 #
 # William Roadcap was the original author of Menuconfig.
-# Michael Elizabeth Chastain (mec@shout.net) is the current maintainer.
 #
 # 070497 Bernhard Kaindl (bkaindl@netway.at) - get default values for
 # new bool, tristate and dep_tristate parameters from the defconfig
file.
@@ -844,8 +843,9 @@ EOM
 			sed 's/^/ Q> /' MCerror
 			cat <<EOM
 
-Please report this to the maintainer <mec@shout.net>.  You may also
-send a problem report to <linux-kernel@vger.kernel.org>.
+Please report this to your distribution if problems persist after
+you've upgraded to their latest kernel release. You may also send a
+problem report to <linux-kernel@vger.kernel.org>.
 
 Please indicate the kernel version you are trying to configure and
 which menu you were trying to enter when this error occurred.
@@ -906,9 +906,8 @@ You may also need to rebuild lxdialog.  
 the /usr/src/linux/scripts/lxdialog directory and issuing the 
 "make clean all" command.
 
-If you have verified that your ncurses install is correct, you may
email
-the maintainer <mec@shout.net> or post a message to
-<linux-kernel@vger.kernel.org> for additional assistance. 
+If you have verified that your ncurses install is correct, you may post
+a message to <linux-kernel@vger.kernel.org> for additional assistance. 
 
 EOM
 			cleanup

_


