Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264088AbUDVOgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbUDVOgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 10:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbUDVOgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 10:36:42 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21453 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264067AbUDVOg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 10:36:29 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Thu, 22 Apr 2004 16:35:12 +0200
User-Agent: KMail/1.5.3
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <200404220250.15078.bzolnier@elka.pw.edu.pl> <20040422103355.GC15176@harddisk-recovery.com>
In-Reply-To: <20040422103355.GC15176@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404221635.12490.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 of April 2004 12:33, Erik Mouw wrote:
> On Thu, Apr 22, 2004 at 02:50:15AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 22 of April 2004 02:41, Erik Andersen wrote:
> > > Out of curiosity, what would be needed to make it safe to unload
> > > all ide modules from a system with a scsi rootfs?
> >
> > It doesn't matter - you still may end up unloading modules which are in
> > use.
>
> FWIW, with the old IDE code I've been unloading IDE modules for years
> without a single problem.

IDE chipset drivers were made 'modular' in 2.4.21
(release date 13-Jun-2003) and this complicated things

> What makes IDE sufficiently different from SCSI that we can't unload
> IDE host drivers?

- no reference counting
- lack of release() method
- insufficient locking

Cheers,
Bartlomiej

