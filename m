Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTDRC0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 22:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbTDRC0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 22:26:16 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54289
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262763AbTDRC0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 22:26:15 -0400
Date: Thu, 17 Apr 2003 19:35:49 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.67-ac1 IDE - fix Taskfile IOCTLs
In-Reply-To: <Pine.SOL.4.30.0304180052130.20946-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10304171935301.11686-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ide_diag_taskfile

Do not do that it will break paths!

On Fri, 18 Apr 2003, Bartlomiej Zolnierkiewicz wrote:

> 
> Hey,
> 
> This time 5 incremental patches:
> 
> 1       - Fix PIO handlers for Taskfile ioctls.
> 2a + 2b - Taskfile and flagged Taskfile PIO handlers unification.
> 3       - Map HDIO_DRIVE_CMD ioctl onto taskfile.
> 4       - Remove dead ide_diag_taskfile() code.
> 
> [ More comments inside patches. ]
> 
> Special care is needed for patch 3 as it is a bit experimental,
> but at least hdparm -I /dev/hdx still works :-).
> I have also made version using direct IO to user pages,
> it works okay too but needs some more work to be elegant...
> 
> You can also get them at:
> http://home.elka.pw.edu.pl/~bzolnier/patches/2.5.67-ac1/
> 
> --
> bzolnier
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

