Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbUK1SdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUK1SdW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUK1SdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:33:22 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7826 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261554AbUK1SdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:33:08 -0500
Subject: Re: Out of memory, but no OOM Killer? (2.6.9-ac11)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041126224722.GK30987@charite.de>
References: <20041126224722.GK30987@charite.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101662984.16787.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 28 Nov 2004 17:29:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-11-26 at 22:47, Ralf Hildebrandt wrote:
> rsync seems to want lots of memory, yet the OOM killer doesn't strike.
> Subsequently, that machine died an ugly death until delivered by a
> power-cycle.
> 
> Why doesn't the OOM killer reap rsync?

The OOM killer is a very dumb (near useless) heuristic. You can turn it
off or switch to sane overcommit module by setting
/proc/sys/vm/overcommit_memory to
1 or 2 respectively.

In this case your bug looks like the 2.6.9 network problem in which case
if you are lucky -ac12 will have fixed it as I merged the stuff DaveM
recommended into that.

Alan

