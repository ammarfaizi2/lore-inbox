Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUEBNOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUEBNOi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 09:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbUEBNOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 09:14:38 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:25875 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263059AbUEBNO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 09:14:28 -0400
From: Marc-Christian Petersen <m.c.p@wolk.linux-systeme.com>
To: Peter Hicks <peter.hicks@poggs.co.uk>, Arne Schwabe <plaisthos@web.de>
Subject: Re: 2.6.6-rc3, nvidia.o and CONFIG_4KSTACKS
Date: Sun, 2 May 2004 15:12:17 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <4094F005.5000501@poggs.co.uk>
In-Reply-To: <4094F005.5000501@poggs.co.uk>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Linux-Systeme GmbH
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xOPlAWJvAmzjq7I"
Message-Id: <200405021512.17672@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_xOPlAWJvAmzjq7I
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 02 May 2004 14:56, Peter Hicks wrote:

Hi Peter,

> Just a quickie - the NVidia driver kills my machine when running 2.6.6-rc3
> with CONFIG_4KSTACKS turned on.
>
> My fault for choosing the card.  Any chance of a warning in the help text
> for that option?

ack.

ciao, Marc

--Boundary-00=_xOPlAWJvAmzjq7I
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="0002_01-2.6.5-mm6-4k-stacks-NVIDIA-hint.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002_01-2.6.5-mm6-4k-stacks-NVIDIA-hint.patch"

# 2.6.4-WOLK2.1

--- old/arch/i386/Kconfig	2004-04-11 12:39:26.000000000 +0200
+++ new/arch/i386/Kconfig	2004-04-11 12:40:35.000000000 +0200
@@ -1504,6 +1504,8 @@ config 4KSTACKS
 	  on the VM subsystem for higher order allocations. This option
 	  will also use IRQ stacks to compensate for the reduced stackspace.
 
+	  Do NOT select this if you intend to use NVIDIA binary only modules!
+
 config SCHEDSTATS
 	bool "Collect scheduler statistics"
 	depends on PROC_FS

--Boundary-00=_xOPlAWJvAmzjq7I--
