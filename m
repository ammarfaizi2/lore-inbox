Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266111AbTLaEeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 23:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266112AbTLaEeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 23:34:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36801 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266111AbTLaEeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 23:34:13 -0500
Message-ID: <3FF251B1.4070404@pobox.com>
Date: Tue, 30 Dec 2003 23:33:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kthread_create
References: <20031231042016.958DC2C04B@lists.samba.org>
In-Reply-To: <20031231042016.958DC2C04B@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Hi all,
> 
> 	Ingo read through this before and liked it: this is the basis
> of the Hotplug CPU patch, and as such has been stressed fairly well.
> Tested stand-alone, and included here for wider review.


Hey, this is pretty cool.

Recalling threads from LKML past, there are two mechanisms I (and some 
others) felt were missing from the equally nifty workqueue stuff:
1) one-shot threads
2) keventd overflow

For #1, your patch seems to cover that nicely.

For #2, that's to be used for situations where (a) you need a thread 
context _and_ (b) you simply cannot wait for keventd to become available 
(since there are no time guarantees).

Anyway, thanks for doing this, it fills a need, I believe.

	Jeff



