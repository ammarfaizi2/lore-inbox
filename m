Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUDZPXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUDZPXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUDZPXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:23:54 -0400
Received: from users.linvision.com ([62.58.92.114]:63156 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262744AbUDZPXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:23:46 -0400
Date: Mon, 26 Apr 2004 17:23:45 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Message-ID: <20040426152345.GE14074@harddisk-recovery.com>
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <200404221635.12490.bzolnier@elka.pw.edu.pl> <20040426135058.GC14074@harddisk-recovery.com> <200404261650.40801.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404261650.40801.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 04:50:40PM +0200, Bartlomiej Zolnierkiewicz wrote:
> BTW I think there is a common misunderstanding about libata:
>     it will not replace IDE drivers any time soon.
> 
> I want to rewrite+merge current IDE code with libata during 2.7
> (and yes, legacy naming and ordering will be preserved!).
> 
> I hope nobody starts rewriting existing IDE drivers for libata and pushing
> them upstream -> it will mean maintenance problems much bigger than OSS+ALSA.

I don't think it's bad to have two drivers for the same hardware. We've
seen that with the USB UHCI host controller, RTL 8139, Intel e100,
Adaptec aic7xxx, NCR/Symbios sym53c8x. Having two drivers makes it easy
for people to switch. The difference with OSS+ALSA is that the drivers
I just mentioned have been "developed" in the tree, while ALSA was
developed outside the tree.

> However writing _new_ libata driver for 'exotic' PATA hardware is OK.

Is AMD 760/762 (amd74xx driver) considered "exotic"? ;-)


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
