Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265810AbUFDPey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUFDPey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUFDPey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:34:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28886 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265810AbUFDPev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:34:51 -0400
Message-ID: <40C0968D.50009@pobox.com>
Date: Fri, 04 Jun 2004 11:34:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jasper Spaans <jasper@vs19.net>
CC: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: how to fix timestamps in bk repo?
References: <20040604081926.GA24427@spaans.vs19.net>
In-Reply-To: <20040604081926.GA24427@spaans.vs19.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jasper Spaans wrote:
> Hi Larry,
> 
> Is it possible to reset the (BK-)timestamps on the following files in the
> http://linus.bkbits.net:8080/linux-2.5 repository? Somehow, they've gotten a
> timestamp which lies in the future, causing lots of warnings when I use a bk
> exported tree.
> 
> ./drivers/base/class.c
> ./drivers/pci/hotplug/rpaphp_pci.c
> ./drivers/pci/hotplug/rpaphp_slot.c
> ./drivers/pci/hotplug/rpaphp_vio.c
> ./include/linux/kobject.h
> ./lib/kobject.c


Sounds like a local problem.  I bet this will fix it:
	ntpdate time.nist.gov
	bk -r clean
	bk -r co -q

The timestamps on checked-out files are not generated from any BitKeeper 
metadata, but instead reflect the machine's system time when the file 
was checked out.

	Jeff


