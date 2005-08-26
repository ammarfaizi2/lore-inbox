Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVHZHcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVHZHcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 03:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVHZHcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 03:32:21 -0400
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:22035 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750739AbVHZHcV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 03:32:21 -0400
Date: Fri, 26 Aug 2005 09:32:14 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] drivers/hwmon/*: kfree() correct pointers
Message-Id: <20050826093214.415f1987.khali@linux-fr.org>
In-Reply-To: <20050825235354.10376.qmail@lwn.net>
References: <20050826000231.35b97af9.khali@linux-fr.org>
	<20050825235354.10376.qmail@lwn.net>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

> > Already fixed in Greg's i2c tree and -mm for quite some time now...
> 
> So it is.  The comment says, however, that "the existing code works
> somewhat by accident."  In the case of the 9240 driver, however, the
> existing code demonstrably does not work - it oopsed on me.

I too did notice that the adm9240 case was worse than the four other
ones back then, but when I tried to get it to crash, it never did.  This
is the reason why I did not push this patch upstream faster.  I wonder
why it now does oops on you.

I also believe that this patch was somewhat misnamed.  It is not related
to the new hwmon class, but jut happened to change the same part of
these five drivers.  With a better name, the patch would most probably
have been selected by Greg in the last batch of i2c patches to Linus.

> The patch in Greg's tree looks fine (it's a straightforward fix, after
> all);

I wouldn't call it straightforward, but it certainly has been reviewed
and tested well enough by now to be considered safe.

> I'd recommend that it be merged before 2.6.13.

Fine with me.

Thanks,
-- 
Jean Delvare
