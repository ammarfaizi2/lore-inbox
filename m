Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269503AbUINRXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269503AbUINRXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269581AbUINRUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:20:32 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:41624 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269540AbUINRQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:16:13 -0400
Message-ID: <414726FB.20703@rtr.ca>
Date: Tue, 14 Sep 2004 13:14:35 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
References: <41471163.10709@rtr.ca> <1095177622.16990.48.camel@localhost.localdomain>
In-Reply-To: <1095177622.16990.48.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Correct ioctl return is -ENOTTY for unknown (thats a mistake still in
> many existing drivers so no suprise its still being copied)

Quoting linux/Documentation/scsi_mid_low_api.txt:
*
*      Unfortunately some applications expect -EINVAL and react badly
*      when -ENOTTY is returned; stick with -EINVAL.

Looks like a documentation fix is needed then.

This is a hardware RAID device, with various graduations of sharing
possible between hardware and software.   It was originally written
pre-libata, and the RAID functionality in particular does not map
well to libata.  Nor do the host-queuing implementation and other features.

Thanks Alan.  I'll address the other points you brought up later.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
