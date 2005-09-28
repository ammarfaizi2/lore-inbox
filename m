Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVI1UFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVI1UFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVI1UFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:05:05 -0400
Received: from mail.dvmed.net ([216.237.124.58]:64741 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750827AbVI1UFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:05:02 -0400
Message-ID: <433AF767.205@pobox.com>
Date: Wed, 28 Sep 2005 16:04:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Kosewski <lkosewsk@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/3] Add disk hotswap support to libata RESEND #5
References: <355e5e5e0509261801613c9bdb@mail.gmail.com>	 <433AE72B.1060708@pobox.com> <355e5e5e050928124651ba8947@mail.gmail.com>
In-Reply-To: <355e5e5e050928124651ba8947@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> No.  ata_device_add returns nonzero on success; so say the docs. 

Whoops, you're right.  I forget it was special.


> Since the return value is not checked here, and whether on success or
> failure all of the data structures allocated in that method stick
> around, I assumed that something was in the works for this.  I'll
> change this to kfree(hp) on returning 0.  Please advise if I should do
> something else.

It still needs to clean up after pdc_host_init()...

	Jeff


