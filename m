Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTLBSiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTLBSiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:38:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:8071 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263281AbTLBSis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:38:48 -0500
X-Authenticated: #14985714
Date: Tue, 2 Dec 2003 19:35:22 +0100
From: "Stefan J. Betz" <stefan_betz@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: include/linux/version.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Debian GNU/Linux 3.0r1
X-Programming-Language: Python
X-Office-Software: OpenOffice 1.1.0
X-Nickname: [ENC]BladeXP
X-Kernel-Version: 2.4.22
X-Desktop: FVWM 2.4.6
X-Jabber-Id: stefan_betz@jabber.org
X-Host: encbladexp.homelinux.net
Message-Id: <S263281AbTLBSis/20031202183848Z+2508@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello People,

i have found some wrong thing in include/linux/version.h
On my System i have Kernel 2.6.0-test10 & 2.6.0-test11, but in
include/linux/version.h i see:
#define UTS_RELEASE "2.6.0-test9"

correct where:
#definde UTS_RELEASE "2.6.0-test11" (for Linux Kernel 2.6.0-test11)...

Here is a little "patch":

diff -Nru linux-2.6.0-test11/include/linux/version.h linux-2.6.0-test11-fixed/include/linux/version.h
--- linux-2.6.0-test11/include/linux/version.h	Tue Dec  2 19:21:22 2003
+++ linux-2.6.0-test11-fixed/include/linux/version.h	Tue Dec  2 19:22:06 2003
@@ -1,3 +1,3 @@
-#define UTS_RELEASE "2.6.0-test9"
+#define UTS_RELEASE "2.6.0-test11"
 #define LINUX_VERSION_CODE 132608
 #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

I know that this is not a very usefull fix, but i think 2.6.0 should be
BugFree (TM) :-)

Greeting Betz Stefan

I know that my english is not realy good, but any tipp how i can learn
better english is welcome...
