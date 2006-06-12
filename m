Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWFLRNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWFLRNn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWFLRNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:13:43 -0400
Received: from khc.piap.pl ([195.187.100.11]:26045 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751140AbWFLRNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:13:42 -0400
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [PATCH] I2C: i2c_bit_add_bus should initialize SDA and SCL lines
References: <m34pyyz0e1.fsf@defiant.localdomain>
	<20060609110546.GA26073@jupiter.solarsys.private>
	<m3lks4k5od.fsf@defiant.localdomain>
	<20060612123626.GA27429@jupiter.solarsys.private>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 12 Jun 2006 19:13:38 +0200
In-Reply-To: <20060612123626.GA27429@jupiter.solarsys.private> (Mark M. Hoffman's message of "Mon, 12 Jun 2006 08:36:26 -0400")
Message-ID: <m3hd2q47r1.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Mark M. Hoffman" <mhoffman@lightlink.com> writes:

> If you can't read the line state... well, that's not actually a proper
> I2C bus anyway.

Actually you only have to be able to read SDA state, it might not be
true WRT SCL. I think most implementations use a single master and
a fixed access timing and thus only read SDA (SCL can as well be
a simple 2-state normal output from master instead of open
drain/collector or 3-state).

I'm not sure initializing the bus (in terms of ~ handshaking)
belongs to hw driver and not to the algorithm but such is live.

Thanks.
-- 
Krzysztof Halasa
