Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267945AbUJGUih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267945AbUJGUih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268141AbUJGUiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:38:07 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:55997 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267945AbUJGUg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:36:29 -0400
Message-ID: <4165A85D.7080704@rtr.ca>
Date: Thu, 07 Oct 2004 16:34:37 -0400
From: Mark Lord <lsml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <lkml@rtr.ca>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <416547B6.5080505@rtr.ca> <20041007150709.B12688@infradead.org> <4165624C.5060405@rtr.ca> <416565DB.4050006@pobox.com> <4165A45D.2090200@rtr.ca> <4165A766.1040104@pobox.com>
In-Reply-To: <4165A766.1040104@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Overall, I don't see why it is so damned difficult to delete the hooks 
> then add them back when they _are_ needed.  I would certainly support 
> you in that effort.

Okay, that can work.

Except that the hooks ARE needed NOW.

Right NOW, there is a programmer working on the RAID management
interface, and he needs those hooks (or something similar)
to compile and test his code against the driver.

Remember, the vendor wants to decouple the RAID management from
the in-tree kernel code.  They fully want to open-source (GPL)
all of it, but in two pieces:  (1) core driver to boot/run the system,
and (2) loadable component to provide advanced RAID management.

It is anticipated that development of (2) will take some time
and have many revisions, and they really want to decouple it's
release from that of the stock kernel.  Thus, the latest version
of that code will be provided via website and installation CD
to customers who actually buy/use the product.

I wonder if there's a better way to do this?
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
