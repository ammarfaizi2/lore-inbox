Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272150AbTHNCrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 22:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272152AbTHNCrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 22:47:25 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:49415 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S272150AbTHNCrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 22:47:19 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: "Alasdair McWilliam" <allymcw2000@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an Athlon XP system
Date: Thu, 14 Aug 2003 04:46:45 +0200
User-Agent: KMail/1.5.3
References: <LAW10-F56d2h2jXi2Qd0001e84d@hotmail.com>
In-Reply-To: <LAW10-F56d2h2jXi2Qd0001e84d@hotmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VgvO/jHVO3fcUr5"
Message-Id: <200308140446.45208.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_VgvO/jHVO3fcUr5
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 14 August 2003 03:02, Alasdair McWilliam wrote:

Hi Alasdair,

> 1. PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an Athlon XP
> 8. I've done research and found that people have been experiencing this
> problem from linux-2.4.0-test releases. Can someone please fix it?! Or
> point me to a patch that works? :( The server's running on a chunky kernel
> optimised for the old K6-II (i586).

urgs, for that long? surprising :)

Could you please try attached patch? Completely untested and just a guess. 
Please report success/failure. Thanks

ciao, Marc

--Boundary-00=_VgvO/jHVO3fcUr5
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="mmx_memcpy-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mmx_memcpy-fix.patch"

--- old/arch/i386/kernel/Makefile	2002-11-29 00:53:09.000000000 +0100
+++ wolk4/arch/i386/kernel/Makefile	2003-08-14 04:42:43.000000000 +0200
@@ -40,5 +40,6 @@ obj-$(CONFIG_SMP)		+= smp.o smpboot.o tr
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o acpitable.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
+obj-$(CONFIG_X86_USE_3DNOW)	+= i386_ksyms.o
 
 include $(TOPDIR)/Rules.make

--Boundary-00=_VgvO/jHVO3fcUr5--

