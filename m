Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUDPALl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 20:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUDPALl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 20:11:41 -0400
Received: from selene.LaTech.edu ([138.47.18.25]:31741 "EHLO LaTech.edu")
	by vger.kernel.org with ESMTP id S261913AbUDPALe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 20:11:34 -0400
Message-ID: <1082074290.407f24b21997c@webmail.LaTech.edu>
Date: Thu, 15 Apr 2004 19:11:30 -0500
From: Ryan Geoffrey Bourgeois <rgb005@latech.edu>
To: Simon Koch <koch0121@umn.edu>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: poor sata performance on 2.6 - Promise SX4
References: <200404150236.05894.kos@supportwizard.com> <1082001287.407e0787f3c48@webmail.LaTech.edu> <200404151455.36307.kos@supportwizard.com> <1082044297.407eaf894ddda@webmail.LaTech.edu> <407F1C07.6050104@umn.edu>
In-Reply-To: <407F1C07.6050104@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.8
X-Originating-IP: 138.47.118.132
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> What kernel/driver are you using for the S150 SX4?  I couldn't ever get 
> better than 13MB/sec from it in 2.6.  Of course, the last I tried was 
> 2.6.3.  I could get 55MB/sec using 2.4 and Promise's partial source 
> driver, but since my onboard SATA controller works fine in 2.6 I'm just 
> using that meanwhile.
> 
> Thanks,
>     Simon
> 

The performance isn't that great at the moment.  Poor driver support for the SX4
right now, as it's kinda the odd card in the lot.  The way it handles its
hardware RAID is kinda unique from what I've heard.  I'm using the sata_promise
driver on the 2.6.5 kernel.  In the works is supposed to be a separate driver
specifically for the SX4, which is the main reason I joined the linux-ide list
in the first place.  Due to the SX4's unique approach to hardware RAID5, there
is not yet a driver that supports RAID5 arrays on the controller, and so each
drive can only be accessed separately.  Thus I'm using Linux's software RAID5
for my three Western Digital 120gb drives (WD1200JD I think).  I got about
25mb/s read time on a drive connected to the controller.  It really is below
par, but it's getting the job done until we get a good driver.

-Ryan

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

