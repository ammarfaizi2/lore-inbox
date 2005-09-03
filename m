Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVICGiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVICGiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 02:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVICGiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 02:38:09 -0400
Received: from mail.dvmed.net ([216.237.124.58]:18396 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751388AbVICGiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 02:38:08 -0400
Message-ID: <431944C8.5070205@pobox.com>
Date: Sat, 03 Sep 2005 02:38:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkosewsk@gmail.com
CC: Ravi Wijayaratne <ravi_wija@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Hotswap support for libata
References: <20050902224418.78897.qmail@web32512.mail.mud.yahoo.com>	 <355e5e5e05090223231726b94a@mail.gmail.com> <355e5e5e05090223259e47cf6@mail.gmail.com>
In-Reply-To: <355e5e5e05090223259e47cf6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> On a happier note, once the infrastructure is accepted, anyone with a
> hotswap-unsupported controller and some time on their hands will
> easily be able to integrate hotswap in; that is the whole goal of an
> infrastructure.  So if your controller isn't supported, but you know
> something about it (or better yet, you yourself have docs), adding
> hotswap support to it should be too hard.

Once the infrastructure is there, I'll probably add support for several 
controllers myself.  Many controllers don't have an explicit hotplug 
interrupt, but rather we must examine the PhyRdy bit in the standard 
SError register for details.  If the bit's state changes in any way 
(including two or more state changes), we (a) check for device presence, 
and (b) if device is present, initialize it (SET FEATURES - XFER MODE, 
etc.).

	Jeff



