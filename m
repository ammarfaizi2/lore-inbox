Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbTLRA6C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 19:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264889AbTLRA6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 19:58:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49093 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264887AbTLRA6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 19:58:00 -0500
Message-ID: <3FE0FB87.4000105@pobox.com>
Date: Wed, 17 Dec 2003 19:57:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, mikem@beardog.cca.cpqcorp.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       mike.miller@hp.com, scott.benesh@hp.com
Subject: Re: cciss update for 2.4.24-pre1, 2 of 2
References: <Pine.LNX.4.58.0312161750290.30010@beardog.cca.cpqcorp.net>	<20031217225007.GN2495@suse.de> <20031217154919.6ab61960.akpm@osdl.org>
In-Reply-To: <20031217154919.6ab61960.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It will still be a busy loop if this task has a signal pending. 
> TASK_UNINTERRUPTIBLE may be more appropriate...


Agreed.  Same reason you want to use down() instead of 
down_interruptible(), when using a semaphore to wait on some hardware 
condition.

	Jeff



