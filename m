Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbULPCHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbULPCHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 21:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbULPCES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 21:04:18 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:37249 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262601AbULPAxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:53:23 -0500
Subject: Re: [2.6.10-rc2+] ide1=ata66 -- OBSOLETE OPTION, WILL BE REMOVED
	SOON!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Rene Herman <rene.herman@keyaccess.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e04121313473057143b@mail.gmail.com>
References: <41B36021.5050600@keyaccess.nl>
	 <58cb370e04121313473057143b@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103154772.3585.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Dec 2004 23:52:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-13 at 21:47, Bartlomiej Zolnierkiewicz wrote:
> > I do need a way to force an 80c cable on this AMD756 (ATA66 max) board,
> > since the BIOS doesn't seem to be setting the cable bits correctly.
> 
> Ugh, I checked AMD datasheets and AMD756 doesn't support host
> side cable detection.  Well, we can try doing disk side only for it.
> [ ATi and ITE (in -ac kernels) drivers are also doing this. ]

That is probably a good change but not sufficient for things like
bladeservers where some vendors use short 40c cables which are within
specification but break drive side detection. Removing ata66 forcing
doesn't work because of these although perhaps it could be done using
subvendor ids so it is automatic ?

Right now I plan to keep ata66 overrides in -ac.

Alan

