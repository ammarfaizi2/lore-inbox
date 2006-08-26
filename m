Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWHZCvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWHZCvb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 22:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWHZCvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 22:51:31 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:42138
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751575AbWHZCva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 22:51:30 -0400
Message-ID: <44EFB6B2.205@microgate.com>
Date: Fri, 25 Aug 2006 21:49:22 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: drivers/char/synclink_gt.c: chars don't have more than 8 bits
References: <20060826020123.GB4765@stusta.de>
In-Reply-To: <20060826020123.GB4765@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The GNU C compiler (SVN version) spotted the following buggy code in 
> drivers/char/synclink_gt.c:
> ...
  > Since there are no bits 8 or 9 in a char this code is currently
> dead code.

Yes, that is a bug.

Status and data come in byte pairs, bits 9 and 8 are
referenced from the 16 bit combination.

The code is operating on individual bytes in the buffer,
so it should be bits 1 and 0 that are tested.

I will make a patch and post it.

Thanks,
Paul


