Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUJLRe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUJLRe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUJLRG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:06:28 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:29379 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266236AbUJLRCq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:02:46 -0400
Message-ID: <416C0DC5.2080206@rtr.ca>
Date: Tue, 12 Oct 2004 13:00:53 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@i	nfradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165A4	5D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca>	<4	165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca>		<20041007221537.A17712@infradead.org>	<1097241583.2412.15.camel@mulgrave> 	<4166AF2F.6070904@rtr.ca> <1097249266.1678.40.camel@mulgrave> 	<4166B37D.8030701@rtr.ca> <1097251299.1928.56.camel@mulgrave>
In-Reply-To: <1097251299.1928.56.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Fri, 2004-10-08 at 10:34, Mark Lord wrote:
> 
>>If those locks are not needed, the scsi.c maintainer really should
>>nuke'em.
> 
> I think you can safely assume he has more important things to do.

I was actually working on the assumption that the lock might be
there because it is/was necessary for something, like perhaps protecting
access to the add_timer()/del_timer() calls associated with the scmd?

If not, no issue -- it can be removed from the driver.

Cheers
--
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
