Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270326AbTHBVKY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 17:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270346AbTHBVKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 17:10:24 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:403 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270326AbTHBVKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 17:10:21 -0400
Subject: Re: ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, axboe@suse.de,
       Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030802174229.GA3741@win.tue.nl>
References: <20030802124536.GB3689@win.tue.nl>
	 <Pine.SOL.4.30.0308021506550.7779-100000@mion.elka.pw.edu.pl>
	 <20030802174229.GA3741@win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059858379.20305.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Aug 2003 22:06:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-08-02 at 18:42, Andries Brouwer wrote:
> OK, so we have to investigate. This strange test was inserted
> in 2.4 and 2.5 via Alan, and google gives me Alan's changelog:
> 
> Linux 2.5.66-ac1
> o Don't issue WIN_SET_MAX on older drivers (Jens Axboe)
>   (Breaks some Samsung)

Some older Samsung drives don't abort WIN_SET_MAX but the firmware
hangs hence the check.

> If possible we would like to remove the test and test the
> right bits instead. But if that Samsung disk claims it
> supports HPA and doesnt..

That would be better if it is the case

