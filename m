Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbWFTIwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWFTIwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWFTIwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:52:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15069 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965071AbWFTIwO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:52:14 -0400
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
	underruns, USB HDD hard resets)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       hal@lists.freedesktop.org
In-Reply-To: <20060620013741.8e0e4a22.akpm@osdl.org>
References: <20060619082154.GA17129@rhlx01.fht-esslingen.de>
	 <20060620013741.8e0e4a22.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Jun 2006 10:06:56 +0100
Message-Id: <1150794417.11062.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-20 am 01:37 -0700, ysgrifennodd Andrew Morton:
> [hald polling causes cdrecord to go bad on a USB CD drive]
> 
> One possible reason is that we're shooting down the device's pagecache by
> accident as a result of hald activity. 

On IDE hal causes problems with some drives because the additional
commands sent while the drive is busy end up timing out which triggers a
bus reset and breaks everything. Really HAL should have better manners
than to poll a drive that is busy.

Alan

