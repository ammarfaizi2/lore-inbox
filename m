Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbTDCUfj 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263558AbTDCUfj 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:35:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13531 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263555AbTDCUfi 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 15:35:38 -0500
Message-ID: <3E8C9DDD.3080205@pobox.com>
Date: Thu, 03 Apr 2003 15:47:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Dennis Cook <cook@sandgate.com>
CC: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Deactivating TCP checksumming
References: <F91mkXMUIhAumscmKC00000f517@hotmail.com> <20030401122824.GY29167@mea-ext.zmailer.org> <b6fda2$oec$1@main.gmane.org> <20030402203653.GA2503@gtf.org> <b6fi8m$j4g$1@main.gmane.org> <20030402205855.GA4125@gtf.org> <b6i5t1$h0t$1@main.gmane.org>
In-Reply-To: <b6i5t1$h0t$1@main.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis Cook wrote:
> Based on various feedback, on my RH Linux 2.4.18 kernel I tried the
> following:
> 
> Set "features" bit NETIF_F_IP_CSUM set (the only feature bit set).
> In my network driver start-transmit check for "CHECKSUM_HW" in ip_summed.
> Using a small test program, use "sendfile" to copy a file to a network
> socket FD.
> Result is none of the packets presented to my network adapter driver have
> ip_summed set to CHECKSUM_HW, so the SW IP stack has already
> computed checksums.

CHECKSUM_HW is for receive, not transmit.  Read the comments at the top 
of include/linux/skbuff.h.


> Is this mechanism possibly broken on kernel 2.4?


it works quite well.

	Jeff


