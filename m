Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318100AbSG2XHO>; Mon, 29 Jul 2002 19:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318112AbSG2XHO>; Mon, 29 Jul 2002 19:07:14 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:29349 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S318100AbSG2XHO>;
	Mon, 29 Jul 2002 19:07:14 -0400
Message-ID: <3D45CB61.8060708@gmx.net>
Date: Tue, 30 Jul 2002 01:10:25 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-07@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020701
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix some MODULE_LICENSE tags in 2.4.19-rc3
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060508020904070501030801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508020904070501030801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Currently two files in the kernel have MODULE_LICENSE tags which result in a 
tainted kernel. According to include/linux/module.h, BSD licensed code 
becomes also GPL when linked into the kernel.
Offending files: fs/nls/nls_cp1250.c and net/ipv4/netfilter/ipchains_core.c

Comments/Suggestions welcome.

Regards,
   Carl-Daniel

--------------060508020904070501030801
Content-Type: text/plain;
 name="license.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="license.diff"

--- linux-2.4/fs/nls/nls_cp1250.c~	Sat Jul 27 00:57:10 2002
+++ linux-2.4/fs/nls/nls_cp1250.c	Sat Jul 27 00:58:41 2002
@@ -344,7 +344,7 @@
 module_init(init_nls_cp1250)
 module_exit(exit_nls_cp1250)
 
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
--- linux-2.4/net/ipv4/netfilter/ipchains_core.c~	Sat Jul 27 01:01:26 2002
+++ linux-2.4/net/ipv4/netfilter/ipchains_core.c	Sat Jul 27 01:03:55 2002
@@ -1779,4 +1779,4 @@
 #endif
 	return ret;
 }
-MODULE_LICENSE("BSD without advertisement clause");
+MODULE_LICENSE("Dual BSD/GPL");

--------------060508020904070501030801--

