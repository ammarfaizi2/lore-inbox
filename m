Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWHHWOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWHHWOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWHHWOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:14:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:60301 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030315AbWHHWOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:14:10 -0400
Message-ID: <44D90CA9.1040807@pobox.com>
Date: Tue, 08 Aug 2006 18:14:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linville@tuxdriver.com
Subject: Re: [RFC: -mm patch] bcm43xx_main.c: remove 3 functions
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <20060807210415.GO3691@stusta.de> <200608082032.38365.mb@bu3sch.de>
In-Reply-To: <200608082032.38365.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> On Monday 07 August 2006 23:04, Adrian Bunk wrote:
>> This patch removes three no longer used functions (that are even 
>> generating gcc warnings).
>>
>> This patch doesn't look right, but it is the result of 
>> 58e5528ee464d38040b9489e10033c9387a10d56 in git-netdev...
> 
> Hm, can't find that commit in a tree.
> I looked at linus', netdev-2.6.

It's clearly in netdev-2.6.git#upstream:

commit 58e5528ee464d38040b9489e10033c9387a10d56
Author: Michael Buesch <mb@bu3sch.de>
Date:   Sat Jul 8 22:02:18 2006 +0200

     [PATCH] bcm43xx: init routine rewrite

     Rewrite of the bcm43xx initialization routines.
     This fixes several issues:
     * up-down-up-down-up... stale data issue
       (May fix some DHCP issues)
     * Fix the init vs IRQ handler race (and remove the workaround)
     * Fix init for cards with multiple cores (APHY)
       As softmac has no internal PHY handling (unlike dscape),
       this adds the file "phymode" to sysfs.
       The active PHY can be selected by writing either a, b or g
       to this file. Current PHY can be determined by reading from it.
     * Fix the controller restart code.
       Controller restart can now also be triggered through
       echo 1 > /debug/bcm43xx/ethX/restart

     Signed-off-by: Michael Buesch <mb@bu3sch.de>
     Signed-off-by: John W. Linville <linville@tuxdriver.com>

