Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUIOCly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUIOCly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 22:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUIOCly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 22:41:54 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:13977 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266304AbUIOClA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 22:41:00 -0400
Message-ID: <4147AB5A.4060804@rtr.ca>
Date: Tue, 14 Sep 2004 22:39:22 -0400
From: Mark Lord <lsml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
References: <41471163.10709@rtr.ca>  <414723B0.1090600@pobox.com> <1095186343.2008.29.camel@mulgrave>
In-Reply-To: <1095186343.2008.29.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Actually, its only wrong in queuecommand because that can be called in
 >softirq context.
 >
 >Sleeping in the eh paths is fine (as long as you drop the locks that the
 >EH thread has uselessly taken for you).

Good, that's how I understood it as well.

But the locking is certainly a mess as-is in the QStor driver.
Sure, it is actually all technically correct, but hard to follow.

I believe I can remove nearly all of it and really tidy things up
as a result.

Thanks guys, this has been really helpful so far.
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
