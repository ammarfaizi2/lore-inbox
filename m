Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVEOQuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVEOQuq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 12:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVEOQuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 12:50:46 -0400
Received: from smtpout.mac.com ([17.250.248.73]:26614 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261677AbVEOQum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 12:50:42 -0400
In-Reply-To: <42877C1B.2030008@pobox.com>
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net> <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <37C1BFCF-1B30-4781-AC72-81513650AD50@mac.com>
Cc: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>, gene.heskett@verizon.net,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Disk write cache
Date: Sun, 15 May 2005 12:50:22 -0400
To: Jeff Garzik <jgarzik@pobox.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 15, 2005, at 12:43:07, Jeff Garzik wrote:
> The only way to you can be assured that your data has "hit the  
> platter" is
> (1) issuing [FLUSH|SYNC] CACHE, or
> (2) using FUA-style disk commands

And even then, some battery-backed RAID controllers will completely
ignore cache-flushes, because in the event of a power failure they
can maintain the cached data for anywhere from a couple days to a
month or two, depending on the quality of the card and the size of
its battery.

