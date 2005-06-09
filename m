Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVFIUdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVFIUdp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 16:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVFIUdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 16:33:45 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:49557 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262460AbVFIUdn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 16:33:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l5z6T3bzA8TScib1PUn+vZQNkFKP8NfBlNIDUjt3qmJ/n5c6llMqytRJpaxvmGGxMgZwIfQW7eUxLupxirDwpZdj7QA6SJBXRDvr4PSULjDVHDUXZqk1n4pLztLpqfX2uRe/xynSE+Gj0RNHX/B9sDvApqvsivhjXzyAfQjR0dQ=
Message-ID: <58cb370e050609133375ffdfb4@mail.gmail.com>
Date: Thu, 9 Jun 2005 22:33:42 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Vincent C Jones <vcjones@networkingunlimited.com>
Subject: Re: Linux v2.6.12-rc6 -- PCMCIA IDE oops
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050609153019.2BE75219C1@X31.networkingunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4cun0-5ok-7@gated-at.bofh.it>
	 <20050609153019.2BE75219C1@X31.networkingunlimited.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/05, Vincent C Jones <vcjones@networkingunlimited.com> wrote:

> PCMCIA still seems to have problems dealing with compact flash. Log
> follows:

earlier messages got lost somehow...

> Jun  9 11:01:04 X31 kernel: hde: lost interrupt

...

> Jun  9 11:17:10 X31 kernel: Call Trace:
> Jun  9 11:17:10 X31 kernel:  [<c026c0c7>] elevator_exit+0x27/0x40
> Jun  9 11:17:10 X31 kernel:  [<c026eb6c>] blk_cleanup_queue+0x7c/0x90
> Jun  9 11:17:10 X31 kernel:  [<c028a843>] drive_release_dev+0x53/0xb0
> Jun  9 11:17:10 X31 hal-subfs-mount[16318]: Mount point /media/idedisk can't get removed!
> Jun  9 11:17:10 X31 kernel:  [<c0266bb6>] device_release+0x56/0x60
> Jun  9 11:17:10 X31 kernel:  [<c02166d7>] kobject_cleanup+0x97/0xa0
> Jun  9 11:17:10 X31 kernel:  [<c02166e0>] kobject_release+0x0/0x10
> Jun  9 11:17:10 X31 kernel:  [<c0217068>] kref_put+0x38/0xb0
> Jun  9 11:17:10 X31 kernel:  [<c026709f>] device_del+0x6f/0x90
> Jun  9 11:17:10 X31 kernel:  [<c0282f41>] ide_unregister+0x251/0x360

ide_unregister() and co. still needs much work to be 100% race-safe

Bartlomiej
