Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbUKONqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUKONqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 08:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUKONqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 08:46:34 -0500
Received: from blackhole.sk ([212.89.236.103]:44697 "EHLO
	blackhole.websupport.sk") by vger.kernel.org with ESMTP
	id S261600AbUKONqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 08:46:21 -0500
Date: Mon, 15 Nov 2004 14:46:15 +0100
From: stanojr@blackhole.websupport.sk
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: quota deadlock
Message-ID: <20041115134615.GA10269@blackhole.websupport.sk>
References: <20041112173118.GC17928@blackhole.websupport.sk> <20041115122050.GA1442@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115122050.GA1442@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i tried your patch using reiserfs and ext2 with 2.6.10-rc2 and it works like a charm :)
thanks
stanojr

On Mon, Nov 15, 2004 at 01:20:50PM +0100, Jan Kara wrote:
>   Hello,
> 
> > my english sucks, so i'll be brief.                        
> > heavy write access to partition with quota enabled causes deadlock. if
> > processes try to access the deadlocked partition they                    
> > simply have no response and cannot be killed with SIGKILL. i've been
> > testing with reiserfs and ext2 on 2.6.9 kernel.
>   Could you try attached patch? Can you reproduce the deadlock with it
> (if so, please send me the dump of the processes). The patch reworks
> substantially the locking and should solve the problems you observe.
> It is against current -linus tree but should probably apply well to
> 2.6.10-rc1. 
> 
> 						Thanks for testing
> 								Honza

