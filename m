Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUF3RU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUF3RU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266763AbUF3RU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:20:26 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40904 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266790AbUF3RLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:11:44 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ide-taskfile.c fixups/cleanups part #2 [4/9]
Date: Wed, 30 Jun 2004 19:16:46 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200406301725.05181.bzolnier@elka.pw.edu.pl> <1088611825.1921.18.camel@gaston>
In-Reply-To: <1088611825.1921.18.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406301916.46181.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 of June 2004 18:10, Benjamin Herrenschmidt wrote:
> On Wed, 2004-06-30 at 10:25, Bartlomiej Zolnierkiewicz wrote:
> > [PATCH] ide: remove BUSY check from task_in_intr()
> > (CONFIG_IDE_TASKFILE_IO=n)
> >
> > We shouldn't ever get there if drive is busy and we can't start transfer
> > in this case.  ide-disk.c:read_intr() also doesn't check for BUSY_STAT
> > bit.
>
> What if we have a shared interrupt with another device ?

drive_is_ready() in ide-io.c:ide_intr() handles that.

