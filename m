Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUC1HYP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 02:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUC1HYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 02:24:14 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:40627 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262101AbUC1HYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 02:24:11 -0500
Message-ID: <40667D8D.2030802@stesmi.com>
Date: Sun, 28 Mar 2004 09:23:57 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40660877.3090302@stesmi.com> <40660A3D.3020300@pobox.com>
In-Reply-To: <40660A3D.3020300@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff.

>> What will happen when a PATA disk lies behind a Marvel(ous) bridge, as
>> in most SATA disks today?
> 
> Larger transfers work fine in PATA, too.

Correct me if I'm wrong but wasn't the max number of sectors in a
transfer limited to 255 instead of 256 because there were buggy
drives out there before ? I seem to recall something like that but
I could be wrong.

Of course I hope nobody in his right mind would take those old things,
slap a Marvel chip on it and sell it as new :) But someone else could
buy one of those SATA<->PATA converter cables with a Marvel on it and
run it with the old disk <shudder>. Wouldn't those cases bug out?

>> Is large transfers mandatory in the LBA48 spec and is LBA48 really
>> mandatory in SATA?
> 
> Yes and no, in that order :)  SATA doesn't mandate lba48, but it is 
> highly unlikely that you will see SATA disk without lba48.

Naturally, see my comment above regarding SATA<->PATA converter cables.

> Regardless, libata supports what the drive supports.  Older disks still 
> work just fine.

Or.. should :)

// Stefan
