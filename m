Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUJIAKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUJIAKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 20:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUJIAKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 20:10:12 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:42404 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S266291AbUJIAJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 20:09:26 -0400
Date: Sat,  9 Oct 2004 02:08:11 +0200
From: smurf@smurf.noris.de (Matthias Urlichs)
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus <torvalds@osdl.org>
Subject: [BK PATCH] CREDITS update, Makefile.host buglet, and bksend sample program glitch
Message-ID: <E1CG4mR-0001D6-SE@server.smurf.noris.de>
X-Smurf-Spam-Score: -0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email contains three hopefully-noncontroversial change(set)s:
- allow HOSTLOADLIBES_foo variables for single-binary programs
- fix PAGER usage in bksend sample script
- update my CREDITS entry

Please "bk receive", or pull from
	bk://smurf.noris.de/linux-export

===================================================================


ChangeSet@1.2137, 2004-10-09 01:33:20+02:00, smurf@smurf.noris.de
  Fix the host-csingle macro to include HOSTLOADLIBES_foo variable,
  to be consistent with (a) other usage of this variable and (b) documentation.
  
  Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

ChangeSet@1.2136, 2004-10-09 01:31:18+02:00, smurf@smurf.noris.de
  Add PAGER=cat to bksend script: not all pagers notice
  that their stdout isn't the terminal.
  
  Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

ChangeSet@1.2135, 2004-10-09 01:26:59+02:00, smurf@smurf.noris.de
  Update the CREDITS entry of Matthias Urlichs <smurf@smurf.noris.de>.
  
  Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>



 CREDITS                       |    7 ++++---
 Documentation/BK-usage/bksend |    2 +-
 scripts/Makefile.host         |    3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)


diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	2004-10-09 01:57:09 +02:00
+++ b/CREDITS	2004-10-09 01:57:09 +02:00
@@ -3309,10 +3309,11 @@
 S: USA
 
 N: Matthias Urlichs
-E: urlichs@noris.de
-E: urlichs@smurf.sub.org
+E: smurf@smurf.noris.de
+E: smurf@debian.org
+E: matthias@urlichs.de
 D: Consultant, developer, kernel hacker
-D: Playing with Streams, ISDN, and BSD networking code for Linux
+D: In a previous life, worked on Streams/ISDN/BSD networking code for Linux
 S: Schleiermacherstrasse 12
 S: 90491 Nuernberg
 S: Germany
diff -Nru a/Documentation/BK-usage/bksend b/Documentation/BK-usage/bksend
--- a/Documentation/BK-usage/bksend	2004-10-09 01:57:09 +02:00
+++ b/Documentation/BK-usage/bksend	2004-10-09 01:57:10 +02:00
@@ -27,7 +27,7 @@
 
 SEP="\n===================================================================\n\n"
 echo -e $SEP
-bk changes -r$REV
+PAGER=cat bk changes -r$REV
 echo
 bk export -tpatch -du -h -r$REV | diffstat
 echo; echo
diff -Nru a/scripts/Makefile.host b/scripts/Makefile.host
--- a/scripts/Makefile.host	2004-10-09 01:57:10 +02:00
+++ b/scripts/Makefile.host	2004-10-09 01:57:10 +02:00
@@ -98,7 +98,8 @@
 # Create executable from a single .c file
 # host-csingle -> Executable
 quiet_cmd_host-csingle 	= HOSTCC  $@
-      cmd_host-csingle	= $(HOSTCC) $(hostc_flags) $(HOST_LOADLIBES) -o $@ $<
+      cmd_host-csingle	= $(HOSTCC) $(hostc_flags) -o $@ $< \
+	  	$(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
 $(host-csingle): %: %.c FORCE
 	$(call if_changed_dep,host-csingle)
 

===================================================================


This BitKeeper patch contains the following changesets:
1.2134..
## Wrapped with gzip_uu ##


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
;UZO'B<E4)C/=%'NI)&,>8FWT-[7@FUZW%   
 
