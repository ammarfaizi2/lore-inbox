Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUCIWWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUCIWWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:22:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52669 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261821AbUCIWWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:22:34 -0500
Message-ID: <404E439E.8020604@pobox.com>
Date: Tue, 09 Mar 2004 17:22:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike.miller@hp.com
CC: axboe@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: per device queues for cciss 2.6.0
References: <20040309170320.GA20073@beardog.cca.cpqcorp.net>
In-Reply-To: <20040309170320.GA20073@beardog.cca.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikem@beardog.cca.cpqcorp.net wrote:
> This is resubmission of yesterdays patch. It adds support for per logical device queues in the cciss driver. I have clarified that we only use one lock for all queues and it is held as specified in ll_rw_block.c. The locking needs to be redone for maximum efficiency but schedules don't permit that work at this time. This was done to fix an Oops with multiple logical volumes on a controller.
> Please consider this patch for inclusion.


Is the hardware's command buffer per-device or per-HBA?

	Jeff



