Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbUC0XMT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 18:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUC0XMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 18:12:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8115 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261925AbUC0XMQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 18:12:16 -0500
Message-ID: <40660A3D.3020300@pobox.com>
Date: Sat, 27 Mar 2004 18:11:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40660877.3090302@stesmi.com>
In-Reply-To: <40660877.3090302@stesmi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:
> What will happen when a PATA disk lies behind a Marvel(ous) bridge, as
> in most SATA disks today?

Larger transfers work fine in PATA, too.

WRT bridges, it is generally the best idea to limit to UDMA/100 (udma), 
but larger transfers are OK.


> Is large transfers mandatory in the LBA48 spec and is LBA48 really
> mandatory in SATA?

Yes and no, in that order :)  SATA doesn't mandate lba48, but it is 
highly unlikely that you will see SATA disk without lba48.

Regardless, libata supports what the drive supports.  Older disks still 
work just fine.

	Jeff



