Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263683AbTDDOPC (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbTDDOJ4 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:09:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19894 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263681AbTDDOIv (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 09:08:51 -0500
Message-ID: <3E8D94C4.1020802@pobox.com>
Date: Fri, 04 Apr 2003 09:20:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Dennis Cook <cook@sandgate.com>
CC: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Deactivating TCP checksumming
References: <IJEHKLJHMGFNGKMEBBFNMEIICBAA.cook@sandgate.com>
In-Reply-To: <IJEHKLJHMGFNGKMEBBFNMEIICBAA.cook@sandgate.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis Cook wrote:
> In the 3c59x.c, e1000, and other adapter drivers, ip_summed is
> what is being checked for value CHECKSUM_HW when sending
> a packet.


Yep; my mistake on that one.

Regardless, Ion and Manish picked up on what you were missed - the 
NETIF_F_SG bit.  And if your hardware can do 64-bit DMA, you'll want to 
set NETIF_F_HIGHDMA too.

	Jeff



