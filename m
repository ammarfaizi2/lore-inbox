Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbTICIuZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbTICIuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:50:25 -0400
Received: from [62.241.33.80] ([62.241.33.80]:52999 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261642AbTICIuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:50:20 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Adrian Bunk <bunk@fs.tum.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [2.4 patch] Fix IRQ_NONE clash in SCSI drivers
Date: Wed, 3 Sep 2003 10:48:53 +0200
User-Agent: KMail/1.5.3
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org
References: <Pine.LNX.4.55L.0308271449170.23236@freak.distro.conectiva> <20030902184436.GO23729@fs.tum.de>
In-Reply-To: <20030902184436.GO23729@fs.tum.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1raV/0ydPLcCcrm"
Message-Id: <200309031048.53818.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_1raV/0ydPLcCcrm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 02 September 2003 20:44, Adrian Bunk wrote:

Hi Adrian,

> This change added an (empty) IRQ_NONE #define to interrupt.h.
> Several scsi drivers are already using an IRQ_NONE.  Rename that to
> SCSI_IRQ_NONE (a similar change was done in 2.5 by Andrew Morton several
> months ago).

right, but you forgot one header :-) ... Attached is a patch.

Marcelo, please apply this too.

ciao, Marc

--Boundary-00=_1raV/0ydPLcCcrm
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="irqreturnt-compatibility-2.6-missings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="irqreturnt-compatibility-2.6-missings.patch"

--- a/drivers/scsi/NCR5380.h	2001-12-21 18:41:55.000000000 +0100
+++ b/drivers/scsi/NCR5380.h	2003-09-03 10:45:57.000000000 +0200
@@ -233,7 +233,7 @@
  * Scsi_Host structure
  */
 
-#define IRQ_NONE	255
+#define SCSI_IRQ_NONE	255
 #define DMA_NONE	255
 #define IRQ_AUTO	254
 #define DMA_AUTO	254

--Boundary-00=_1raV/0ydPLcCcrm--

