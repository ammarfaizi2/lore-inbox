Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUAUXZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUAUXZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:25:53 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:7942 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S266170AbUAUXZv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:25:51 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: modular ide + fixed legacy/ppc doesn't work when non modular on ppc
Date: Thu, 22 Jan 2004 00:25:07 +0100
User-Agent: KMail/1.5.94
Cc: linux-kernel@vger.kernel.org
References: <200401212354.45957.arekm@pld-linux.org> <200401220015.21827.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200401220015.21827.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401220025.07135.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia czw 22. stycznia 2004 00:15, Bartlomiej Zolnierkiewicz napisa³:
> Thanks, I have alternative fix.
>
> --- linux/drivers/ide/ppc/pmac.c.orig	2004-01-09 07:59:08.000000000 +0100
> +++ linux/drivers/ide/ppc/pmac.c	2004-01-22 00:10:11.550746088 +0100
> @@ -46,7 +46,7 @@
>  #include <asm/sections.h>
>  #include <asm/irq.h>
>
> -#include "ide-timing.h"
> +#include "../ide-timing.h"
>
>  extern void ide_do_request(ide_hwgroup_t *hwgroup, int masked_irq);
Works fine, thanks!

> --bart

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
