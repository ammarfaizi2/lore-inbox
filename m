Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932907AbWF3SFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbWF3SFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbWF3SFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:05:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:197 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932626AbWF3SFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:05:08 -0400
Subject: Re: [PATCH -mm] ide_end_drive_cmd(): avoid instruction pipeline
	stall
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: andi@rhlx01.fht-esslingen.de, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060630110018.f45b40e2.akpm@osdl.org>
References: <20060630161351.GA17434@rhlx01.fht-esslingen.de>
	 <1151688416.31392.66.camel@localhost.localdomain>
	 <20060630110018.f45b40e2.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 19:21:39 +0100
Message-Id: <1151691699.31392.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 11:00 -0700, ysgrifennodd Andrew Morton:
> I guess because he was profiling for IFU_MEM_STALL, not for wall-time.
> 
> > NAK because
> > 1. This is a gcc problem
> > 2. Not everyone is using an intel x86-32 box which has such problems
> > 3. IDE is in life-support mode and the relatives are already planning
> > the flowers.
> 
> Well.  If the patch breaks anything we can dine on hats for a month.  Seems
> pretty inoffensive to me.

Yeah its a do nothing change that has no value. We can equally not apply
it and see no difference. Its make-work that might slow down some
systems.

Send it to the gcc people see if its a case they could/should optimise

Alan

