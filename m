Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbVKVTyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVKVTyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbVKVTyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:54:22 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:22211 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965160AbVKVTyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:54:21 -0500
Subject: Re: [PATCH, IDE] Blacklist CD-912E/ATK
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Horms <horms@verge.net.au>
Cc: Karol Lewandowski <klz@o2.pl>, 340228@bugs.debian.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20051122024426.8C16A34043@koto.vergenet.net>
References: <20051122024426.8C16A34043@koto.vergenet.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 20:26:19 +0000
Message-Id: <1132691179.20233.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     The drive is clearly broken.  Adding blacklist to drivers/ide/ide-dma.c
>     for this model ("CD-912E/ATK") fixes this problem.

That may be the case but knowing if th drive is the problem is more
tricky.

Firstly try it on a different controller
Secondly check for other firmware revisions 
Thirdly blacklist only your firmware rev if there are others


>     hdc: DMA disabled
>     ------------[ cut here ]------------
>     kernel BUG at drivers/ide/ide-iops.c:949!
>     invalid operand: 0000 [#1]

That is an IDE layer bug not a drive incompatibility. It may be one
triggered the other but until the BUG the kernel was correctly behaving
and had just turned off DMA anyway.


