Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbWFVUZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWFVUZb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWFVUZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:25:31 -0400
Received: from rtr.ca ([64.26.128.89]:46984 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030396AbWFVUZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:25:30 -0400
Message-ID: <449AFCB8.4030608@rtr.ca>
Date: Thu, 22 Jun 2006 16:25:28 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: js@linuxtv.org, pavel@ucw.cz, p.lundkvist@telia.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: [PATCH] Page writeback broken after resume: wb_timer lost
References: <20060520130326.GA6092@localhost>	<20060520103728.6f3b3798.akpm@osdl.org>	<20060520225018.GC8490@elf.ucw.cz>	<20060520171244.4399bc54.akpm@osdl.org>	<20060616212410.GA6821@linuxtv.org>	<4496C5AC.3030809@rtr.ca>	<4498BF51.5090204@rtr.ca>	<20060620205415.d808ace9.akpm@osdl.org>	<4498C6CF.3080206@rtr.ca> <20060620211905.c7307b9f.akpm@osdl.org>
In-Reply-To: <20060620211905.c7307b9f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> Is that after a suspend/resume, or does it happen after a reboot?

Definitely after a suspend/resume (RAM).
It's been too long for me to remember about after a reboot.

> Are you sure all the dirty memory doesn't get autocleaned after 30-60
> seconds?

No, it does not get autocleaned (without this patch) after 30-60 *minutes*,
let alone 30-60 seconds.  Nor with or without laptop-mode enabled/disabled.
Nor anything else suggested.  Except for this patch.

Cheers
