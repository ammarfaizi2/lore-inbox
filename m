Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVCaIct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVCaIct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 03:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVCaIct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 03:32:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52888 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261189AbVCaI3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 03:29:46 -0500
Message-ID: <424BB4EA.6080506@pobox.com>
Date: Thu, 31 Mar 2005 03:29:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yum Rayan <yum.rayan@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce stack usage in sys.c
References: <df35dfeb05033023445c386d2d@mail.gmail.com>
In-Reply-To: <df35dfeb05033023445c386d2d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yum Rayan wrote:
> Attempt to reduce stack usage in sys.c (linux-2.6.12-rc1-mm3). Stack
> usage was noted using checkstack.pl. Specifically
> 
> Before patch
> ------------
> sys_reboot - 256
> 
> After patch
> -----------
> sys_reboot - none (register usage only)
> 
> Along the way, wrap code to 80 column width and cleanup lock usage.

Your "cleanup lock usage" increases the number of lock_kernel() calls 
quite a bit, which is not really a cleanup but simply bloat.

Seperate out your patches; don't sneak these supposed-cleanups into 
stack uage patches.

	Jeff



