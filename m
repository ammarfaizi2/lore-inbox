Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbTDFL23 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 07:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbTDFL23 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 07:28:29 -0400
Received: from [80.190.48.67] ([80.190.48.67]:5132 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262933AbTDFL22 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 07:28:28 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre7 ipmi unresolved
Date: Sun, 6 Apr 2003 13:38:51 +0200
User-Agent: KMail/1.5.1
References: <3E900F09.18EF30CE@eyal.emu.id.au>
In-Reply-To: <3E900F09.18EF30CE@eyal.emu.id.au>
Organization: Working Overloaded Linux Kernel
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200304061336.00896.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LHBk+JXgocWFclJ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_LHBk+JXgocWFclJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 06 April 2003 13:27, Eyal Lebedinsky wrote:

Hi Eyal,

> all modules. With two small patches to get HPT372N and ac97
> to compile.
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-pre7/kernel/drivers/char/ipmi/ipmi_msghandler.o
> depmod:         panic_notifier_list
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-pre7/kernel/drivers/char/ipmi/ipmi_watchdog.o
> depmod:         panic_notifier_list
> depmod:         panic_timeout
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-pre7/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode
I've already sent a patch to lkml and Marcelo before -pre7.

See: http://marc.theaimsgroup.com/?l=linux-kernel&m=104879598008705&w=2

At least for the ipmi stuff. For the proc_get_inode stuff use the attached 
one.

ciao, Marc




--Boundary-00=_LHBk+JXgocWFclJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="comx-driver-compile-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="comx-driver-compile-1.patch"

--- 2.4.19pre8aa2/fs/proc/root.c.~1~	Fri May  3 02:12:18 2002
+++ 2.4.19pre8aa2/fs/proc/root.c	Sat May  4 13:45:30 2002
@@ -145,3 +145,4 @@
 EXPORT_SYMBOL(proc_net);
 EXPORT_SYMBOL(proc_bus);
 EXPORT_SYMBOL(proc_root_driver);
+EXPORT_SYMBOL(proc_get_inode);

--Boundary-00=_LHBk+JXgocWFclJ--

