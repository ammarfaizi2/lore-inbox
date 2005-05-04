Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVEDKNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVEDKNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 06:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVEDKNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 06:13:52 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:63952 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261584AbVEDKNu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 06:13:50 -0400
Date: Wed, 4 May 2005 12:07:11 +0200 (CEST)
To: ladis@linux-mips.org
Subject: Re: [PATCH] ds1337 3/3
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <Ky47NT3d.1115201231.3150830.khali@localhost>
In-Reply-To: <20050504061438.GD1439@orphique>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>,
       "James Chapman" <jchapman@katalix.com>, "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ladislav, hi all,

> Chip is searched by bus number rather than its own proprietary id.

Yes, I think it makes much more sense (especially since the proprietary
id was not known by anyone outside of the ds1337 driver).

I think I understand that ds1337_do_command() will be called from some
other kernel driver. Why isn't it exported then? I'd expect:
EXPORT_SYMBOL(ds1337_do_command);
next to the end of the ds1337 driver. Maybe it would also make sense to
have a ds1337.h header file declaring this function?

Additionally, I would welcome an additional patch documenting the fact
that the ds1337 driver will work fine with the Dallas DS1339 real-time
clock chip.

Thanks,
--
Jean Delvare
