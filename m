Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTKOBCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 20:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTKOBCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 20:02:07 -0500
Received: from smtp12.eresmas.com ([62.81.235.112]:6792 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S264490AbTKOBBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 20:01:37 -0500
Message-ID: <3FB57AE7.5000706@wanadoo.es>
Date: Sat, 15 Nov 2003 02:01:27 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.23-pre5 bugs: depmod and Unresolved symbols
References: <3F69C1FE.2040500@wanadoo.es>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040200010103040800080001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040200010103040800080001
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Xose Vazquez Perez wrote:

> depmod: *** Unresolved symbols in /lib/modules/2.4.23-pre5/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode

This bug was fixed in aa since 2.4.19pre8aa2 !!
Maybe someone needs to do a sync between 2.4.24-pre1 against pac and aa patches.

http://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa3/00_comx-driver-compile-1

00_comx-driver-compile-1 first appeared in 2.4.19pre8aa2 - 258 bytes

	Export proc_get_inode for kernel/drivers/net/wan/comx.o so
	it can link as a module, noticed by Eyal Lebedinsky.

-thanks-
-- 
HTML mails are going to trash automagically

--------------040200010103040800080001
Content-Type: text/plain;
 name="00_comx-driver-compile-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="00_comx-driver-compile-1"

--- 2.4.19pre8aa2/fs/proc/root.c.~1~	Fri May  3 02:12:18 2002
+++ 2.4.19pre8aa2/fs/proc/root.c	Sat May  4 13:45:30 2002
@@ -145,3 +145,4 @@
 EXPORT_SYMBOL(proc_net);
 EXPORT_SYMBOL(proc_bus);
 EXPORT_SYMBOL(proc_root_driver);
+EXPORT_SYMBOL(proc_get_inode);

--------------040200010103040800080001--

