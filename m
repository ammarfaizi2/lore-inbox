Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWEBAGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWEBAGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 20:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWEBAGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 20:06:19 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:32423 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932330AbWEBAGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 20:06:18 -0400
In-Reply-To: <200605020150.14152.arnd@arndb.de>
References: <20060429232812.825714000@localhost.localdomain> <F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org> <445690F7.5050605@am.sony.com> <200605020150.14152.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org>
Cc: cbe-oss-dev@ozlabs.org, Geoff Levand <geoffrey.levand@am.sony.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Tue, 2 May 2006 02:06:10 +0200
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  config SPIDER_NET
>>  	tristate "Spider Gigabit Ethernet driver"
>> -	depends on PCI && PPC_CELL
>> +	depends on PCI && PPC_IBM_CELL_BLADE
>>  	select FW_LOADER
>>  	help
>>  	  This driver supports the Gigabit Ethernet chips present on the
>
> Hmm, I'm also no longer sure if this is right. In theory, spidernet
> could be used in all sorts of products, wether they are using the
> same bridge chip or just the gigabit ethernet macro from it.
>
> For now, I guess you can just leave this one alone if you respin
> the patch another time. It's disabled by default, so the dependency
> can be updated the next time we get a user in _addition_ to PPC_CELL.

Is there any reason the driver wouldn't build and/or run on other
platforms?  If so, fix it.  If not, just make it

	depends on PCI

?


Segher

