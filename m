Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263895AbTCVWEp>; Sat, 22 Mar 2003 17:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263905AbTCVWEp>; Sat, 22 Mar 2003 17:04:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31900
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263895AbTCVWEo>; Sat, 22 Mar 2003 17:04:44 -0500
Subject: Re: [PATCH] Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Dominik Brodowski <linux@brodo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0303221730110.15619-200000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0303221730110.15619-200000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048375677.9219.42.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 23:27:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 22:03, Bartlomiej Zolnierkiewicz wrote:
> Previously callers called it with masked_irq=0 and disabling/enabling
> hwif->irq code wasn't executed, now ide_do_request() is called with
> masked_irq=IDE_NO_IRQ=-1 so this code is executed for sure.


You are right - I botched the simplification of that. The logic is actually
cleaner than I did with a bit more thought - IDE_NO_IRQ can go away and
we should be using hwif->irq as the argument.


