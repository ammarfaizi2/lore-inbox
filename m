Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUDGQd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUDGQd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:33:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45761 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263735AbUDGQdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:33:55 -0400
Message-ID: <40742D63.4000803@pobox.com>
Date: Wed, 07 Apr 2004 12:33:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
CC: alpm@odsl.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss updates for 2.6.6xxx [1/2]
References: <D4CFB69C345C394284E4B78B876C1CF105BC200E@cceexc23.americas.cpqcorp.net>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF105BC200E@cceexc23.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miller, Mike (OS Dev) wrote:
> Yep, you're right. I just regurgitated the same code. I'll pull my head out and try again :(


The easiest thing to do may be to take your patch #1, and then add code 
to clamp the per-queue outstanding-command (tag) depth to
	1024 / n_arrays_found

at initialization time.  Or perhaps s/n_arrays_found/max_arrays_per_hba/

I bet that's just a few additional lines of code, and should work...

Regards,

	Jeff



