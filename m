Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266780AbUF3QWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266780AbUF3QWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbUF3QOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:14:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:27627 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266767AbUF3QNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:13:39 -0400
Subject: Re: [PATCH] ide-taskfile.c fixups/cleanups part #2 [4/9]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200406301725.05181.bzolnier@elka.pw.edu.pl>
References: <200406301725.05181.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1088611825.1921.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 30 Jun 2004 11:10:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-30 at 10:25, Bartlomiej Zolnierkiewicz wrote:
> [PATCH] ide: remove BUSY check from task_in_intr() (CONFIG_IDE_TASKFILE_IO=n)
> 
> We shouldn't ever get there if drive is busy and we can't start transfer
> in this case.  ide-disk.c:read_intr() also doesn't check for BUSY_STAT bit.

What if we have a shared interrupt with another device ?

Ben.


