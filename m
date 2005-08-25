Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbVHYWCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVHYWCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbVHYWCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:02:34 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:35852 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S964912AbVHYWCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:02:33 -0400
Date: Fri, 26 Aug 2005 00:02:31 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] drivers/hwmon/*: kfree() correct pointers
Message-Id: <20050826000231.35b97af9.khali@linux-fr.org>
In-Reply-To: <20050825214913.GA31605@mipter.zuzino.mipt.ru>
References: <20050825205629.22372.qmail@lwn.net>
	<20050825214913.GA31605@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

> The adm9240 driver, in adm9240_detect(), allocates a structure.  The
> error path attempts to kfree() ->client field of it (second one),
> resulting in an oops (or slab corruption) if the hardware is not
> present.
> 
> ->client field in adm1026, adm1031, smsc47b397 and smsc47m1 is the
> first in ${HWMON}_data structure, but fix them too.

Already fixed in Greg's i2c tree and -mm for quite some time now...

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-i2c/i2c-hwmon-class-01.patch

Thanks,
-- 
Jean Delvare
