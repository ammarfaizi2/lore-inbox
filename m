Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVCISqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVCISqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVCISm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:42:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:63655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262210AbVCISlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:41:40 -0500
Date: Wed, 9 Mar 2005 10:40:55 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Daniel Staaf <dst@bostream.nu>,
       LKML <linux-kernel@vger.kernel.org>,
       Andrei Mikhailovsky <andrei@arhont.com>,
       Ian Campbell <icampbell@arcom.com>,
       Ronald Bultje <rbultje@ronald.bitfreak.net>,
       Gerd Knorr <kraxel@bytesex.org>, stable@kernel.org
Subject: Re: [PATCH 2.6] Fix i2c messsage flags in video drivers
Message-ID: <20050309184055.GX28536@shell0.pdx.osdl.net>
References: <1110024688.5494.2.camel@whale.core.arhont.com> <422A5473.7030306@osdl.org> <1110115990.5611.2.camel@whale.core.arhont.com> <422CCBF4.1060902@osdl.org> <20050308201504.6aee36d5.khali@linux-fr.org> <20050308202530.2fbfae9a.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308202530.2fbfae9a.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jean Delvare (khali@linux-fr.org) wrote:
> Hi all,
> 
> While working on the saa7110 driver I found a problem with the way
> various video drivers (found on Zoran-based boards) prepare i2c messages
> to be used by i2c_transfer. The drivers improperly copy the i2c client
> flags as the message flags, while both sets are mostly unrelated. The
> net effect in this case is to trigger an I2C block read instead of the
> expected I2C block write. The fix is simply not to pass any flag,
> because none are needed.
> 
> I think this patch qualifies hands down as a "critical bug fix" to be
> included in whatever bug-fix-only trees exist these days. As far as I
> can see, all Zoran-based boards are broken in 2.6.11 without this patch.

Are people reporting this as a problem?

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
