Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVCHLgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVCHLgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 06:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVCHLgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 06:36:52 -0500
Received: from smtpout18.mailhost.ntl.com ([212.250.162.18]:32545 "EHLO
	mta10-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261978AbVCHLUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:20:01 -0500
Subject: Kbuild files and backwards compatibility.
From: Ian Campbell <ijc@hellion.org.uk>
To: sam@ravnborg.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 11:19:42 +0000
Message-Id: <1110280783.3466.16.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Documentation/kbuild/modules.txt suggests using "include Kbuild" in
external modules Makefile to retain backward compatibility with older
(pre separate Kbuild) kernels.

This doesn't appear to be quite correct:
http://www.gossamer-threads.com/lists/ivtv/devel/18285

Using $(src)/Kbuild seems to work, with 2.6.9 at least.

--- 2.6.orig/Documentation/kbuild/modules.txt   2005-03-02 15:59:58.000000000 +0000
+++ 2.6/Documentation/kbuild/modules.txt        2005-03-08 11:16:39.252459179 +0000
@@ -252,7 +252,7 @@

                --> filename: Makefile
                ifneq ($(KERNELRELEASE),)
-               include Kbuild
+               include $(src)/Kbuild
                else
                # Normal Makefile


Cheers,
Ian.


-- 
Ian Campbell
Current Noise: Slayer - Circle Of Beliefs

