Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264168AbTE0VGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTE0VGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:06:30 -0400
Received: from 200-184-71-82.chies.com.br ([200.184.71.82]:26258 "EHLO
	mars.elipse.com.br") by vger.kernel.org with ESMTP id S264168AbTE0VGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:06:03 -0400
Message-ID: <3ED3D6D5.6060305@elipse.com.br>
Date: Tue, 27 May 2003 18:21:25 -0300
From: Felipe W Damasio <felipewd@elipse.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Gutko <gutko@poczta.onet.pl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Realtek 8139c - kernel 2.4.21-rc3
References: <3ECFF85D.2090009@poczta.onet.pl>
In-Reply-To: <3ECFF85D.2090009@poczta.onet.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 21:21:29.0046 (UTC) FILETIME=[EFEC1760:01C32495]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Gutko,

Gutko wrote:
> Just compiled this kernel with 8139too as module. I have adsl (pppoe) 
> connection. Problem is, connection is lost after about 2-5 minutes after 
> start.
> I tested eth card with ftp://ftp.scyld.com/pub/diag/rtl8139-diag.c
> and found something like this "configured with ABNORMAL settings".Or 

	Were you forcing full-duplex or 100mbps?

> something like this. So I downloaded driver (v1.01)from www.realtek.com.tw,
> replaced 8139too module and now all semms to be ok.

	AFAIK, the driver from www.realtek.com.tw *is* 8139too.

> This diag tool says now : "configured with normal settings"

	Yep, it doesn't seem to be a driver problem, but forcing a buggy 
configuration to the driver.

	What probably happened is that when you downloaded the driver from 
the Realtek website, the modules.conf part of this "new" driver (or 
some other script you might be using to load it) isn't forcing any 
options and letting the driver figure out the best configuration.

	Kind Regards,

Felipe

