Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267001AbUBMUoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267090AbUBMUoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:44:20 -0500
Received: from devil.servak.biz ([209.124.81.2]:40134 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S267001AbUBMUoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:44:19 -0500
Subject: Re: [BKPATCH] Fix for "Badness in kobject_get" (affected ieee1394)
From: Torrey Hoffman <thoffman@arnor.net>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       greg@kroah.com, Linux-Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040212145706.GB639@phunnypharm.org>
References: <20040212145706.GB639@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1076705441.6645.1.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 13 Feb 2004 12:50:41 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-12 at 06:57, Ben Collins wrote:
> This seems to have only affected ieee1394 because it uses
> bus_for_each_dev in a particular (although correct) way.
[...]
> ChangeSet@1.1634, 2004-02-12 09:51:06-05:00, bcollins@debian.org
>   [DRV/BASE]: Put checks in bus_for_each_{dev,drv} to make sure we don't go past the end of the list.


Thanks, I applied this on top of 2.6.3-rc2-mm1 and it fixed my crash at
boot problem.  I'll do more extensive testing of the 1394 subsystem
later today.

-- 
Torrey Hoffman <thoffman@arnor.net>

