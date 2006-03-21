Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWCUMN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWCUMN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWCUMN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:13:59 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:19080 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751507AbWCUMN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:13:58 -0500
Date: Tue, 21 Mar 2006 13:13:54 +0100
From: Sander <sander@humilis.net>
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Message-ID: <20060321121354.GB24977@favonius>
Reply-To: sander@humilis.net
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603210000.36552.lkml@rtr.ca>
X-Uptime: 12:16:31 up 18 days, 16:26, 26 users,  load average: 3.42, 2.66, 2.45
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote (ao):
> This patch addresses a number of weird behaviours observed
> for the sata_mv driver, by fixing an "off by one" bug in processing
> of the EDMA response queue.
> 
> Basically, sata_mv was looking in the wrong place for
> command results, and this produced a lot of unpredictable behaviour.

2.6.16 with this patch and your former patch applied, crashes during
stressing a raid5 connected to a MV88SX6081.

2.6.16-rc6 crashes too.

2.6.16-rc6-mm2 is rock solid wrt sata_mv.

I get no output of the crash on netconsole. Would it help if I get the
output of the crash (if any)? In that case I'll connect a screen and see
what it produces.

I'll test 2.6.16-rc6-mm2 with your patches now.

I'll also try 2.6.16-rc6-mm1 to see if it is fixed between -rc6 and
-rc6-mm1, or between -rc6-mm1 and -rc6-mm2.

As soon as 2.6.16-mm1 comes out, I'll check to see if sata_mv still
works for me. Whatever fixes it should stay in :-)

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
