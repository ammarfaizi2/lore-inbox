Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTFCSgw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTFCSgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:36:52 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:51977 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262219AbTFCSgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:36:51 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: margitsw@t-online.de (Margit Schubert-While), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc7
Date: Tue, 3 Jun 2003 20:50:00 +0200
User-Agent: KMail/1.5.2
References: <5.1.0.14.2.20030603204118.00a04728@pop.t-online.de>
In-Reply-To: <5.1.0.14.2.20030603204118.00a04728@pop.t-online.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Message-Id: <200306032049.18987.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Y3O3+2LnqbirQg4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Y3O3+2LnqbirQg4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 03 June 2003 20:45, Margit Schubert-While wrote:

> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.21-rc7; fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-rc7/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode

attached.

hch: I know what you'll say, so don't reply ;-))

ciao, Marc



--Boundary-00=_Y3O3+2LnqbirQg4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="01_comx-driver-compile-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01_comx-driver-compile-1.patch"

--- 2.4.19pre8aa2/fs/proc/root.c.~1~	Fri May  3 02:12:18 2002
+++ 2.4.19pre8aa2/fs/proc/root.c	Sat May  4 13:45:30 2002
@@ -145,3 +145,4 @@
 EXPORT_SYMBOL(proc_net);
 EXPORT_SYMBOL(proc_bus);
 EXPORT_SYMBOL(proc_root_driver);
+EXPORT_SYMBOL(proc_get_inode);

--Boundary-00=_Y3O3+2LnqbirQg4--

